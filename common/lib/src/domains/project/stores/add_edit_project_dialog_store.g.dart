// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_project_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddEditProjectDialogStore on _AddEditProjectDialogStoreBase, Store {
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_AddEditProjectDialogStoreBase.canSubmit'))
          .value;
  Computed<String>? _$meetingOriginWithDetailsComputed;

  @override
  String get meetingOriginWithDetails => (_$meetingOriginWithDetailsComputed ??=
          Computed<String>(() => super.meetingOriginWithDetails,
              name: '_AddEditProjectDialogStoreBase.meetingOriginWithDetails'))
      .value;
  Computed<bool>? _$isEditingComputed;

  @override
  bool get isEditing =>
      (_$isEditingComputed ??= Computed<bool>(() => super.isEditing,
              name: '_AddEditProjectDialogStoreBase.isEditing'))
          .value;
  Computed<OrderType?>? _$orderTypeComputed;

  @override
  OrderType? get orderType =>
      (_$orderTypeComputed ??= Computed<OrderType?>(() => super.orderType,
              name: '_AddEditProjectDialogStoreBase.orderType'))
          .value;

  late final _$_currentRepresentativeAtom = Atom(
      name: '_AddEditProjectDialogStoreBase._currentRepresentative',
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

  late final _$_currentFairAtom = Atom(
      name: '_AddEditProjectDialogStoreBase._currentFair', context: context);

  @override
  Fair? get _currentFair {
    _$_currentFairAtom.reportRead();
    return super._currentFair;
  }

  @override
  set _currentFair(Fair? value) {
    _$_currentFairAtom.reportWrite(value, super._currentFair, () {
      super._currentFair = value;
    });
  }

  late final _$addressAtom =
      Atom(name: '_AddEditProjectDialogStoreBase.address', context: context);

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$postalCodeAtom =
      Atom(name: '_AddEditProjectDialogStoreBase.postalCode', context: context);

  @override
  String get postalCode {
    _$postalCodeAtom.reportRead();
    return super.postalCode;
  }

  @override
  set postalCode(String value) {
    _$postalCodeAtom.reportWrite(value, super.postalCode, () {
      super.postalCode = value;
    });
  }

  late final _$cityAtom =
      Atom(name: '_AddEditProjectDialogStoreBase.city', context: context);

  @override
  String get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  late final _$locationAtom =
      Atom(name: '_AddEditProjectDialogStoreBase.location', context: context);

  @override
  GeoPoint? get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(GeoPoint? value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  late final _$meetingOriginAtom = Atom(
      name: '_AddEditProjectDialogStoreBase.meetingOrigin', context: context);

  @override
  Origin? get meetingOrigin {
    _$meetingOriginAtom.reportRead();
    return super.meetingOrigin;
  }

  @override
  set meetingOrigin(Origin? value) {
    _$meetingOriginAtom.reportWrite(value, super.meetingOrigin, () {
      super.meetingOrigin = value;
    });
  }

  late final _$meetingOriginDetailsAtom = Atom(
      name: '_AddEditProjectDialogStoreBase.meetingOriginDetails',
      context: context);

  @override
  OriginDetails? get meetingOriginDetails {
    _$meetingOriginDetailsAtom.reportRead();
    return super.meetingOriginDetails;
  }

  @override
  set meetingOriginDetails(OriginDetails? value) {
    _$meetingOriginDetailsAtom.reportWrite(value, super.meetingOriginDetails,
        () {
      super.meetingOriginDetails = value;
    });
  }

  late final _$houseAgeAtom =
      Atom(name: '_AddEditProjectDialogStoreBase.houseAge', context: context);

  @override
  int? get houseAge {
    _$houseAgeAtom.reportRead();
    return super.houseAge;
  }

  @override
  set houseAge(int? value) {
    _$houseAgeAtom.reportWrite(value, super.houseAge, () {
      super.houseAge = value;
    });
  }

  late final _$isProPremiseAtom = Atom(
      name: '_AddEditProjectDialogStoreBase.isProPremise', context: context);

  @override
  bool get isProPremise {
    _$isProPremiseAtom.reportRead();
    return super.isProPremise;
  }

  @override
  set isProPremise(bool value) {
    _$isProPremiseAtom.reportWrite(value, super.isProPremise, () {
      super.isProPremise = value;
    });
  }

  late final _$addProjectAsyncAction = AsyncAction(
      '_AddEditProjectDialogStoreBase.addProject',
      context: context);

  @override
  Future<void> addProject() {
    return _$addProjectAsyncAction.run(() => super.addProject());
  }

  late final _$resetAsyncAction =
      AsyncAction('_AddEditProjectDialogStoreBase.reset', context: context);

  @override
  Future<void> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  late final _$_AddEditProjectDialogStoreBaseActionController =
      ActionController(
          name: '_AddEditProjectDialogStoreBase', context: context);

  @override
  void setIsProPremise(bool value) {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.setIsProPremise');
    try {
      return super.setIsProPremise(value);
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHouseAge(int value) {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.setHouseAge');
    try {
      return super.setHouseAge(value);
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetingOrigin(Origin originValue, OriginDetails originDetailsValue) {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.setMeetingOrigin');
    try {
      return super.setMeetingOrigin(originValue, originDetailsValue);
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(AddressDTO? addressDetails) {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.setAddress');
    try {
      return super.setAddress(addressDetails);
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPostalCode(String value) {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.setPostalCode');
    try {
      return super.setPostalCode(value);
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCity(String value) {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.setCity');
    try {
      return super.setCity(value);
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateOrder() {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.updateOrder');
    try {
      return super.updateOrder();
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void submit() {
    final _$actionInfo = _$_AddEditProjectDialogStoreBaseActionController
        .startAction(name: '_AddEditProjectDialogStoreBase.submit');
    try {
      return super.submit();
    } finally {
      _$_AddEditProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
address: ${address},
postalCode: ${postalCode},
city: ${city},
location: ${location},
meetingOrigin: ${meetingOrigin},
meetingOriginDetails: ${meetingOriginDetails},
houseAge: ${houseAge},
isProPremise: ${isProPremise},
canSubmit: ${canSubmit},
meetingOriginWithDetails: ${meetingOriginWithDetails},
isEditing: ${isEditing},
orderType: ${orderType}
    ''';
  }
}
