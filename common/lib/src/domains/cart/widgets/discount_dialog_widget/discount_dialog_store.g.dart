// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DiscountDialogStore on _DiscountDialogStoreBase, Store {
  Computed<bool>? _$isCommercialAdvantageValidComputed;

  @override
  bool get isCommercialAdvantageValid =>
      (_$isCommercialAdvantageValidComputed ??= Computed<bool>(
              () => super.isCommercialAdvantageValid,
              name: '_DiscountDialogStoreBase.isCommercialAdvantageValid'))
          .value;
  Computed<bool>? _$isDiscountCodeValidComputed;

  @override
  bool get isDiscountCodeValid => (_$isDiscountCodeValidComputed ??=
          Computed<bool>(() => super.isDiscountCodeValid,
              name: '_DiscountDialogStoreBase.isDiscountCodeValid'))
      .value;
  Computed<bool>? _$isFirstStepValidComputed;

  @override
  bool get isFirstStepValid => (_$isFirstStepValidComputed ??= Computed<bool>(
          () => super.isFirstStepValid,
          name: '_DiscountDialogStoreBase.isFirstStepValid'))
      .value;
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_DiscountDialogStoreBase.formIsValid'))
          .value;
  Computed<double>? _$totalNetInclTaxComputed;

  @override
  double get totalNetInclTax => (_$totalNetInclTaxComputed ??= Computed<double>(
          () => super.totalNetInclTax,
          name: '_DiscountDialogStoreBase.totalNetInclTax'))
      .value;
  Computed<String>? _$formattedTotalNetInclTaxComputed;

  @override
  String get formattedTotalNetInclTax => (_$formattedTotalNetInclTaxComputed ??=
          Computed<String>(() => super.formattedTotalNetInclTax,
              name: '_DiscountDialogStoreBase.formattedTotalNetInclTax'))
      .value;

  late final _$discountTypeAtom =
      Atom(name: '_DiscountDialogStoreBase.discountType', context: context);

  @override
  DiscountTypeChoice get discountType {
    _$discountTypeAtom.reportRead();
    return super.discountType;
  }

  @override
  set discountType(DiscountTypeChoice value) {
    _$discountTypeAtom.reportWrite(value, super.discountType, () {
      super.discountType = value;
    });
  }

  late final _$commercialAdvantageAtom = Atom(
      name: '_DiscountDialogStoreBase.commercialAdvantage', context: context);

  @override
  String get commercialAdvantage {
    _$commercialAdvantageAtom.reportRead();
    return super.commercialAdvantage;
  }

  @override
  set commercialAdvantage(String value) {
    _$commercialAdvantageAtom.reportWrite(value, super.commercialAdvantage, () {
      super.commercialAdvantage = value;
    });
  }

  late final _$discountCodeAtom =
      Atom(name: '_DiscountDialogStoreBase.discountCode', context: context);

  @override
  String get discountCode {
    _$discountCodeAtom.reportRead();
    return super.discountCode;
  }

  @override
  set discountCode(String value) {
    _$discountCodeAtom.reportWrite(value, super.discountCode, () {
      super.discountCode = value;
    });
  }

  late final _$selectedDiscountCodeAtom = Atom(
      name: '_DiscountDialogStoreBase.selectedDiscountCode', context: context);

  @override
  DiscountCode? get selectedDiscountCode {
    _$selectedDiscountCodeAtom.reportRead();
    return super.selectedDiscountCode;
  }

  @override
  set selectedDiscountCode(DiscountCode? value) {
    _$selectedDiscountCodeAtom.reportWrite(value, super.selectedDiscountCode,
        () {
      super.selectedDiscountCode = value;
    });
  }

  late final _$isFirstStepValidatedAtom = Atom(
      name: '_DiscountDialogStoreBase.isFirstStepValidated', context: context);

  @override
  bool get isFirstStepValidated {
    _$isFirstStepValidatedAtom.reportRead();
    return super.isFirstStepValidated;
  }

  @override
  set isFirstStepValidated(bool value) {
    _$isFirstStepValidatedAtom.reportWrite(value, super.isFirstStepValidated,
        () {
      super.isFirstStepValidated = value;
    });
  }

  late final _$selectedRowsAtom =
      Atom(name: '_DiscountDialogStoreBase.selectedRows', context: context);

  @override
  ObservableList<OrderRow> get selectedRows {
    _$selectedRowsAtom.reportRead();
    return super.selectedRows;
  }

  @override
  set selectedRows(ObservableList<OrderRow> value) {
    _$selectedRowsAtom.reportWrite(value, super.selectedRows, () {
      super.selectedRows = value;
    });
  }

  late final _$rowsAtom =
      Atom(name: '_DiscountDialogStoreBase.rows', context: context);

  @override
  List<OrderRow> get rows {
    _$rowsAtom.reportRead();
    return super.rows;
  }

  @override
  set rows(List<OrderRow> value) {
    _$rowsAtom.reportWrite(value, super.rows, () {
      super.rows = value;
    });
  }

  late final _$submitFirstStepAsyncAction =
      AsyncAction('_DiscountDialogStoreBase.submitFirstStep', context: context);

  @override
  Future<void> submitFirstStep() {
    return _$submitFirstStepAsyncAction.run(() => super.submitFirstStep());
  }

  late final _$toggleSelectedServicesAsyncAction = AsyncAction(
      '_DiscountDialogStoreBase.toggleSelectedServices',
      context: context);

  @override
  Future<void> toggleSelectedServices(OrderRow row) {
    return _$toggleSelectedServicesAsyncAction
        .run(() => super.toggleSelectedServices(row));
  }

  late final _$_DiscountDialogStoreBaseActionController =
      ActionController(name: '_DiscountDialogStoreBase', context: context);

  @override
  void setDiscountType(DiscountTypeChoice value) {
    final _$actionInfo = _$_DiscountDialogStoreBaseActionController.startAction(
        name: '_DiscountDialogStoreBase.setDiscountType');
    try {
      return super.setDiscountType(value);
    } finally {
      _$_DiscountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCommercialAdvantage(String value) {
    final _$actionInfo = _$_DiscountDialogStoreBaseActionController.startAction(
        name: '_DiscountDialogStoreBase.setCommercialAdvantage');
    try {
      return super.setCommercialAdvantage(value);
    } finally {
      _$_DiscountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDiscountCode(String value) {
    final _$actionInfo = _$_DiscountDialogStoreBaseActionController.startAction(
        name: '_DiscountDialogStoreBase.setDiscountCode');
    try {
      return super.setDiscountCode(value);
    } finally {
      _$_DiscountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void backToFirstStep() {
    final _$actionInfo = _$_DiscountDialogStoreBaseActionController.startAction(
        name: '_DiscountDialogStoreBase.backToFirstStep');
    try {
      return super.backToFirstStep();
    } finally {
      _$_DiscountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRows(List<OrderRow> rows) {
    final _$actionInfo = _$_DiscountDialogStoreBaseActionController.startAction(
        name: '_DiscountDialogStoreBase.setRows');
    try {
      return super.setRows(rows);
    } finally {
      _$_DiscountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
discountType: ${discountType},
commercialAdvantage: ${commercialAdvantage},
discountCode: ${discountCode},
selectedDiscountCode: ${selectedDiscountCode},
isFirstStepValidated: ${isFirstStepValidated},
selectedRows: ${selectedRows},
rows: ${rows},
isCommercialAdvantageValid: ${isCommercialAdvantageValid},
isDiscountCodeValid: ${isDiscountCodeValid},
isFirstStepValid: ${isFirstStepValid},
formIsValid: ${formIsValid},
totalNetInclTax: ${totalNetInclTax},
formattedTotalNetInclTax: ${formattedTotalNetInclTax}
    ''';
  }
}
