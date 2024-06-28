import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'customers_list_view_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomersListViewStoreInterface {
  CustomersListViewStoreInterface._(this.search);

  CustomersListViewStoreParams get params;

  String search;
  Stream<List<Customer>> get filteredCustomers;
  void setSearch(String value);
  void dispose();
}

// Params:----------------------------------------------------------------------
class CustomersListViewStoreParams {
  const CustomersListViewStoreParams({
    required this.customerListStore,
  });

  final CustomerListStoreInterface customerListStore;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CustomersListViewStore = _CustomersListViewStoreBase
    with _$CustomersListViewStore;

abstract class _CustomersListViewStoreBase
    with Store
    implements CustomersListViewStoreInterface {
  // Constructor:---------------------------------------------------------------
  _CustomersListViewStoreBase({required this.params}) {
    _initStreams();
  }

  // Stores:--------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  String search = '';

  // Other variables:-----------------------------------------------------------
  StreamSubscription<Representative?>? _currentRepresentativeSubscription;

  @override
  CustomersListViewStoreParams params;

  @observable
  Representative? _currentRepresentative;

  // Computed:------------------------------------------------------------------
  @computed
  String get searchableSearch => '%${search.toSearchable()}%';

  @override
  @computed
  Stream<List<Customer>> get filteredCustomers {
    if (search.isEmpty) {
      if (params.customerListStore.filterMyCustomers &&
          params.customerListStore.filterOtherCustomers) {
        return _customerService.getAllAsStream();
      }

      if (params.customerListStore.filterMyCustomers) {
        return _customerService.getByRepresentativeIdAsStream(
          _currentRepresentative!.id,
        );
      }

      if (params.customerListStore.filterOtherCustomers) {
        return _customerService.getByOtherOrderRepresentativeIdAsStream(
          _currentRepresentative!.id,
        );
      }

      return Stream.value([]);
    }

    if (params.customerListStore.filterMyCustomers &&
        params.customerListStore.filterOtherCustomers) {
      return _customerService.searchAsStream(searchableSearch);
    }

    if (params.customerListStore.filterMyCustomers) {
      return _customerService.getByRepresentativeIdAsStream(
          _currentRepresentative!.id,
          search: searchableSearch);
    }

    if (params.customerListStore.filterOtherCustomers) {
      return _customerService.getByOtherOrderRepresentativeIdAsStream(
          _currentRepresentative!.id,
          search: searchableSearch);
    }

    return Stream.value([]);
  }

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setSearch(String value) => search = value;

  // Other methods:-------------------------------------------------------------
  void _initStreams() {
    _currentRepresentativeSubscription?.cancel();
    _currentRepresentativeSubscription =
        _representativeService.getCurrentAsStream().listen((event) {
      _currentRepresentative = event;
    });
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _currentRepresentativeSubscription?.cancel();
  }
}
