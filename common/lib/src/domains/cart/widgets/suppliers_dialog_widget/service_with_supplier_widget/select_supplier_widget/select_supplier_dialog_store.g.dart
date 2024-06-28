// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_supplier_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectSupplierDialogStore on _SelectSupplierDialogStoreBase, Store {
  late final _$supplierValueAtom = Atom(
      name: '_SelectSupplierDialogStoreBase.supplierValue', context: context);

  @override
  String? get supplierValue {
    _$supplierValueAtom.reportRead();
    return super.supplierValue;
  }

  @override
  set supplierValue(String? value) {
    _$supplierValueAtom.reportWrite(value, super.supplierValue, () {
      super.supplierValue = value;
    });
  }

  late final _$withWorkforceValueAtom = Atom(
      name: '_SelectSupplierDialogStoreBase.withWorkforceValue',
      context: context);

  @override
  bool get withWorkforceValue {
    _$withWorkforceValueAtom.reportRead();
    return super.withWorkforceValue;
  }

  @override
  set withWorkforceValue(bool value) {
    _$withWorkforceValueAtom.reportWrite(value, super.withWorkforceValue, () {
      super.withWorkforceValue = value;
    });
  }

  late final _$_SelectSupplierDialogStoreBaseActionController =
      ActionController(
          name: '_SelectSupplierDialogStoreBase', context: context);

  @override
  void setSupplierValue(String? supplierValue) {
    final _$actionInfo = _$_SelectSupplierDialogStoreBaseActionController
        .startAction(name: '_SelectSupplierDialogStoreBase.setSupplierValue');
    try {
      return super.setSupplierValue(supplierValue);
    } finally {
      _$_SelectSupplierDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleWithWorkforceValue() {
    final _$actionInfo =
        _$_SelectSupplierDialogStoreBaseActionController.startAction(
            name: '_SelectSupplierDialogStoreBase.toggleWithWorkforceValue');
    try {
      return super.toggleWithWorkforceValue();
    } finally {
      _$_SelectSupplierDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
supplierValue: ${supplierValue},
withWorkforceValue: ${withWorkforceValue}
    ''';
  }
}
