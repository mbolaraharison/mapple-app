import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'customer_list_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerListStoreInterface {
  CustomerListStoreInterface._(
    this.viewTypes,
    this.filterMyCustomers,
    this.filterOtherCustomers,
  );

  CustomerListViewTypes viewTypes;

  bool filterMyCustomers;

  bool filterOtherCustomers;

  bool get isListView;

  void toggleViewTypes();

  void toggleFilterMyCustomers();

  void toggleFilterOtherCustomers();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CustomerListStore = _CustomerListStoreBase with _$CustomerListStore;

abstract class _CustomerListStoreBase
    with Store
    implements CustomerListStoreInterface {
  _CustomerListStoreBase();

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

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get isListView => viewTypes == CustomerListViewTypes.list;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void toggleViewTypes() {
    viewTypes = viewTypes == CustomerListViewTypes.list
        ? CustomerListViewTypes.map
        : CustomerListViewTypes.list;
  }

  @override
  @action
  void toggleFilterMyCustomers() {
    filterMyCustomers = !filterMyCustomers;
  }

  @override
  @action
  void toggleFilterOtherCustomers() {
    filterOtherCustomers = !filterOtherCustomers;
  }
}
