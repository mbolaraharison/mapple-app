// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServicesSearchStore on _ServicesSearchStoreBase, Store {
  Computed<String>? _$searchableSearchComputed;

  @override
  String get searchableSearch => (_$searchableSearchComputed ??=
          Computed<String>(() => super.searchableSearch,
              name: '_ServicesSearchStoreBase.searchableSearch'))
      .value;

  late final _$viewTypesAtom =
      Atom(name: '_ServicesSearchStoreBase.viewTypes', context: context);

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

  late final _$filterMyCustomersAtom = Atom(
      name: '_ServicesSearchStoreBase.filterMyCustomers', context: context);

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
      name: '_ServicesSearchStoreBase.filterOtherCustomers', context: context);

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

  late final _$searchAtom =
      Atom(name: '_ServicesSearchStoreBase.search', context: context);

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$_ServicesSearchStoreBaseActionController =
      ActionController(name: '_ServicesSearchStoreBase', context: context);

  @override
  void setSearch(String value) {
    final _$actionInfo = _$_ServicesSearchStoreBaseActionController.startAction(
        name: '_ServicesSearchStoreBase.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$_ServicesSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewTypes: ${viewTypes},
filterMyCustomers: ${filterMyCustomers},
filterOtherCustomers: ${filterOtherCustomers},
search: ${search},
searchableSearch: ${searchableSearch}
    ''';
  }
}
