import 'package:mobx/mobx.dart';

part 'customers_map_view_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomersMapViewStoreInterface {
  CustomersMapViewStoreInterface._(this.isMapReady);

  bool isMapReady;

  void setMapReady();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CustomersMapViewStore = _CustomersMapViewStoreBase
    with _$CustomersMapViewStore;

abstract class _CustomersMapViewStoreBase
    with Store
    implements CustomersMapViewStoreInterface {
  // Variables:-----------------------------------------------------------------
  @override
  @observable
  bool isMapReady = false;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setMapReady() {
    isMapReady = true;
  }
}
