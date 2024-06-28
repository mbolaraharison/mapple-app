// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerViewStore on _CustomerViewStoreBase, Store {
  Computed<String>? _$formattedDistanceToCustomerAddressComputed;

  @override
  String get formattedDistanceToCustomerAddress =>
      (_$formattedDistanceToCustomerAddressComputed ??= Computed<String>(
              () => super.formattedDistanceToCustomerAddress,
              name:
                  '_CustomerViewStoreBase.formattedDistanceToCustomerAddress'))
          .value;
  Computed<String>? _$searchableSearchComputed;

  @override
  String get searchableSearch => (_$searchableSearchComputed ??=
          Computed<String>(() => super.searchableSearch,
              name: '_CustomerViewStoreBase.searchableSearch'))
      .value;
  Computed<Stream<List<FileData>>>? _$filteredQuoteFileDataStreamComputed;

  @override
  Stream<List<FileData>> get filteredQuoteFileDataStream =>
      (_$filteredQuoteFileDataStreamComputed ??=
              Computed<Stream<List<FileData>>>(
                  () => super.filteredQuoteFileDataStream,
                  name: '_CustomerViewStoreBase.filteredQuoteFileDataStream'))
          .value;
  Computed<Stream<List<FileData>>>? _$filteredNormalFileDataStreamComputed;

  @override
  Stream<List<FileData>> get filteredNormalFileDataStream =>
      (_$filteredNormalFileDataStreamComputed ??=
              Computed<Stream<List<FileData>>>(
                  () => super.filteredNormalFileDataStream,
                  name: '_CustomerViewStoreBase.filteredNormalFileDataStream'))
          .value;

  late final _$customerAtom =
      Atom(name: '_CustomerViewStoreBase.customer', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_CustomerViewStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectedTabAtom =
      Atom(name: '_CustomerViewStoreBase.selectedTab', context: context);

  @override
  int? get selectedTab {
    _$selectedTabAtom.reportRead();
    return super.selectedTab;
  }

  @override
  set selectedTab(int? value) {
    _$selectedTabAtom.reportWrite(value, super.selectedTab, () {
      super.selectedTab = value;
    });
  }

  late final _$contactsAtom =
      Atom(name: '_CustomerViewStoreBase.contacts', context: context);

  @override
  ObservableList<Contact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<Contact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$ordersAtom =
      Atom(name: '_CustomerViewStoreBase.orders', context: context);

  @override
  ObservableList<Order> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<Order> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$notesAtom =
      Atom(name: '_CustomerViewStoreBase.notes', context: context);

  @override
  ObservableList<Note> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<Note> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$servicesAtom =
      Atom(name: '_CustomerViewStoreBase.services', context: context);

  @override
  ObservableList<Service> get services {
    _$servicesAtom.reportRead();
    return super.services;
  }

  @override
  set services(ObservableList<Service> value) {
    _$servicesAtom.reportWrite(value, super.services, () {
      super.services = value;
    });
  }

  late final _$distanceToCustomerAddressAtom = Atom(
      name: '_CustomerViewStoreBase.distanceToCustomerAddress',
      context: context);

  @override
  double get distanceToCustomerAddress {
    _$distanceToCustomerAddressAtom.reportRead();
    return super.distanceToCustomerAddress;
  }

  @override
  set distanceToCustomerAddress(double value) {
    _$distanceToCustomerAddressAtom
        .reportWrite(value, super.distanceToCustomerAddress, () {
      super.distanceToCustomerAddress = value;
    });
  }

  late final _$searchAtom =
      Atom(name: '_CustomerViewStoreBase.search', context: context);

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

  late final _$loadAndWatchContactsAsyncAction = AsyncAction(
      '_CustomerViewStoreBase.loadAndWatchContacts',
      context: context);

  @override
  Future<void> loadAndWatchContacts() {
    return _$loadAndWatchContactsAsyncAction
        .run(() => super.loadAndWatchContacts());
  }

  late final _$loadAndWatchOrdersAsyncAction = AsyncAction(
      '_CustomerViewStoreBase.loadAndWatchOrders',
      context: context);

  @override
  Future<void> loadAndWatchOrders() {
    return _$loadAndWatchOrdersAsyncAction
        .run(() => super.loadAndWatchOrders());
  }

  late final _$loadAndWatchNotesAsyncAction =
      AsyncAction('_CustomerViewStoreBase.loadAndWatchNotes', context: context);

  @override
  Future<void> loadAndWatchNotes() {
    return _$loadAndWatchNotesAsyncAction.run(() => super.loadAndWatchNotes());
  }

  late final _$getDistanceToCustomerAddressAsyncAction = AsyncAction(
      '_CustomerViewStoreBase.getDistanceToCustomerAddress',
      context: context);

  @override
  Future<void> getDistanceToCustomerAddress() {
    return _$getDistanceToCustomerAddressAsyncAction
        .run(() => super.getDistanceToCustomerAddress());
  }

  late final _$initAsyncAction =
      AsyncAction('_CustomerViewStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_CustomerViewStoreBaseActionController =
      ActionController(name: '_CustomerViewStoreBase', context: context);

  @override
  void watchCustomer() {
    final _$actionInfo = _$_CustomerViewStoreBaseActionController.startAction(
        name: '_CustomerViewStoreBase.watchCustomer');
    try {
      return super.watchCustomer();
    } finally {
      _$_CustomerViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTab(int? index) {
    final _$actionInfo = _$_CustomerViewStoreBaseActionController.startAction(
        name: '_CustomerViewStoreBase.setSelectedTab');
    try {
      return super.setSelectedTab(index);
    } finally {
      _$_CustomerViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearch(String value) {
    final _$actionInfo = _$_CustomerViewStoreBaseActionController.startAction(
        name: '_CustomerViewStoreBase.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$_CustomerViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customer: ${customer},
isLoading: ${isLoading},
selectedTab: ${selectedTab},
contacts: ${contacts},
orders: ${orders},
notes: ${notes},
services: ${services},
distanceToCustomerAddress: ${distanceToCustomerAddress},
search: ${search},
formattedDistanceToCustomerAddress: ${formattedDistanceToCustomerAddress},
searchableSearch: ${searchableSearch},
filteredQuoteFileDataStream: ${filteredQuoteFileDataStream},
filteredNormalFileDataStream: ${filteredNormalFileDataStream}
    ''';
  }
}
