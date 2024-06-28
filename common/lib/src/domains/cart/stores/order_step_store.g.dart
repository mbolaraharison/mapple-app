// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_step_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStepStore on _OrderStepStoreBase, Store {
  Computed<bool>? _$isSubmittableComputed;

  @override
  bool get isSubmittable =>
      (_$isSubmittableComputed ??= Computed<bool>(() => super.isSubmittable,
              name: '_OrderStepStoreBase.isSubmittable'))
          .value;
  Computed<bool>? _$isCleaningRelatedComputed;

  @override
  bool get isCleaningRelated => (_$isCleaningRelatedComputed ??= Computed<bool>(
          () => super.isCleaningRelated,
          name: '_OrderStepStoreBase.isCleaningRelated'))
      .value;
  Computed<double>? _$cleaningRelatedTotalComputed;

  @override
  double get cleaningRelatedTotal => (_$cleaningRelatedTotalComputed ??=
          Computed<double>(() => super.cleaningRelatedTotal,
              name: '_OrderStepStoreBase.cleaningRelatedTotal'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: '_OrderStepStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$orderRowsAtom =
      Atom(name: '_OrderStepStoreBase.orderRows', context: context);

  @override
  ObservableList<OrderRow> get orderRows {
    _$orderRowsAtom.reportRead();
    return super.orderRows;
  }

  @override
  set orderRows(ObservableList<OrderRow> value) {
    _$orderRowsAtom.reportWrite(value, super.orderRows, () {
      super.orderRows = value;
    });
  }

  late final _$isEnergyRelatedAtom =
      Atom(name: '_OrderStepStoreBase.isEnergyRelated', context: context);

  @override
  bool get isEnergyRelated {
    _$isEnergyRelatedAtom.reportRead();
    return super.isEnergyRelated;
  }

  @override
  set isEnergyRelated(bool value) {
    _$isEnergyRelatedAtom.reportWrite(value, super.isEnergyRelated, () {
      super.isEnergyRelated = value;
    });
  }

  late final _$removeOrderRowByIndexAsyncAction = AsyncAction(
      '_OrderStepStoreBase.removeOrderRowByIndex',
      context: context);

  @override
  Future<void> removeOrderRowByIndex(int index) {
    return _$removeOrderRowByIndexAsyncAction
        .run(() => super.removeOrderRowByIndex(index));
  }

  late final _$addOrderRowAsyncAction =
      AsyncAction('_OrderStepStoreBase.addOrderRow', context: context);

  @override
  Future<void> addOrderRow(OrderRow orderRow) {
    return _$addOrderRowAsyncAction.run(() => super.addOrderRow(orderRow));
  }

  late final _$updateOrderRowAsyncAction =
      AsyncAction('_OrderStepStoreBase.updateOrderRow', context: context);

  @override
  Future<void> updateOrderRow(OrderRow orderRow) {
    return _$updateOrderRowAsyncAction
        .run(() => super.updateOrderRow(orderRow));
  }

  late final _$applyDiscountAsyncAction =
      AsyncAction('_OrderStepStoreBase.applyDiscount', context: context);

  @override
  Future<void> applyDiscount(List<OrderRow> rows) {
    return _$applyDiscountAsyncAction.run(() => super.applyDiscount(rows));
  }

  late final _$applySuppliersAsyncAction =
      AsyncAction('_OrderStepStoreBase.applySuppliers', context: context);

  @override
  Future<void> applySuppliers(List<OrderRow> rows) {
    return _$applySuppliersAsyncAction.run(() => super.applySuppliers(rows));
  }

  late final _$removeDiscountAsyncAction =
      AsyncAction('_OrderStepStoreBase.removeDiscount', context: context);

  @override
  Future<void> removeDiscount(OrderRow row) {
    return _$removeDiscountAsyncAction.run(() => super.removeDiscount(row));
  }

  late final _$getIsCleaningRelatedAsyncAction =
      AsyncAction('_OrderStepStoreBase.getIsCleaningRelated', context: context);

  @override
  Future<bool> getIsCleaningRelated(List<OrderRow> orderRows) {
    return _$getIsCleaningRelatedAsyncAction
        .run(() => super.getIsCleaningRelated(orderRows));
  }

  late final _$getIsEnergyRelatedAsyncAction =
      AsyncAction('_OrderStepStoreBase.getIsEnergyRelated', context: context);

  @override
  Future<bool> getIsEnergyRelated() {
    return _$getIsEnergyRelatedAsyncAction
        .run(() => super.getIsEnergyRelated());
  }

  late final _$initAsyncAction =
      AsyncAction('_OrderStepStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$loadAndWatchOrderRowsAsyncAction = AsyncAction(
      '_OrderStepStoreBase.loadAndWatchOrderRows',
      context: context);

  @override
  Future<void> loadAndWatchOrderRows() {
    return _$loadAndWatchOrderRowsAsyncAction
        .run(() => super.loadAndWatchOrderRows());
  }

  late final _$_OrderStepStoreBaseActionController =
      ActionController(name: '_OrderStepStoreBase', context: context);

  @override
  void setOrderRows(List<OrderRow> value) {
    final _$actionInfo = _$_OrderStepStoreBaseActionController.startAction(
        name: '_OrderStepStoreBase.setOrderRows');
    try {
      return super.setOrderRows(value);
    } finally {
      _$_OrderStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
orderRows: ${orderRows},
isEnergyRelated: ${isEnergyRelated},
isSubmittable: ${isSubmittable},
isCleaningRelated: ${isCleaningRelated},
cleaningRelatedTotal: ${cleaningRelatedTotal}
    ''';
  }
}
