import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';
import 'package:geocoding/geocoding.dart';

// Interface:-------------------------------------------------------------------
abstract class OrderServiceInterface {
  Future<List<Order>> getAll();

  Future<List<Order>> getByCustomerId(String customerId,
      {bool eager = false, List<Type> flow = const []});

  Stream<List<Order>> getByCustomerIdAsStream(String customerId,
      {bool eager = false, List<Type> flow = const []});

  Future<Order?> getById(String id,
      {bool eager = false, List<Type> flow = const []});

  Stream<Order?> getByIdAsStream(String id,
      {bool eager = false, List<Type> flow = const []});

  Future<GeoPoint?> getLocation(Order order);

  Future<List<Order>> getByCustomerIdByStatus(
      String customerId, OrderStatus status,
      {bool eager = false, List<Type> flow = const []});

  Future<void> create(Order item,
      {bool applyToFirestore = true, bool onlyToFirestore = false});

  Future<void> update(Order item, {bool applyToFirestore = true});

  Future<void> deleteContact(Order order, Contact contact,
      {bool applyToFirestore = true});

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class OrderService
    extends AbstractModelService<Order, $OrdersTable, AgencyDatabase>
    implements OrderServiceInterface {
  OrderService() : super(getIt<OrderDriftDao>(), getIt<OrderFirestoreDao>());

  // DAOs:---------------------------------------------------------------------
  final OrderContactDriftDao _orderContactDao = getIt<OrderContactDriftDao>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<Order?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    Order? order = await super.getById(id);
    if (eager && order != null) {
      await order.loadData(eager: eager, flow: flow);
    }
    return order;
  }

  @override
  Stream<Order?> getByIdAsStream(String id,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<Order?> orderStream = localDao.findByIdAsStream(id);
    if (eager) {
      orderStream = orderStream.asyncMap((Order? order) async {
        if (order != null) {
          await order.loadData(eager: eager);
        }
        return order;
      });
    }
    return orderStream.transform(
        streamTransformerUtils.getSingleResultDriftStreamOptimizer<Order>());
  }

  @override
  Future<List<Order>> getByCustomerId(String customerId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Order> orders =
        await (localDao as OrderDriftDao).findByCustomerId(customerId);
    if (eager) {
      for (int i = 0; i < orders.length; i++) {
        await orders[i].loadData(eager: eager, flow: flow);
      }
    }
    return orders;
  }

  @override
  Stream<List<Order>> getByCustomerIdAsStream(String customerId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Order>> ordersStream =
        (localDao as OrderDriftDao).findByCustomerIdAsStream(customerId);
    if (eager) {
      ordersStream = ordersStream.asyncMap((List<Order> orders) async {
        for (int i = 0; i < orders.length; i++) {
          await orders[i].loadData(eager: eager, flow: flow);
        }
        return orders;
      });
    }
    return ordersStream.transform(
        streamTransformerUtils.getListResultDriftStreamOptimizer<Order>());
  }

  @override
  Future<List<Order>> getByCustomerIdByStatus(
      String customerId, OrderStatus status,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Order> orders = await (localDao as OrderDriftDao)
        .findByCustomerIdByStatus(customerId, status);

    if (eager) {
      for (int i = 0; i < orders.length; i++) {
        await orders[i].loadData(eager: eager, flow: flow);
      }
    }

    return orders;
  }

  @override
  Future<GeoPoint?> getLocation(Order order) async {
    try {
      List locations = await locationFromAddress(order.formattedAddress);
      if (locations.isEmpty) {
        return null;
      }
      GeoPoint geoPoint =
          GeoPoint(locations[0].latitude, locations[0].longitude);
      order.location = geoPoint;
      order.locationAlreadyFetched = true;
      await update(order);

      return geoPoint;
    } on NoResultFoundException {
      order.locationAlreadyFetched = true;
      await update(order);

      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  @override
  Future<void> create(Order item,
      {bool applyToFirestore = true, bool onlyToFirestore = false}) async {
    await super.create(item,
        applyToFirestore: applyToFirestore, onlyToFirestore: onlyToFirestore);

    // (Re)create contacts
    final orderContacts = item.contacts.map((String contactId) =>
        OrderContact(orderId: item.id, contactId: contactId));
    await localDao.batch((batch) {
      batch = _orderContactDao.batchReplaceAllByOrderId(
          batch, item.id, orderContacts.toList());
    });
  }

  @override
  Future<void> update(Order item, {bool applyToFirestore = true}) async {
    await super.update(item, applyToFirestore: applyToFirestore);

    // (Re)create contacts
    final orderContacts = item.contacts.map((String contactId) =>
        OrderContact(orderId: item.id, contactId: contactId));

    await localDao.batch((batch) {
      batch = _orderContactDao.batchReplaceAllByOrderId(
          batch, item.id, orderContacts.toList());
    });
  }

  @override
  Future<void> delete(Order item,
      {bool applyToFirestore = true, bool softDelete = false}) async {
    // Delete contacts if exist
    await localDao.batch((batch) {
      batch = _orderContactDao.batchDeleteByOrderId(batch, item.id);
    });

    await super.delete(item,
        applyToFirestore: applyToFirestore, softDelete: softDelete);
  }

  @override
  Future<void> onDataChange(List<DocumentChange<Order>> changes,
      {int batchSize = 100}) async {
    final futures = <Future>[];
    for (int i = 0; i < changes.length; i += batchSize) {
      final endIndex = min(i + batchSize, changes.length);
      final batchDocChanges = changes.sublist(i, endIndex);

      // batch firestore
      final batchFuture = localDao.batch((batch) {
        for (var change in batchDocChanges) {
          final doc = change.doc;
          final data = doc.data() as Order;
          switch (change.type) {
            case DocumentChangeType.added:
              batch = _createSync(batch, data);
              break;
            case DocumentChangeType.modified:
              batch = _updateSync(batch, data);
              break;
            case DocumentChangeType.removed:
              batch = _deleteSync(batch, data);
              break;
          }
        }
      });

      futures.add(batchFuture);
    }

    await Future.wait(futures);
  }

  @override
  Future<void> deleteContact(Order order, Contact contact,
      {bool applyToFirestore = true}) async {
    // check if contact is used in multiple orders
    final orders = await _orderContactDao.findByContactId(contact.id);
    if (orders.length > 1) {
      return;
    }
    // delete in sqlite
    await _orderContactDao.deleteByOrderIdAndContactId(order.id, contact.id);
    order.contacts.remove(contact.id);
    await update(order, applyToFirestore: applyToFirestore);
  }

  Batch _createSync(Batch batch, Order order) {
    batch = localDao.daoBatchCreateOrUpdate(batch, order);

    // (Re)create contacts
    final orderContacts = order.contacts.map((String contactId) =>
        OrderContact(orderId: order.id, contactId: contactId));
    batch = _orderContactDao.batchReplaceAllByOrderId(
        batch, order.id, orderContacts.toList());
    return batch;
  }

  Batch _updateSync(Batch batch, Order order) {
    batch = localDao.daoBatchUpdate(batch, order);

    // (Re)create contacts
    final orderContacts = order.contacts.map((String contactId) =>
        OrderContact(orderId: order.id, contactId: contactId));
    batch = _orderContactDao.batchReplaceAllByOrderId(
        batch, order.id, orderContacts.toList());
    return batch;
  }

  Batch _deleteSync(Batch batch, Order order) {
    // Delete contacts if exist
    batch = _orderContactDao.batchDeleteByOrderId(batch, order.id);

    batch = localDao.daoBatchDelete(batch, order);

    return batch;
  }
}
