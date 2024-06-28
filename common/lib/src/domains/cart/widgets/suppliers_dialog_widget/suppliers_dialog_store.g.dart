// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suppliers_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SuppliersDialogStore on _SuppliersDialogStoreBase, Store {
  late final _$rowsAtom =
      Atom(name: '_SuppliersDialogStoreBase.rows', context: context);

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

  late final _$storesAtom =
      Atom(name: '_SuppliersDialogStoreBase.stores', context: context);

  @override
  List<ServiceWithSupplierStoreInterface> get stores {
    _$storesAtom.reportRead();
    return super.stores;
  }

  @override
  set stores(List<ServiceWithSupplierStoreInterface> value) {
    _$storesAtom.reportWrite(value, super.stores, () {
      super.stores = value;
    });
  }

  late final _$setRowsAsyncAction =
      AsyncAction('_SuppliersDialogStoreBase.setRows', context: context);

  @override
  Future<void> setRows(List<OrderRow> rows) {
    return _$setRowsAsyncAction.run(() => super.setRows(rows));
  }

  late final _$_SuppliersDialogStoreBaseActionController =
      ActionController(name: '_SuppliersDialogStoreBase', context: context);

  @override
  List<OrderRow> mergeRows() {
    final _$actionInfo = _$_SuppliersDialogStoreBaseActionController
        .startAction(name: '_SuppliersDialogStoreBase.mergeRows');
    try {
      return super.mergeRows();
    } finally {
      _$_SuppliersDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rows: ${rows},
stores: ${stores}
    ''';
  }
}
