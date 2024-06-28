// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_discount_code_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SaveDiscountCodeDialogStore on _SaveDiscountCodeDialogStoreBase, Store {
  Computed<bool>? _$isDiscountPercentageInvalidComputed;

  @override
  bool get isDiscountPercentageInvalid =>
      (_$isDiscountPercentageInvalidComputed ??= Computed<bool>(
              () => super.isDiscountPercentageInvalid,
              name:
                  '_SaveDiscountCodeDialogStoreBase.isDiscountPercentageInvalid'))
          .value;
  Computed<bool>? _$isCodeInvalidComputed;

  @override
  bool get isCodeInvalid =>
      (_$isCodeInvalidComputed ??= Computed<bool>(() => super.isCodeInvalid,
              name: '_SaveDiscountCodeDialogStoreBase.isCodeInvalid'))
          .value;
  Computed<bool>? _$isEndDateInvalidComputed;

  @override
  bool get isEndDateInvalid => (_$isEndDateInvalidComputed ??= Computed<bool>(
          () => super.isEndDateInvalid,
          name: '_SaveDiscountCodeDialogStoreBase.isEndDateInvalid'))
      .value;
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_SaveDiscountCodeDialogStoreBase.formIsValid'))
          .value;
  Computed<bool>? _$isEditingComputed;

  @override
  bool get isEditing =>
      (_$isEditingComputed ??= Computed<bool>(() => super.isEditing,
              name: '_SaveDiscountCodeDialogStoreBase.isEditing'))
          .value;

  late final _$discountCodeAtom = Atom(
      name: '_SaveDiscountCodeDialogStoreBase.discountCode', context: context);

  @override
  DiscountCode? get discountCode {
    _$discountCodeAtom.reportRead();
    return super.discountCode;
  }

  @override
  set discountCode(DiscountCode? value) {
    _$discountCodeAtom.reportWrite(value, super.discountCode, () {
      super.discountCode = value;
    });
  }

  late final _$discountPercentageAtom = Atom(
      name: '_SaveDiscountCodeDialogStoreBase.discountPercentage',
      context: context);

  @override
  String get discountPercentage {
    _$discountPercentageAtom.reportRead();
    return super.discountPercentage;
  }

  @override
  set discountPercentage(String value) {
    _$discountPercentageAtom.reportWrite(value, super.discountPercentage, () {
      super.discountPercentage = value;
    });
  }

  late final _$codeAtom =
      Atom(name: '_SaveDiscountCodeDialogStoreBase.code', context: context);

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$hasNotExpirationAtom = Atom(
      name: '_SaveDiscountCodeDialogStoreBase.hasNotExpiration',
      context: context);

  @override
  bool get hasNotExpiration {
    _$hasNotExpirationAtom.reportRead();
    return super.hasNotExpiration;
  }

  @override
  set hasNotExpiration(bool value) {
    _$hasNotExpirationAtom.reportWrite(value, super.hasNotExpiration, () {
      super.hasNotExpiration = value;
    });
  }

  late final _$startDateAtom = Atom(
      name: '_SaveDiscountCodeDialogStoreBase.startDate', context: context);

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$endDateAtom =
      Atom(name: '_SaveDiscountCodeDialogStoreBase.endDate', context: context);

  @override
  DateTime get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  late final _$_currentRepresentativeAtom = Atom(
      name: '_SaveDiscountCodeDialogStoreBase._currentRepresentative',
      context: context);

  @override
  Representative? get _currentRepresentative {
    _$_currentRepresentativeAtom.reportRead();
    return super._currentRepresentative;
  }

  @override
  set _currentRepresentative(Representative? value) {
    _$_currentRepresentativeAtom
        .reportWrite(value, super._currentRepresentative, () {
      super._currentRepresentative = value;
    });
  }

  late final _$generateCodeAsyncAction = AsyncAction(
      '_SaveDiscountCodeDialogStoreBase.generateCode',
      context: context);

  @override
  Future<void> generateCode() {
    return _$generateCodeAsyncAction.run(() => super.generateCode());
  }

  late final _$saveDiscountCodeAsyncAction = AsyncAction(
      '_SaveDiscountCodeDialogStoreBase.saveDiscountCode',
      context: context);

  @override
  Future<void> saveDiscountCode() {
    return _$saveDiscountCodeAsyncAction.run(() => super.saveDiscountCode());
  }

  late final _$deleteDiscountCodeAsyncAction = AsyncAction(
      '_SaveDiscountCodeDialogStoreBase.deleteDiscountCode',
      context: context);

  @override
  Future<void> deleteDiscountCode() {
    return _$deleteDiscountCodeAsyncAction
        .run(() => super.deleteDiscountCode());
  }

  late final _$_SaveDiscountCodeDialogStoreBaseActionController =
      ActionController(
          name: '_SaveDiscountCodeDialogStoreBase', context: context);

  @override
  void setDiscountCode(DiscountCode value) {
    final _$actionInfo = _$_SaveDiscountCodeDialogStoreBaseActionController
        .startAction(name: '_SaveDiscountCodeDialogStoreBase.setDiscountCode');
    try {
      return super.setDiscountCode(value);
    } finally {
      _$_SaveDiscountCodeDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDiscountPercentage(String value) {
    final _$actionInfo =
        _$_SaveDiscountCodeDialogStoreBaseActionController.startAction(
            name: '_SaveDiscountCodeDialogStoreBase.setDiscountPercentage');
    try {
      return super.setDiscountPercentage(value);
    } finally {
      _$_SaveDiscountCodeDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setCode(String value) {
    final _$actionInfo = _$_SaveDiscountCodeDialogStoreBaseActionController
        .startAction(name: '_SaveDiscountCodeDialogStoreBase.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_SaveDiscountCodeDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setHasNotExpiration(bool value) {
    final _$actionInfo =
        _$_SaveDiscountCodeDialogStoreBaseActionController.startAction(
            name: '_SaveDiscountCodeDialogStoreBase.setHasNotExpiration');
    try {
      return super.setHasNotExpiration(value);
    } finally {
      _$_SaveDiscountCodeDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(DateTime value) {
    final _$actionInfo = _$_SaveDiscountCodeDialogStoreBaseActionController
        .startAction(name: '_SaveDiscountCodeDialogStoreBase.setStartDate');
    try {
      return super.setStartDate(value);
    } finally {
      _$_SaveDiscountCodeDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setEndDate(DateTime value) {
    final _$actionInfo = _$_SaveDiscountCodeDialogStoreBaseActionController
        .startAction(name: '_SaveDiscountCodeDialogStoreBase.setEndDate');
    try {
      return super.setEndDate(value);
    } finally {
      _$_SaveDiscountCodeDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
discountCode: ${discountCode},
discountPercentage: ${discountPercentage},
code: ${code},
hasNotExpiration: ${hasNotExpiration},
startDate: ${startDate},
endDate: ${endDate},
isDiscountPercentageInvalid: ${isDiscountPercentageInvalid},
isCodeInvalid: ${isCodeInvalid},
isEndDateInvalid: ${isEndDateInvalid},
formIsValid: ${formIsValid},
isEditing: ${isEditing}
    ''';
  }
}
