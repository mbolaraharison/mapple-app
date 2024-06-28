// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_step_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaymentStepStore on _PaymentStepStoreBase, Store {
  Computed<List<SelectChoice<int>>>? _$intermediatePaymentChoicesComputed;

  @override
  List<SelectChoice<int>> get intermediatePaymentChoices =>
      (_$intermediatePaymentChoicesComputed ??=
              Computed<List<SelectChoice<int>>>(
                  () => super.intermediatePaymentChoices,
                  name: '_PaymentStepStoreBase.intermediatePaymentChoices'))
          .value;
  Computed<double>? _$totalWithDepositDeductedComputed;

  @override
  double get totalWithDepositDeducted => (_$totalWithDepositDeductedComputed ??=
          Computed<double>(() => super.totalWithDepositDeducted,
              name: '_PaymentStepStoreBase.totalWithDepositDeducted'))
      .value;
  Computed<String>? _$formattedTotalWithDepositDeductedComputed;

  @override
  String get formattedTotalWithDepositDeducted =>
      (_$formattedTotalWithDepositDeductedComputed ??= Computed<String>(
              () => super.formattedTotalWithDepositDeducted,
              name: '_PaymentStepStoreBase.formattedTotalWithDepositDeducted'))
          .value;
  Computed<String>? _$formattedIntermediatePaymentPercentageComputed;

  @override
  String get formattedIntermediatePaymentPercentage =>
      (_$formattedIntermediatePaymentPercentageComputed ??= Computed<String>(
              () => super.formattedIntermediatePaymentPercentage,
              name:
                  '_PaymentStepStoreBase.formattedIntermediatePaymentPercentage'))
          .value;
  Computed<int?>? _$endOfWorksPaymentPercentageComputed;

  @override
  int? get endOfWorksPaymentPercentage =>
      (_$endOfWorksPaymentPercentageComputed ??= Computed<int?>(
              () => super.endOfWorksPaymentPercentage,
              name: '_PaymentStepStoreBase.endOfWorksPaymentPercentage'))
          .value;
  Computed<String>? _$formattedEndOfWorksPaymentPercentageComputed;

  @override
  String get formattedEndOfWorksPaymentPercentage =>
      (_$formattedEndOfWorksPaymentPercentageComputed ??= Computed<String>(
              () => super.formattedEndOfWorksPaymentPercentage,
              name:
                  '_PaymentStepStoreBase.formattedEndOfWorksPaymentPercentage'))
          .value;
  Computed<double>? _$depositPercentageComputed;

  @override
  double get depositPercentage => (_$depositPercentageComputed ??=
          Computed<double>(() => super.depositPercentage,
              name: '_PaymentStepStoreBase.depositPercentage'))
      .value;
  Computed<double>? _$cleaningRelatedTotalWithDepositComputed;

  @override
  double get cleaningRelatedTotalWithDeposit =>
      (_$cleaningRelatedTotalWithDepositComputed ??= Computed<double>(
              () => super.cleaningRelatedTotalWithDeposit,
              name: '_PaymentStepStoreBase.cleaningRelatedTotalWithDeposit'))
          .value;
  Computed<double?>? _$computedIntermediatePaymentAmountComputed;

  @override
  double? get computedIntermediatePaymentAmount =>
      (_$computedIntermediatePaymentAmountComputed ??= Computed<double?>(
              () => super.computedIntermediatePaymentAmount,
              name: '_PaymentStepStoreBase.computedIntermediatePaymentAmount'))
          .value;
  Computed<String>? _$formattedIntermediatePaymentAmountComputed;

  @override
  String get formattedIntermediatePaymentAmount =>
      (_$formattedIntermediatePaymentAmountComputed ??= Computed<String>(
              () => super.formattedIntermediatePaymentAmount,
              name: '_PaymentStepStoreBase.formattedIntermediatePaymentAmount'))
          .value;
  Computed<double?>? _$computedEndOfWorksPaymentAmountComputed;

  @override
  double? get computedEndOfWorksPaymentAmount =>
      (_$computedEndOfWorksPaymentAmountComputed ??= Computed<double?>(
              () => super.computedEndOfWorksPaymentAmount,
              name: '_PaymentStepStoreBase.computedEndOfWorksPaymentAmount'))
          .value;
  Computed<String>? _$formattedEndOfWorksPaymentAmountComputed;

  @override
  String get formattedEndOfWorksPaymentAmount =>
      (_$formattedEndOfWorksPaymentAmountComputed ??= Computed<String>(
              () => super.formattedEndOfWorksPaymentAmount,
              name: '_PaymentStepStoreBase.formattedEndOfWorksPaymentAmount'))
          .value;
  Computed<bool>? _$depositAmountIsInvalidComputed;

  @override
  bool get depositAmountIsInvalid => (_$depositAmountIsInvalidComputed ??=
          Computed<bool>(() => super.depositAmountIsInvalid,
              name: '_PaymentStepStoreBase.depositAmountIsInvalid'))
      .value;
  Computed<bool>? _$monthlyPaymentsCountIsInvalidComputed;

  @override
  bool get monthlyPaymentsCountIsInvalid =>
      (_$monthlyPaymentsCountIsInvalidComputed ??= Computed<bool>(
              () => super.monthlyPaymentsCountIsInvalid,
              name: '_PaymentStepStoreBase.monthlyPaymentsCountIsInvalid'))
          .value;
  Computed<bool>? _$creditTotalCostIsInvalidComputed;

  @override
  bool get creditTotalCostIsInvalid => (_$creditTotalCostIsInvalidComputed ??=
          Computed<bool>(() => super.creditTotalCostIsInvalid,
              name: '_PaymentStepStoreBase.creditTotalCostIsInvalid'))
      .value;
  Computed<bool>? _$monthlyPaymentAmountIsInvalidComputed;

  @override
  bool get monthlyPaymentAmountIsInvalid =>
      (_$monthlyPaymentAmountIsInvalidComputed ??= Computed<bool>(
              () => super.monthlyPaymentAmountIsInvalid,
              name: '_PaymentStepStoreBase.monthlyPaymentAmountIsInvalid'))
          .value;
  Computed<bool>? _$nominalRateIsInvalidComputed;

  @override
  bool get nominalRateIsInvalid => (_$nominalRateIsInvalidComputed ??=
          Computed<bool>(() => super.nominalRateIsInvalid,
              name: '_PaymentStepStoreBase.nominalRateIsInvalid'))
      .value;
  Computed<bool>? _$aprIsInvalidComputed;

  @override
  bool get aprIsInvalid =>
      (_$aprIsInvalidComputed ??= Computed<bool>(() => super.aprIsInvalid,
              name: '_PaymentStepStoreBase.aprIsInvalid'))
          .value;
  Computed<bool>? _$isSubmittableComputed;

  @override
  bool get isSubmittable =>
      (_$isSubmittableComputed ??= Computed<bool>(() => super.isSubmittable,
              name: '_PaymentStepStoreBase.isSubmittable'))
          .value;
  Computed<bool>? _$hasChangesComputed;

  @override
  bool get hasChanges =>
      (_$hasChangesComputed ??= Computed<bool>(() => super.hasChanges,
              name: '_PaymentStepStoreBase.hasChanges'))
          .value;

  late final _$intermediatePaymentPercentageAtom = Atom(
      name: '_PaymentStepStoreBase.intermediatePaymentPercentage',
      context: context);

  @override
  int? get intermediatePaymentPercentage {
    _$intermediatePaymentPercentageAtom.reportRead();
    return super.intermediatePaymentPercentage;
  }

  @override
  set intermediatePaymentPercentage(int? value) {
    _$intermediatePaymentPercentageAtom
        .reportWrite(value, super.intermediatePaymentPercentage, () {
      super.intermediatePaymentPercentage = value;
    });
  }

  late final _$intermediatePaymentAmountAtom = Atom(
      name: '_PaymentStepStoreBase.intermediatePaymentAmount',
      context: context);

  @override
  double? get intermediatePaymentAmount {
    _$intermediatePaymentAmountAtom.reportRead();
    return super.intermediatePaymentAmount;
  }

  @override
  set intermediatePaymentAmount(double? value) {
    _$intermediatePaymentAmountAtom
        .reportWrite(value, super.intermediatePaymentAmount, () {
      super.intermediatePaymentAmount = value;
    });
  }

  late final _$endOfWorksPaymentAmountAtom = Atom(
      name: '_PaymentStepStoreBase.endOfWorksPaymentAmount', context: context);

  @override
  double? get endOfWorksPaymentAmount {
    _$endOfWorksPaymentAmountAtom.reportRead();
    return super.endOfWorksPaymentAmount;
  }

  @override
  set endOfWorksPaymentAmount(double? value) {
    _$endOfWorksPaymentAmountAtom
        .reportWrite(value, super.endOfWorksPaymentAmount, () {
      super.endOfWorksPaymentAmount = value;
    });
  }

  late final _$creditTotalCostAtom =
      Atom(name: '_PaymentStepStoreBase.creditTotalCost', context: context);

  @override
  double? get creditTotalCost {
    _$creditTotalCostAtom.reportRead();
    return super.creditTotalCost;
  }

  @override
  set creditTotalCost(double? value) {
    _$creditTotalCostAtom.reportWrite(value, super.creditTotalCost, () {
      super.creditTotalCost = value;
    });
  }

  late final _$depositAmountAtom =
      Atom(name: '_PaymentStepStoreBase.depositAmount', context: context);

  @override
  double? get depositAmount {
    _$depositAmountAtom.reportRead();
    return super.depositAmount;
  }

  @override
  set depositAmount(double? value) {
    _$depositAmountAtom.reportWrite(value, super.depositAmount, () {
      super.depositAmount = value;
    });
  }

  late final _$insuranceTypeAtom =
      Atom(name: '_PaymentStepStoreBase.insuranceType', context: context);

  @override
  InsuranceType? get insuranceType {
    _$insuranceTypeAtom.reportRead();
    return super.insuranceType;
  }

  @override
  set insuranceType(InsuranceType? value) {
    _$insuranceTypeAtom.reportWrite(value, super.insuranceType, () {
      super.insuranceType = value;
    });
  }

  late final _$monthlyPaymentAmountAtom = Atom(
      name: '_PaymentStepStoreBase.monthlyPaymentAmount', context: context);

  @override
  double? get monthlyPaymentAmount {
    _$monthlyPaymentAmountAtom.reportRead();
    return super.monthlyPaymentAmount;
  }

  @override
  set monthlyPaymentAmount(double? value) {
    _$monthlyPaymentAmountAtom.reportWrite(value, super.monthlyPaymentAmount,
        () {
      super.monthlyPaymentAmount = value;
    });
  }

  late final _$monthlyPaymentsCountAtom = Atom(
      name: '_PaymentStepStoreBase.monthlyPaymentsCount', context: context);

  @override
  int? get monthlyPaymentsCount {
    _$monthlyPaymentsCountAtom.reportRead();
    return super.monthlyPaymentsCount;
  }

  @override
  set monthlyPaymentsCount(int? value) {
    _$monthlyPaymentsCountAtom.reportWrite(value, super.monthlyPaymentsCount,
        () {
      super.monthlyPaymentsCount = value;
    });
  }

  late final _$nominalRateAtom =
      Atom(name: '_PaymentStepStoreBase.nominalRate', context: context);

  @override
  double? get nominalRate {
    _$nominalRateAtom.reportRead();
    return super.nominalRate;
  }

  @override
  set nominalRate(double? value) {
    _$nominalRateAtom.reportWrite(value, super.nominalRate, () {
      super.nominalRate = value;
    });
  }

  late final _$orderFormIdAtom =
      Atom(name: '_PaymentStepStoreBase.orderFormId', context: context);

  @override
  String? get orderFormId {
    _$orderFormIdAtom.reportRead();
    return super.orderFormId;
  }

  @override
  set orderFormId(String? value) {
    _$orderFormIdAtom.reportWrite(value, super.orderFormId, () {
      super.orderFormId = value;
    });
  }

  late final _$orderTypeAtom =
      Atom(name: '_PaymentStepStoreBase.orderType', context: context);

  @override
  String? get orderType {
    _$orderTypeAtom.reportRead();
    return super.orderType;
  }

  @override
  set orderType(String? value) {
    _$orderTypeAtom.reportWrite(value, super.orderType, () {
      super.orderType = value;
    });
  }

  late final _$originAtom =
      Atom(name: '_PaymentStepStoreBase.origin', context: context);

  @override
  Origin? get origin {
    _$originAtom.reportRead();
    return super.origin;
  }

  @override
  set origin(Origin? value) {
    _$originAtom.reportWrite(value, super.origin, () {
      super.origin = value;
    });
  }

  late final _$originDetailsAtom =
      Atom(name: '_PaymentStepStoreBase.originDetails', context: context);

  @override
  OriginDetails? get originDetails {
    _$originDetailsAtom.reportRead();
    return super.originDetails;
  }

  @override
  set originDetails(OriginDetails? value) {
    _$originDetailsAtom.reportWrite(value, super.originDetails, () {
      super.originDetails = value;
    });
  }

  late final _$paymentTermsAtom =
      Atom(name: '_PaymentStepStoreBase.paymentTerms', context: context);

  @override
  PaymentTerms? get paymentTerms {
    _$paymentTermsAtom.reportRead();
    return super.paymentTerms;
  }

  @override
  set paymentTerms(PaymentTerms? value) {
    _$paymentTermsAtom.reportWrite(value, super.paymentTerms, () {
      super.paymentTerms = value;
    });
  }

  late final _$defermentAtom =
      Atom(name: '_PaymentStepStoreBase.deferment', context: context);

  @override
  Deferment? get deferment {
    _$defermentAtom.reportRead();
    return super.deferment;
  }

  @override
  set deferment(Deferment? value) {
    _$defermentAtom.reportWrite(value, super.deferment, () {
      super.deferment = value;
    });
  }

  late final _$aprAtom =
      Atom(name: '_PaymentStepStoreBase.apr', context: context);

  @override
  double? get apr {
    _$aprAtom.reportRead();
    return super.apr;
  }

  @override
  set apr(double? value) {
    _$aprAtom.reportWrite(value, super.apr, () {
      super.apr = value;
    });
  }

  late final _$depositAmountControllerAtom = Atom(
      name: '_PaymentStepStoreBase.depositAmountController', context: context);

  @override
  TextEditingController? get depositAmountController {
    _$depositAmountControllerAtom.reportRead();
    return super.depositAmountController;
  }

  @override
  set depositAmountController(TextEditingController? value) {
    _$depositAmountControllerAtom
        .reportWrite(value, super.depositAmountController, () {
      super.depositAmountController = value;
    });
  }

  late final _$intermediatePaymentAmountControllerAtom = Atom(
      name: '_PaymentStepStoreBase.intermediatePaymentAmountController',
      context: context);

  @override
  TextEditingController? get intermediatePaymentAmountController {
    _$intermediatePaymentAmountControllerAtom.reportRead();
    return super.intermediatePaymentAmountController;
  }

  @override
  set intermediatePaymentAmountController(TextEditingController? value) {
    _$intermediatePaymentAmountControllerAtom
        .reportWrite(value, super.intermediatePaymentAmountController, () {
      super.intermediatePaymentAmountController = value;
    });
  }

  late final _$endOfWorksPaymentAmountControllerAtom = Atom(
      name: '_PaymentStepStoreBase.endOfWorksPaymentAmountController',
      context: context);

  @override
  TextEditingController? get endOfWorksPaymentAmountController {
    _$endOfWorksPaymentAmountControllerAtom.reportRead();
    return super.endOfWorksPaymentAmountController;
  }

  @override
  set endOfWorksPaymentAmountController(TextEditingController? value) {
    _$endOfWorksPaymentAmountControllerAtom
        .reportWrite(value, super.endOfWorksPaymentAmountController, () {
      super.endOfWorksPaymentAmountController = value;
    });
  }

  late final _$isCashPaymentAtom =
      Atom(name: '_PaymentStepStoreBase.isCashPayment', context: context);

  @override
  bool get isCashPayment {
    _$isCashPaymentAtom.reportRead();
    return super.isCashPayment;
  }

  @override
  set isCashPayment(bool value) {
    _$isCashPaymentAtom.reportWrite(value, super.isCashPayment, () {
      super.isCashPayment = value;
    });
  }

  late final _$isFinancingPaymentAtom =
      Atom(name: '_PaymentStepStoreBase.isFinancingPayment', context: context);

  @override
  bool get isFinancingPayment {
    _$isFinancingPaymentAtom.reportRead();
    return super.isFinancingPayment;
  }

  @override
  set isFinancingPayment(bool value) {
    _$isFinancingPaymentAtom.reportWrite(value, super.isFinancingPayment, () {
      super.isFinancingPayment = value;
    });
  }

  late final _$cashPaymentMethodAtom =
      Atom(name: '_PaymentStepStoreBase.cashPaymentMethod', context: context);

  @override
  CashPaymentMethod? get cashPaymentMethod {
    _$cashPaymentMethodAtom.reportRead();
    return super.cashPaymentMethod;
  }

  @override
  set cashPaymentMethod(CashPaymentMethod? value) {
    _$cashPaymentMethodAtom.reportWrite(value, super.cashPaymentMethod, () {
      super.cashPaymentMethod = value;
    });
  }

  late final _$financingPaymentMethodAtom = Atom(
      name: '_PaymentStepStoreBase.financingPaymentMethod', context: context);

  @override
  FinancingPaymentMethod? get financingPaymentMethod {
    _$financingPaymentMethodAtom.reportRead();
    return super.financingPaymentMethod;
  }

  @override
  set financingPaymentMethod(FinancingPaymentMethod? value) {
    _$financingPaymentMethodAtom
        .reportWrite(value, super.financingPaymentMethod, () {
      super.financingPaymentMethod = value;
    });
  }

  late final _$creditAmountAtom =
      Atom(name: '_PaymentStepStoreBase.creditAmount', context: context);

  @override
  double get creditAmount {
    _$creditAmountAtom.reportRead();
    return super.creditAmount;
  }

  @override
  set creditAmount(double value) {
    _$creditAmountAtom.reportWrite(value, super.creditAmount, () {
      super.creditAmount = value;
    });
  }

  late final _$saveAsyncAction =
      AsyncAction('_PaymentStepStoreBase.save', context: context);

  @override
  Future<bool> save(BuildContext context) {
    return _$saveAsyncAction.run(() => super.save(context));
  }

  late final _$_PaymentStepStoreBaseActionController =
      ActionController(name: '_PaymentStepStoreBase', context: context);

  @override
  void init() {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.init');
    try {
      return super.init();
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadData() {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.loadData');
    try {
      return super.loadData();
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentTerms(PaymentTerms value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setPaymentTerms');
    try {
      return super.setPaymentTerms(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDepositAmount(String value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setDepositAmount');
    try {
      return super.setDepositAmount(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIntermediatePaymentPercentage(int value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setIntermediatePaymentPercentage');
    try {
      return super.setIntermediatePaymentPercentage(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIntermediatePaymentAmount(String value, {bool save = false}) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setIntermediatePaymentAmount');
    try {
      return super.setIntermediatePaymentAmount(value, save: save);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIntermediatePaymentAmountController(
      TextEditingController? controller) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setIntermediatePaymentAmountController');
    try {
      return super.setIntermediatePaymentAmountController(controller);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndOfWorksPaymentAmount(String value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setEndOfWorksPaymentAmount');
    try {
      return super.setEndOfWorksPaymentAmount(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndOfWorksPaymentAmountController(TextEditingController? controller) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setEndOfWorksPaymentAmountController');
    try {
      return super.setEndOfWorksPaymentAmountController(controller);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void computeEndOfWorksPaymentAmount() {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.computeEndOfWorksPaymentAmount');
    try {
      return super.computeEndOfWorksPaymentAmount();
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void computeCreditAmount() {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.computeCreditAmount');
    try {
      return super.computeCreditAmount();
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInsuranceType(InsuranceType value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setInsuranceType');
    try {
      return super.setInsuranceType(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeferment(Deferment value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setDeferment');
    try {
      return super.setDeferment(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNominalRate(String value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setNominalRate');
    try {
      return super.setNominalRate(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfMonthlyPayments(String value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setNumberOfMonthlyPayments');
    try {
      return super.setNumberOfMonthlyPayments(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setApr(String value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setApr');
    try {
      return super.setApr(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCreditTotalCost(String value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setCreditTotalCost');
    try {
      return super.setCreditTotalCost(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMonthlyPaymentsAmount(String value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setMonthlyPaymentsAmount');
    try {
      return super.setMonthlyPaymentsAmount(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validatePaymentForm() {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.validatePaymentForm');
    try {
      return super.validatePaymentForm();
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDepositAmountController(TextEditingController? controller) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setDepositAmountController');
    try {
      return super.setDepositAmountController(controller);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsCashPayment(bool value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setIsCashPayment');
    try {
      return super.setIsCashPayment(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsFinancingPayment(bool value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setIsFinancingPayment');
    try {
      return super.setIsFinancingPayment(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCashPaymentMethod(CashPaymentMethod value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setCashPaymentMethod');
    try {
      return super.setCashPaymentMethod(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFinancingPaymentMethod(FinancingPaymentMethod value) {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.setFinancingPaymentMethod');
    try {
      return super.setFinancingPaymentMethod(value);
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkIntermediatePaymentCompatibility() {
    final _$actionInfo = _$_PaymentStepStoreBaseActionController.startAction(
        name: '_PaymentStepStoreBase.checkIntermediatePaymentCompatibility');
    try {
      return super.checkIntermediatePaymentCompatibility();
    } finally {
      _$_PaymentStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
intermediatePaymentPercentage: ${intermediatePaymentPercentage},
intermediatePaymentAmount: ${intermediatePaymentAmount},
endOfWorksPaymentAmount: ${endOfWorksPaymentAmount},
creditTotalCost: ${creditTotalCost},
depositAmount: ${depositAmount},
insuranceType: ${insuranceType},
monthlyPaymentAmount: ${monthlyPaymentAmount},
monthlyPaymentsCount: ${monthlyPaymentsCount},
nominalRate: ${nominalRate},
orderFormId: ${orderFormId},
orderType: ${orderType},
origin: ${origin},
originDetails: ${originDetails},
paymentTerms: ${paymentTerms},
deferment: ${deferment},
apr: ${apr},
depositAmountController: ${depositAmountController},
intermediatePaymentAmountController: ${intermediatePaymentAmountController},
endOfWorksPaymentAmountController: ${endOfWorksPaymentAmountController},
isCashPayment: ${isCashPayment},
isFinancingPayment: ${isFinancingPayment},
cashPaymentMethod: ${cashPaymentMethod},
financingPaymentMethod: ${financingPaymentMethod},
creditAmount: ${creditAmount},
intermediatePaymentChoices: ${intermediatePaymentChoices},
totalWithDepositDeducted: ${totalWithDepositDeducted},
formattedTotalWithDepositDeducted: ${formattedTotalWithDepositDeducted},
formattedIntermediatePaymentPercentage: ${formattedIntermediatePaymentPercentage},
endOfWorksPaymentPercentage: ${endOfWorksPaymentPercentage},
formattedEndOfWorksPaymentPercentage: ${formattedEndOfWorksPaymentPercentage},
depositPercentage: ${depositPercentage},
cleaningRelatedTotalWithDeposit: ${cleaningRelatedTotalWithDeposit},
computedIntermediatePaymentAmount: ${computedIntermediatePaymentAmount},
formattedIntermediatePaymentAmount: ${formattedIntermediatePaymentAmount},
computedEndOfWorksPaymentAmount: ${computedEndOfWorksPaymentAmount},
formattedEndOfWorksPaymentAmount: ${formattedEndOfWorksPaymentAmount},
depositAmountIsInvalid: ${depositAmountIsInvalid},
monthlyPaymentsCountIsInvalid: ${monthlyPaymentsCountIsInvalid},
creditTotalCostIsInvalid: ${creditTotalCostIsInvalid},
monthlyPaymentAmountIsInvalid: ${monthlyPaymentAmountIsInvalid},
nominalRateIsInvalid: ${nominalRateIsInvalid},
aprIsInvalid: ${aprIsInvalid},
isSubmittable: ${isSubmittable},
hasChanges: ${hasChanges}
    ''';
  }
}
