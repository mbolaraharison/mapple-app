import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'services_search_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ServicesSearchStoreInterface {
  ServicesSearchStoreInterface._(
    this.viewTypes,
    this.filterMyCustomers,
    this.filterOtherCustomers,
    this.search,
  );
  // Variables
  CustomerListViewTypes viewTypes;
  bool filterMyCustomers;
  bool filterOtherCustomers;
  String search;

  // Computed
  String get searchableSearch;

  // Methods
  void setSearch(String value);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ServicesSearchStore = _ServicesSearchStoreBase with _$ServicesSearchStore;

abstract class _ServicesSearchStoreBase
    with Store
    implements ServicesSearchStoreInterface {
  _ServicesSearchStoreBase();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  CustomerListViewTypes viewTypes = CustomerListViewTypes.list;

  @override
  @observable
  bool filterMyCustomers = true;

  @override
  @observable
  bool filterOtherCustomers = true;

  @override
  @observable
  String search = '';

  // Computed:------------------------------------------------------------------
  @override
  @computed
  String get searchableSearch => '%${search.toSearchable()}%';

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setSearch(String value) {
    search = value;
  }
}
