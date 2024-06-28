import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

part 'location_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class LocationStoreInterface {
  bool get serviceEnabled;

  LocationData? get currentLocation;

  PermissionStatus? get permissionGranted;

  bool get locationIsEnabled;

  @protected
  Future<void> init();

  Future<void> getCurrentLocation();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class LocationStore = _LocationStoreBase with _$LocationStore;

abstract class _LocationStoreBase with Store implements LocationStoreInterface {
  _LocationStoreBase() {
    init();
  }

  // Services:------------------------------------------------------------------
  late final Location _location = Location();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  bool serviceEnabled = false;

  @override
  @observable
  LocationData? currentLocation;

  @override
  @observable
  PermissionStatus? permissionGranted;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get locationIsEnabled =>
      serviceEnabled && permissionGranted == PermissionStatus.granted;

  // Action:--------------------------------------------------------------------
  @override
  @action
  Future<void> init() async {
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    getCurrentLocation();
  }

  @override
  @action
  Future<void> getCurrentLocation() async {
    currentLocation = await _location.getLocation();
  }
}
