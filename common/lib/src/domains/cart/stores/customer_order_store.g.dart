// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerOrderStore on _CustomerOrderStoreBase, Store {
  Computed<bool>? _$canGoNextComputed;

  @override
  bool get canGoNext =>
      (_$canGoNextComputed ??= Computed<bool>(() => super.canGoNext,
              name: '_CustomerOrderStoreBase.canGoNext'))
          .value;

  late final _$orderAtom =
      Atom(name: '_CustomerOrderStoreBase.order', context: context);

  @override
  Order get order {
    _$orderAtom.reportRead();
    return super.order;
  }

  @override
  set order(Order value) {
    _$orderAtom.reportWrite(value, super.order, () {
      super.order = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CustomerOrderStoreBase.isLoading', context: context);

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

  late final _$stepAtom =
      Atom(name: '_CustomerOrderStoreBase.step', context: context);

  @override
  int get step {
    _$stepAtom.reportRead();
    return super.step;
  }

  @override
  set step(int value) {
    _$stepAtom.reportWrite(value, super.step, () {
      super.step = value;
    });
  }

  late final _$activeStepAtom =
      Atom(name: '_CustomerOrderStoreBase.activeStep', context: context);

  @override
  int get activeStep {
    _$activeStepAtom.reportRead();
    return super.activeStep;
  }

  @override
  set activeStep(int value) {
    _$activeStepAtom.reportWrite(value, super.activeStep, () {
      super.activeStep = value;
    });
  }

  late final _$percentageAtom =
      Atom(name: '_CustomerOrderStoreBase.percentage', context: context);

  @override
  double get percentage {
    _$percentageAtom.reportRead();
    return super.percentage;
  }

  @override
  set percentage(double value) {
    _$percentageAtom.reportWrite(value, super.percentage, () {
      super.percentage = value;
    });
  }

  late final _$setNextStepAsyncAction =
      AsyncAction('_CustomerOrderStoreBase.setNextStep', context: context);

  @override
  Future<void> setNextStep(BuildContext context) {
    return _$setNextStepAsyncAction.run(() => super.setNextStep(context));
  }

  late final _$initOrderRowsAsyncAction =
      AsyncAction('_CustomerOrderStoreBase.initOrderRows', context: context);

  @override
  Future<void> initOrderRows() {
    return _$initOrderRowsAsyncAction.run(() => super.initOrderRows());
  }

  late final _$setCartStatusAsyncAction =
      AsyncAction('_CustomerOrderStoreBase.setCartStatus', context: context);

  @override
  Future<void> setCartStatus(CartStatus status) {
    return _$setCartStatusAsyncAction.run(() => super.setCartStatus(status));
  }

  late final _$setOrderFormFileDataIdAsyncAction = AsyncAction(
      '_CustomerOrderStoreBase.setOrderFormFileDataId',
      context: context);

  @override
  Future<void> setOrderFormFileDataId(String value, {bool withUpdate = true}) {
    return _$setOrderFormFileDataIdAsyncAction
        .run(() => super.setOrderFormFileDataId(value, withUpdate: withUpdate));
  }

  late final _$setTermsDocumentFileDataIdAsyncAction = AsyncAction(
      '_CustomerOrderStoreBase.setTermsDocumentFileDataId',
      context: context);

  @override
  Future<void> setTermsDocumentFileDataId(String value) {
    return _$setTermsDocumentFileDataIdAsyncAction
        .run(() => super.setTermsDocumentFileDataId(value));
  }

  late final _$setVatCertificateFileDataIdAsyncAction = AsyncAction(
      '_CustomerOrderStoreBase.setVatCertificateFileDataId',
      context: context);

  @override
  Future<void> setVatCertificateFileDataId(String value) {
    return _$setVatCertificateFileDataIdAsyncAction
        .run(() => super.setVatCertificateFileDataId(value));
  }

  late final _$setFairIdAsyncAction =
      AsyncAction('_CustomerOrderStoreBase.setFairId', context: context);

  @override
  Future<void> setFairId(String value) {
    return _$setFairIdAsyncAction.run(() => super.setFairId(value));
  }

  late final _$updateOrderAsyncAction =
      AsyncAction('_CustomerOrderStoreBase.updateOrder', context: context);

  @override
  Future<void> updateOrder() {
    return _$updateOrderAsyncAction.run(() => super.updateOrder());
  }

  late final _$resetCartStatusAsyncAction =
      AsyncAction('_CustomerOrderStoreBase.resetCartStatus', context: context);

  @override
  Future<void> resetCartStatus() {
    return _$resetCartStatusAsyncAction.run(() => super.resetCartStatus());
  }

  late final _$initAsyncAction =
      AsyncAction('_CustomerOrderStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_CustomerOrderStoreBaseActionController =
      ActionController(name: '_CustomerOrderStoreBase', context: context);

  @override
  void initStep() {
    final _$actionInfo = _$_CustomerOrderStoreBaseActionController.startAction(
        name: '_CustomerOrderStoreBase.initStep');
    try {
      return super.initStep();
    } finally {
      _$_CustomerOrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep(int value) {
    final _$actionInfo = _$_CustomerOrderStoreBaseActionController.startAction(
        name: '_CustomerOrderStoreBase.setStep');
    try {
      return super.setStep(value);
    } finally {
      _$_CustomerOrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActiveStep({required int value, required BuildContext context}) {
    final _$actionInfo = _$_CustomerOrderStoreBaseActionController.startAction(
        name: '_CustomerOrderStoreBase.setActiveStep');
    try {
      return super.setActiveStep(value: value, context: context);
    } finally {
      _$_CustomerOrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void watchOrder() {
    final _$actionInfo = _$_CustomerOrderStoreBaseActionController.startAction(
        name: '_CustomerOrderStoreBase.watchOrder');
    try {
      return super.watchOrder();
    } finally {
      _$_CustomerOrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
order: ${order},
isLoading: ${isLoading},
step: ${step},
activeStep: ${activeStep},
percentage: ${percentage},
canGoNext: ${canGoNext}
    ''';
  }
}
