// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_customer_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditCustomerDialogStore on _EditCustomerDialogStoreBase, Store {
  Computed<String>? _$originWithDetailsComputed;

  @override
  String get originWithDetails => (_$originWithDetailsComputed ??=
          Computed<String>(() => super.originWithDetails,
              name: '_EditCustomerDialogStoreBase.originWithDetails'))
      .value;

  late final _$customerAtom =
      Atom(name: '_EditCustomerDialogStoreBase.customer', context: context);

  @override
  Customer get customer {
    _$customerAtom.reportRead();
    return super.customer;
  }

  @override
  set customer(Customer value) {
    _$customerAtom.reportWrite(value, super.customer, () {
      super.customer = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_EditCustomerDialogStoreBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$customerTypeAtom =
      Atom(name: '_EditCustomerDialogStoreBase.customerType', context: context);

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

  late final _$addressAtom =
      Atom(name: '_EditCustomerDialogStoreBase.address', context: context);

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
      Atom(name: '_EditCustomerDialogStoreBase.postalCode', context: context);

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
      Atom(name: '_EditCustomerDialogStoreBase.city', context: context);

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

  late final _$originAtom =
      Atom(name: '_EditCustomerDialogStoreBase.origin', context: context);

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

  late final _$originDetailsAtom = Atom(
      name: '_EditCustomerDialogStoreBase.originDetails', context: context);

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

  late final _$updateCustomerAsyncAction = AsyncAction(
      '_EditCustomerDialogStoreBase.updateCustomer',
      context: context);

  @override
  Future<void> updateCustomer() {
    return _$updateCustomerAsyncAction.run(() => super.updateCustomer());
  }

  late final _$_EditCustomerDialogStoreBaseActionController =
      ActionController(name: '_EditCustomerDialogStoreBase', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_EditCustomerDialogStoreBaseActionController
        .startAction(name: '_EditCustomerDialogStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_EditCustomerDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrigin(Origin originValue, OriginDetails originDetailsValue) {
    final _$actionInfo = _$_EditCustomerDialogStoreBaseActionController
        .startAction(name: '_EditCustomerDialogStoreBase.setOrigin');
    try {
      return super.setOrigin(originValue, originDetailsValue);
    } finally {
      _$_EditCustomerDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String value) {
    final _$actionInfo = _$_EditCustomerDialogStoreBaseActionController
        .startAction(name: '_EditCustomerDialogStoreBase.setAddress');
    try {
      return super.setAddress(value);
    } finally {
      _$_EditCustomerDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPostalCode(String value) {
    final _$actionInfo = _$_EditCustomerDialogStoreBaseActionController
        .startAction(name: '_EditCustomerDialogStoreBase.setPostalCode');
    try {
      return super.setPostalCode(value);
    } finally {
      _$_EditCustomerDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCity(String value) {
    final _$actionInfo = _$_EditCustomerDialogStoreBaseActionController
        .startAction(name: '_EditCustomerDialogStoreBase.setCity');
    try {
      return super.setCity(value);
    } finally {
      _$_EditCustomerDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCustomerType(CustomerType value) {
    final _$actionInfo = _$_EditCustomerDialogStoreBaseActionController
        .startAction(name: '_EditCustomerDialogStoreBase.setCustomerType');
    try {
      return super.setCustomerType(value);
    } finally {
      _$_EditCustomerDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_EditCustomerDialogStoreBaseActionController
        .startAction(name: '_EditCustomerDialogStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_EditCustomerDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customer: ${customer},
name: ${name},
customerType: ${customerType},
address: ${address},
postalCode: ${postalCode},
city: ${city},
origin: ${origin},
originDetails: ${originDetails},
originWithDetails: ${originWithDetails}
    ''';
  }
}
