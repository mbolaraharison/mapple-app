import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class NavigationStoreInterface {
  NavigationStoreInterface._(this.currentTab);

  // store variables:-----------------------------------------------------------
  Tab currentTab;

  // Computed:------------------------------------------------------------------
  int get currentIndex;

  // actions:-------------------------------------------------------------------
  void setTab(Tab tab);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class NavigationStore = _NavigationStore with _$NavigationStore;

abstract class _NavigationStore with Store implements NavigationStoreInterface {
  // store variables:-----------------------------------------------------------
  @override
  @observable
  Tab currentTab = Tab.home;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  int get currentIndex => currentTab.index;

  // actions:-------------------------------------------------------------------
  @override
  @action
  void setTab(Tab tab) {
    currentTab = tab;
  }
}
