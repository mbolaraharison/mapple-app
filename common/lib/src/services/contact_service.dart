import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ContactServiceInterface {
  Future<void> create(Contact item, {bool applyToFirestore = true});

  Future<List<Contact>> getByCustomerId(String customerId,
      {bool eager = false, List<Type> flow = const []});

  Stream<List<Contact>> getByCustomerIdAsStream(String customerId,
      {bool eager = false, List<Type> flow = const []});

  Stream<List<Contact>> getByOrderIdAsStream(String orderId,
      {bool eager = false, List<Type> flow = const []});

  Future<List<Contact>> getByOrderId(String orderId,
      {bool eager = false, List<Type> flow = const []});

  Future<void> delete(Contact item, {bool applyToFirestore = true});

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});

  Future<Contact?> getById(String id);

  Future<List<Contact>> getByIds(List<String> ids);

  Stream<List<Contact>> getByIdsAsStream(List<String> ids,
      {bool eager = false, List<Type> flow = const []});
}

// Implementation:--------------------------------------------------------------
class ContactService
    extends AbstractModelService<Contact, $ContactsTable, AgencyDatabase>
    implements ContactServiceInterface {
  ContactService()
      : super(getIt<ContactDriftDao>(), getIt<ContactFirestoreDao>());

  // Methods:-------------------------------------------------------------------
  @override
  Future<List<Contact>> getByCustomerId(String customerId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Contact> contacts =
        await (localDao as ContactDriftDao).findByCustomerId(customerId);
    if (eager) {
      for (int i = 0; i < contacts.length; i++) {
        await contacts[i].loadData(eager: eager, flow: flow);
      }
    }
    return contacts;
  }

  @override
  Stream<List<Contact>> getByCustomerIdAsStream(String customerId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Contact>> contactsStream = (localDao as ContactDriftDao)
        .findByCustomerIdAsStream(customerId)
        .transform(streamTransformerUtils
            .getListResultDriftStreamOptimizer<Contact>());
    if (eager) {
      contactsStream = contactsStream.asyncMap((List<Contact> contacts) async {
        for (int i = 0; i < contacts.length; i++) {
          await contacts[i].loadData(eager: eager, flow: flow);
        }
        return contacts;
      });
    }
    return contactsStream;
  }

  @override
  Future<List<Contact>> getByOrderId(String orderId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Contact> contacts =
        await (localDao as ContactDriftDao).findByOrderId(orderId);
    if (eager) {
      for (int i = 0; i < contacts.length; i++) {
        await contacts[i].loadData(eager: eager, flow: flow);
      }
    }
    return contacts;
  }

  @override
  Stream<List<Contact>> getByOrderIdAsStream(String orderId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Contact>> contactsStream =
        (localDao as ContactDriftDao).findByOrderIdAsStream(orderId);
    if (eager) {
      contactsStream = contactsStream.asyncMap((List<Contact> contacts) async {
        for (int i = 0; i < contacts.length; i++) {
          await contacts[i].loadData(eager: eager, flow: flow);
        }
        return contacts;
      });
    }
    return contactsStream;
  }

  @override
  Stream<List<Contact>> getByIdsAsStream(List<String> ids,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Contact>> contactsStream = super.getByIdsAsStream(ids);

    if (eager) {
      contactsStream = contactsStream.asyncMap((List<Contact> contacts) async {
        for (int i = 0; i < contacts.length; i++) {
          await contacts[i].loadData(eager: eager, flow: flow);
        }
        return contacts;
      });
    }
    return contactsStream;
  }
}
