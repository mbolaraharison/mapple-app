// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerListStore on _CustomerListStoreBase, Store {
  Computed<bool>? _$isListViewComputed;

  @override
  bool get isListView =>
      (_$isListViewComputed ??= Computed<bool>(() => super.isListView,
              name: '_CustomerListStoreBase.isListView'))
          .value;

  late final _$viewTypesAtom =
      Atom(name: '_CustomerListStoreBase.viewTypes', context: context);

  @override
  CustomerListViewTypes get viewTypes {
    _$viewTypesAtom.reportRead();
    return super.viewTypes;
  }

  @override
  set viewTypes(CustomerListViewTypes value) {
    _$viewTypesAtom.reportWrite(value, super.viewTypes, () {
      super.viewTypes = value;
    });
  }

  late final _$filterMyCustomersAtom =
      Atom(name: '_CustomerListStoreBase.filterMyCustomers', context: context);

  @override
  bool get filterMyCustomers {
    _$filterMyCustomersAtom.reportRead();
    return super.filterMyCustomers;
  }

  @override
  set filterMyCustomers(bool value) {
    _$filterMyCustomersAtom.reportWrite(value, super.filterMyCustomers, () {
      super.filterMyCustomers = value;
    });
  }

  late final _$filterOtherCustomersAtom = Atom(
      name: '_CustomerListStoreBase.filterOtherCustomers', context: context);

  @override
  bool get filterOtherCustomers {
    _$filterOtherCustomersAtom.reportRead();
    return super.filterOtherCustomers;
  }

  @override
  set filterOtherCustomers(bool value) {
    _$filterOtherCustomersAtom.reportWrite(value, super.filterOtherCustomers,
        () {
      super.filterOtherCustomers = value;
    });
  }

  late final _$_CustomerListStoreBaseActionController =
      ActionController(name: '_CustomerListStoreBase', context: context);

  @override
  void toggleViewTypes() {
    final _$actionInfo = _$_CustomerListStoreBaseActionController.startAction(
        name: '_CustomerListStoreBase.toggleViewTypes');
    try {
      return super.toggleViewTypes();
    } finally {
      _$_CustomerListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFilterMyCustomers() {
    final _$actionInfo = _$_CustomerListStoreBaseActionController.startAction(
        name: '_CustomerListStoreBase.toggleFilterMyCustomers');
    try {
      return super.toggleFilterMyCustomers();
    } finally {
      _$_CustomerListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFilterOtherCustomers() {
    final _$actionInfo = _$_CustomerListStoreBaseActionController.startAction(
        name: '_CustomerListStoreBase.toggleFilterOtherCustomers');
    try {
      return super.toggleFilterOtherCustomers();
    } finally {
      _$_CustomerListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewTypes: ${viewTypes},
filterMyCustomers: ${filterMyCustomers},
filterOtherCustomers: ${filterOtherCustomers},
isListView: ${isListView}
    ''';
  }
}
