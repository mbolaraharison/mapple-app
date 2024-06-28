import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'suppliers_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class SuppliersDialogStoreInterface {
  SuppliersDialogStoreInterface._(this.rows, this.stores);

  // Variables
  List<OrderRow> rows;
  List<ServiceWithSupplierStoreInterface> stores;

  // Methods
  Future<void> setRows(List<OrderRow> rows);
  List<OrderRow> mergeRows();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class SuppliersDialogStore = _SuppliersDialogStoreBase
    with _$SuppliersDialogStore;

abstract class _SuppliersDialogStoreBase
    with Store
    implements SuppliersDialogStoreInterface {
  // Services:------------------------------------------------------------------
  late final SupplierServiceInterface _supplierService =
      getIt<SupplierServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  List<OrderRow> rows = [];
  @override
  @observable
  List<ServiceWithSupplierStoreInterface> stores = [];

  // Actions:-------------------------------------------------------------------
  @override
  @action
  Future<void> setRows(List<OrderRow> rows) async {
    List<SelectChoice> choices = [];
    for (Supplier supplier in await _supplierService.getAll()) {
      choices.add(SelectChoice(value: supplier.id, label: supplier.name!));
    }

    this.rows = rows;
    stores = [];
    for (OrderRow row in rows) {
      stores.add(getIt<ServiceWithSupplierStoreInterface>(
          param1: ServiceWithSupplierStoreParams(
        row: row,
        choices: choices,
      )));
    }
  }

  @override
  @action
  List<OrderRow> mergeRows() {
    for (var i = 0; i < rows.length; i++) {
      rows[i].supplierId = stores[i].supplierId;
      rows[i].withWorkforce = stores[i].withWorkforce;
    }

    return rows;
  }
}
