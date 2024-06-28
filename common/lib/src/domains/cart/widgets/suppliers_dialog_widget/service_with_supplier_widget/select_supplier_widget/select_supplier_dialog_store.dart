import 'package:mobx/mobx.dart';

part 'select_supplier_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectSupplierDialogStoreInterface {
  SelectSupplierDialogStoreParams get params;

  // Variables
  String? supplierValue;
  bool withWorkforceValue = false;

  // Methods
  void setSupplierValue(String? supplierValue);
  void toggleWithWorkforceValue();
}

// Params:----------------------------------------------------------------------
class SelectSupplierDialogStoreParams<T> {
  const SelectSupplierDialogStoreParams({
    required this.supplierValue,
    required this.withWorkforceValue,
  });

  final dynamic supplierValue;
  final bool withWorkforceValue;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class SelectSupplierDialogStore = _SelectSupplierDialogStoreBase
    with _$SelectSupplierDialogStore;

abstract class _SelectSupplierDialogStoreBase
    with Store
    implements SelectSupplierDialogStoreInterface {
  _SelectSupplierDialogStoreBase({required this.params})
      : supplierValue = params.supplierValue,
        withWorkforceValue = params.withWorkforceValue;

  // Params:---------------------------------------------------------------------
  @override
  final SelectSupplierDialogStoreParams params;

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  String? supplierValue;

  @override
  @observable
  bool withWorkforceValue;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setSupplierValue(String? supplierValue) {
    this.supplierValue = supplierValue;
    withWorkforceValue = supplierValue != null ? withWorkforceValue : false;
  }

  @override
  @action
  void toggleWithWorkforceValue() {
    withWorkforceValue = supplierValue != null ? !withWorkforceValue : false;
  }
}
