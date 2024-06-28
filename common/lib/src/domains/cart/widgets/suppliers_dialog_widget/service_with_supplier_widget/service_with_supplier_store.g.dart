// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_with_supplier_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceWithSupplierStore on _ServiceWithSupplierStoreBase, Store {
  late final _$supplierNameAtom = Atom(
      name: '_ServiceWithSupplierStoreBase.supplierName', context: context);

  @override
  String? get supplierName {
    _$supplierNameAtom.reportRead();
    return super.supplierName;
  }

  @override
  set supplierName(String? value) {
    _$supplierNameAtom.reportWrite(value, super.supplierName, () {
      super.supplierName = value;
    });
  }

  late final _$supplierIdAtom =
      Atom(name: '_ServiceWithSupplierStoreBase.supplierId', context: context);

  @override
  String? get supplierId {
    _$supplierIdAtom.reportRead();
    return super.supplierId;
  }

  @override
  set supplierId(String? value) {
    _$supplierIdAtom.reportWrite(value, super.supplierId, () {
      super.supplierId = value;
    });
  }

  late final _$withWorkforceAtom = Atom(
      name: '_ServiceWithSupplierStoreBase.withWorkforce', context: context);

  @override
  bool get withWorkforce {
    _$withWorkforceAtom.reportRead();
    return super.withWorkforce;
  }

  @override
  set withWorkforce(bool value) {
    _$withWorkforceAtom.reportWrite(value, super.withWorkforce, () {
      super.withWorkforce = value;
    });
  }

  late final _$choicesAtom =
      Atom(name: '_ServiceWithSupplierStoreBase.choices', context: context);

  @override
  List<SelectChoice<dynamic>> get choices {
    _$choicesAtom.reportRead();
    return super.choices;
  }

  @override
  set choices(List<SelectChoice<dynamic>> value) {
    _$choicesAtom.reportWrite(value, super.choices, () {
      super.choices = value;
    });
  }

  late final _$_ServiceWithSupplierStoreBaseActionController =
      ActionController(name: '_ServiceWithSupplierStoreBase', context: context);

  @override
  String getService() {
    final _$actionInfo = _$_ServiceWithSupplierStoreBaseActionController
        .startAction(name: '_ServiceWithSupplierStoreBase.getService');
    try {
      return super.getService();
    } finally {
      _$_ServiceWithSupplierStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSupplier(String? value) {
    final _$actionInfo = _$_ServiceWithSupplierStoreBaseActionController
        .startAction(name: '_ServiceWithSupplierStoreBase.setSupplier');
    try {
      return super.setSupplier(value);
    } finally {
      _$_ServiceWithSupplierStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWithWorkforce(bool value) {
    final _$actionInfo = _$_ServiceWithSupplierStoreBaseActionController
        .startAction(name: '_ServiceWithSupplierStoreBase.setWithWorkforce');
    try {
      return super.setWithWorkforce(value);
    } finally {
      _$_ServiceWithSupplierStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
supplierName: ${supplierName},
supplierId: ${supplierId},
withWorkforce: ${withWorkforce},
choices: ${choices}
    ''';
  }
}
