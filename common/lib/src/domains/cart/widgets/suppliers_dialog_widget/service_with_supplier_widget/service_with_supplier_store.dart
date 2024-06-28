import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'service_with_supplier_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceWithSupplierStoreInterface {
  ServiceWithSupplierStoreInterface._(
      this.supplierName, this.supplierId, this.withWorkforce, this.choices);

  // Params
  ServiceWithSupplierStoreParams get params;

  // Variables
  String? supplierName;
  String? supplierId;
  bool withWorkforce;
  List<SelectChoice> choices;

  String getService();
  setSupplier(String? value);
  setWithWorkforce(bool value);
}

// Params:----------------------------------------------------------------------
class ServiceWithSupplierStoreParams {
  ServiceWithSupplierStoreParams({
    required this.row,
    required this.choices,
  });

  final OrderRow row;
  final List<SelectChoice> choices;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ServiceWithSupplierStore = _ServiceWithSupplierStoreBase
    with _$ServiceWithSupplierStore;

abstract class _ServiceWithSupplierStoreBase
    with Store
    implements ServiceWithSupplierStoreInterface {
  // Constructor:---------------------------------------------------------------
  _ServiceWithSupplierStoreBase({required this.params}) {
    init();
  }

  // Variables:-----------------------------------------------------------------
  @override
  final ServiceWithSupplierStoreParams params;
  @override
  @observable
  String? supplierName;
  @override
  @observable
  String? supplierId;
  @override
  @observable
  bool withWorkforce = false;
  @override
  @observable
  List<SelectChoice> choices = [];

  // Actions:-------------------------------------------------------------------
  @override
  @action
  String getService() {
    return params.row.service!.label;
  }

  @override
  @action
  void setSupplier(String? value) {
    supplierId = value;
    setSupplierName();

    if (supplierId == null) {
      withWorkforce = false;
    }
  }

  @override
  @action
  void setWithWorkforce(bool value) {
    withWorkforce = value;
  }

  void init() {
    choices = params.choices;
    supplierId = params.row.supplier?.id;
    withWorkforce = params.row.withWorkforce;
    setSupplierName();
  }

  void setSupplierName() {
    if (supplierId != null) {
      supplierName =
          choices.firstWhere((supplier) => supplier.value == supplierId).label;
    } else {
      supplierName = '';
    }
  }
}
