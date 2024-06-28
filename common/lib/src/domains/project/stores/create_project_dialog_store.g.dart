// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_project_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateProjectDialogStore on _CreateProjectDialogStoreBase, Store {
  Computed<bool>? _$createCustomerIsValidComputed;

  @override
  bool get createCustomerIsValid => (_$createCustomerIsValidComputed ??=
          Computed<bool>(() => super.createCustomerIsValid,
              name: '_CreateProjectDialogStoreBase.createCustomerIsValid'))
      .value;
  Computed<bool>? _$contactsListIsValidComputed;

  @override
  bool get contactsListIsValid => (_$contactsListIsValidComputed ??=
          Computed<bool>(() => super.contactsListIsValid,
              name: '_CreateProjectDialogStoreBase.contactsListIsValid'))
      .value;
  Computed<OrderType?>? _$orderTypeComputed;

  @override
  OrderType? get orderType =>
      (_$orderTypeComputed ??= Computed<OrderType?>(() => super.orderType,
              name: '_CreateProjectDialogStoreBase.orderType'))
          .value;
  Computed<List<Map<String, String>>>? _$contactsDataComputed;

  @override
  List<Map<String, String>> get contactsData => (_$contactsDataComputed ??=
          Computed<List<Map<String, String>>>(() => super.contactsData,
              name: '_CreateProjectDialogStoreBase.contactsData'))
      .value;

  late final _$_currentRepresentativeAtom = Atom(
      name: '_CreateProjectDialogStoreBase._currentRepresentative',
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
      name: '_CreateProjectDialogStoreBase._currentFair', context: context);

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

  late final _$customerTypeAtom = Atom(
      name: '_CreateProjectDialogStoreBase.customerType', context: context);

  @override
  CustomerType get customerType {
    _$customerTypeAtom.reportRead();
    return super.customerType;
  }

  @override
  set customerType(CustomerType value) {
    _$customerTypeAtom.reportWrite(value, super.customerType, () {
      super.customerType = value;
    });
  }

  late final _$customerNameAtom = Atom(
      name: '_CreateProjectDialogStoreBase.customerName', context: context);

  @override
  String get customerName {
    _$customerNameAtom.reportRead();
    return super.customerName;
  }

  @override
  set customerName(String value) {
    _$customerNameAtom.reportWrite(value, super.customerName, () {
      super.customerName = value;
    });
  }

  late final _$customerAddressAtom = Atom(
      name: '_CreateProjectDialogStoreBase.customerAddress', context: context);

  @override
  String get customerAddress {
    _$customerAddressAtom.reportRead();
    return super.customerAddress;
  }

  @override
  set customerAddress(String value) {
    _$customerAddressAtom.reportWrite(value, super.customerAddress, () {
      super.customerAddress = value;
    });
  }

  late final _$customerPostalCodeAtom = Atom(
      name: '_CreateProjectDialogStoreBase.customerPostalCode',
      context: context);

  @override
  String get customerPostalCode {
    _$customerPostalCodeAtom.reportRead();
    return super.customerPostalCode;
  }

  @override
  set customerPostalCode(String value) {
    _$customerPostalCodeAtom.reportWrite(value, super.customerPostalCode, () {
      super.customerPostalCode = value;
    });
  }

  late final _$customerCityAtom = Atom(
      name: '_CreateProjectDialogStoreBase.customerCity', context: context);

  @override
  String get customerCity {
    _$customerCityAtom.reportRead();
    return super.customerCity;
  }

  @override
  set customerCity(String value) {
    _$customerCityAtom.reportWrite(value, super.customerCity, () {
      super.customerCity = value;
    });
  }

  late final _$customerOriginAtom = Atom(
      name: '_CreateProjectDialogStoreBase.customerOrigin', context: context);

  @override
  Origin? get customerOrigin {
    _$customerOriginAtom.reportRead();
    return super.customerOrigin;
  }

  @override
  set customerOrigin(Origin? value) {
    _$customerOriginAtom.reportWrite(value, super.customerOrigin, () {
      super.customerOrigin = value;
    });
  }

  late final _$customerOriginDetailsAtom = Atom(
      name: '_CreateProjectDialogStoreBase.customerOriginDetails',
      context: context);

  @override
  OriginDetails? get customerOriginDetails {
    _$customerOriginDetailsAtom.reportRead();
    return super.customerOriginDetails;
  }

  @override
  set customerOriginDetails(OriginDetails? value) {
    _$customerOriginDetailsAtom.reportWrite(value, super.customerOriginDetails,
        () {
      super.customerOriginDetails = value;
    });
  }

  late final _$houseAgeAtom =
      Atom(name: '_CreateProjectDialogStoreBase.houseAge', context: context);

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
      name: '_CreateProjectDialogStoreBase.isProPremise', context: context);

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

  late final _$contactsAtom =
      Atom(name: '_CreateProjectDialogStoreBase.contacts', context: context);

  @override
  ObservableList<Contact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<Contact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$locationAtom =
      Atom(name: '_CreateProjectDialogStoreBase.location', context: context);

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

  late final _$createProjectAsyncAction = AsyncAction(
      '_CreateProjectDialogStoreBase.createProject',
      context: context);

  @override
  Future<Order> createProject() {
    return _$createProjectAsyncAction.run(() => super.createProject());
  }

  late final _$_CreateProjectDialogStoreBaseActionController =
      ActionController(name: '_CreateProjectDialogStoreBase', context: context);

  @override
  void setOrigin(Origin origin, OriginDetails originDetails) {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.setOrigin');
    try {
      return super.setOrigin(origin, originDetails);
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void submitContactForm() {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.submitContactForm');
    try {
      return super.submitContactForm();
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addContact() {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.addContact');
    try {
      return super.addContact();
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateContact() {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.updateContact');
    try {
      return super.updateContact();
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeContact() {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.removeContact');
    try {
      return super.removeContact();
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(AddressDTO? addressDetails) {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.setAddress');
    try {
      return super.setAddress(addressDetails);
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHouseAge(int? age) {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.setHouseAge');
    try {
      return super.setHouseAge(age);
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsProPremise(bool isProPremise) {
    final _$actionInfo = _$_CreateProjectDialogStoreBaseActionController
        .startAction(name: '_CreateProjectDialogStoreBase.setIsProPremise');
    try {
      return super.setIsProPremise(isProPremise);
    } finally {
      _$_CreateProjectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customerType: ${customerType},
customerName: ${customerName},
customerAddress: ${customerAddress},
customerPostalCode: ${customerPostalCode},
customerCity: ${customerCity},
customerOrigin: ${customerOrigin},
customerOriginDetails: ${customerOriginDetails},
houseAge: ${houseAge},
isProPremise: ${isProPremise},
contacts: ${contacts},
location: ${location},
createCustomerIsValid: ${createCustomerIsValid},
contactsListIsValid: ${contactsListIsValid},
orderType: ${orderType},
contactsData: ${contactsData}
    ''';
  }
}
