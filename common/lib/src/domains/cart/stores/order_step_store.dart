import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'order_step_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class OrderStepStoreInterface {
  OrderStepStoreInterface._(
    this.orderRows,
    this.isEnergyRelated,
    this.isLoading,
  );

  ObservableList<OrderRow> orderRows;

  bool isEnergyRelated;

  bool isLoading;

  double get cleaningRelatedTotal;

  bool get isSubmittable;

  bool get isCleaningRelated;

  Future<void> addOrderRow(OrderRow orderRow);

  Future<void> updateOrderRow(OrderRow orderRow);

  Future<void> removeDiscount(OrderRow row);

  Future<void> removeOrderRowByIndex(int index);

  Future<void> applyDiscount(List<OrderRow> rows);

  Future<void> applySuppliers(List<OrderRow> rows);

  void dispose();
}

// Params:----------------------------------------------------------------------
class OrderStepStoreParams {
  OrderStepStoreParams({
    required this.customerOrderStore,
  });

  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class OrderStepStore = _OrderStepStoreBase with _$OrderStepStore;

abstract class _OrderStepStoreBase
    with Store
    implements OrderStepStoreInterface {
  _OrderStepStoreBase({required OrderStepStoreParams params})
      : customerOrderStore = params.customerOrderStore {
    init();
  }

  final CustomerOrderStoreInterface customerOrderStore;

  // Subscriptions:--------------------------------------------------------------
  StreamSubscription<List<OrderRow>>? _orderRowsSubscription;
  ReactionDisposer? _orderReactionDisposer;

  // Services:------------------------------------------------------------------
  late final OrderRowServiceInterface _orderRowService =
      getIt<OrderRowServiceInterface>();
  late final ServiceServiceInterface _serviceService =
      getIt<ServiceServiceInterface>();
  late final ServiceSubFamilyServiceInterface _serviceSubFamilyService =
      getIt<ServiceSubFamilyServiceInterface>();
  late final ServiceFamilyServiceInterface _serviceFamilyService =
      getIt<ServiceFamilyServiceInterface>();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  bool isLoading = false;

  @override
  @observable
  ObservableList<OrderRow> orderRows = ObservableList();

  @override
  @observable
  bool isEnergyRelated = false;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get isSubmittable {
    return orderRows.isNotEmpty &&
        orderRows.every((OrderRow orderRow) {
          return !orderRow.isReadonly;
        });
  }

  @override
  @computed
  bool get isCleaningRelated {
    for (final OrderRow orderRow in orderRows) {
      Service? service = orderRow.service;
      if (service != null && service.isCleaning) {
        return true;
      }
    }
    return false;
  }

  @override
  @computed
  double get cleaningRelatedTotal {
    double cleaningTotal = 0;
    List<OrderRow> cleaningRows = orderRows.where((element) {
      return element.service!.isCleaning;
    }).toList();

    for (final OrderRow row in cleaningRows) {
      double rowTotalNetInclTax = row.totalNetInclTax;
      cleaningTotal += rowTotalNetInclTax;
    }
    return cleaningTotal;
  }

  // Actions:-------------------------------------------------------------------
  @action
  void setOrderRows(List<OrderRow> value) {
    orderRows = ObservableList.of(value);
  }

  @override
  @action
  Future<void> removeOrderRowByIndex(int index) async {
    bool wasAlreadyCleaningRelated = isCleaningRelated;
    await _orderRowService.delete(orderRows[index]);
    List<OrderRow> fetchedOrderRows =
        await _orderRowService.getByOrderId(customerOrderStore.order.id);
    bool isNowCleaningRelated = await getIsCleaningRelated(fetchedOrderRows);
    if (wasAlreadyCleaningRelated == true && isNowCleaningRelated == false) {
      customerOrderStore.order.intermediatePaymentPercentage = 0;
      customerOrderStore.paymentStepStore.intermediatePaymentPercentage =
          customerOrderStore.order.intermediatePaymentPercentage;
    }
    customerOrderStore.order.setShouldRecreateEnvelope(true);
    await customerOrderStore.resetCartStatus();
  }

  @override
  @action
  Future<void> addOrderRow(OrderRow orderRow) async {
    await _orderRowService.create(orderRow);
    customerOrderStore.order.setShouldRecreateEnvelope(true);
    customerOrderStore.updateOrder();
  }

  @override
  @action
  Future<void> updateOrderRow(OrderRow orderRow) async {
    await _orderRowService.update(orderRow);
    await customerOrderStore.signatureStepStore.setShouldRecreateEnvelope(true);
  }

  @override
  @action
  Future<void> applyDiscount(List<OrderRow> rows) async {
    for (var element in rows) {
      final int index =
          orderRows.indexWhere((OrderRow service) => service.id == element.id);
      orderRows[index] = element;
      await _orderRowService.update(orderRows[index]);
    }
    if (rows.isNotEmpty) {
      customerOrderStore.order.setShouldRecreateEnvelope(true);
    }
    await customerOrderStore.resetCartStatus();
  }

  @override
  @action
  Future<void> applySuppliers(List<OrderRow> rows) async {
    for (var element in rows) {
      final int index =
          orderRows.indexWhere((OrderRow service) => service.id == element.id);
      orderRows[index] = element;
      await _orderRowService.update(orderRows[index]);
    }
    if (rows.isNotEmpty) {
      customerOrderStore.order.setShouldRecreateEnvelope(true);
    }
    await customerOrderStore.resetCartStatus();
  }

  @override
  @action
  Future<void> removeDiscount(OrderRow row) async {
    final int index =
        orderRows.indexWhere((OrderRow service) => service.id == row.id);
    OrderRow newRow = row.copyWith(
      discount: () => null,
      discountCodeId: () => null,
    );
    orderRows[index] = newRow;
    await _orderRowService.update(newRow);
    customerOrderStore.order.setShouldRecreateEnvelope(true);
    await customerOrderStore.resetCartStatus();
  }

  @action
  Future<bool> getIsCleaningRelated(List<OrderRow> orderRows) async {
    for (final OrderRow orderRow in orderRows) {
      await orderRow.loadData(eager: true);
      if (orderRow.service != null && orderRow.service!.isCleaning) {
        return true;
      }
    }
    return false;
  }

  @action
  Future<bool> getIsEnergyRelated() async {
    for (final OrderRow orderRow in orderRows) {
      Service? service = await _serviceService.getById(orderRow.serviceId);
      if (service != null) {
        ServiceSubFamily? subFamily =
            await _serviceSubFamilyService.getById(service.subFamilyId);
        if (subFamily != null) {
          ServiceFamily? family =
              await _serviceFamilyService.getById(subFamily.familyId);
          if (family != null) {
            if (family.isEnergyRelated == true) {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
    return false;
  }

  // Methods:-------------------------------------------------------------------
  @action
  Future<void> init() async {
    await loadAndWatchOrderRows();
    // watch order
    _orderReactionDisposer?.reaction.dispose();
    _orderReactionDisposer = reaction(
      (_) => customerOrderStore.order,
      (Order? order) async {
        await loadAndWatchOrderRows();
      },
    );
  }

  @action
  Future<void> loadAndWatchOrderRows() async {
    // first load
    setOrderRows(customerOrderStore.order.orderRows);
    for (int i = 0; i < orderRows.length; i++) {
      await orderRows[i].loadData(eager: true);
    }
    isEnergyRelated = await getIsEnergyRelated();
    // then watch
    _orderRowsSubscription?.cancel();
    _orderRowsSubscription = _orderRowService
        .getByOrderIdAsStream(customerOrderStore.order.id, eager: true)
        .listen((List<OrderRow> rows) async {
      setOrderRows(rows);
      isEnergyRelated = await getIsEnergyRelated();
    });
  }

  @override
  void dispose() {
    _orderRowsSubscription?.cancel();
    _orderReactionDisposer?.reaction.dispose();
  }
}
