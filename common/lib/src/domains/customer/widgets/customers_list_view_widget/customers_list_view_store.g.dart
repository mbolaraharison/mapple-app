// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_list_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomersListViewStore on _CustomersListViewStoreBase, Store {
  Computed<String>? _$searchableSearchComputed;

  @override
  String get searchableSearch => (_$searchableSearchComputed ??=
          Computed<String>(() => super.searchableSearch,
              name: '_CustomersListViewStoreBase.searchableSearch'))
      .value;
  Computed<Stream<List<Customer>>>? _$filteredCustomersComputed;

  @override
  Stream<List<Customer>> get filteredCustomers =>
      (_$filteredCustomersComputed ??= Computed<Stream<List<Customer>>>(
              () => super.filteredCustomers,
              name: '_CustomersListViewStoreBase.filteredCustomers'))
          .value;

  late final _$searchAtom =
      Atom(name: '_CustomersListViewStoreBase.search', context: context);

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

  late final _$_currentRepresentativeAtom = Atom(
      name: '_CustomersListViewStoreBase._currentRepresentative',
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

  late final _$_CustomersListViewStoreBaseActionController =
      ActionController(name: '_CustomersListViewStoreBase', context: context);

  @override
  void setSearch(String value) {
    final _$actionInfo = _$_CustomersListViewStoreBaseActionController
        .startAction(name: '_CustomersListViewStoreBase.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$_CustomersListViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
searchableSearch: ${searchableSearch},
filteredCustomers: ${filteredCustomers}
    ''';
  }
}
