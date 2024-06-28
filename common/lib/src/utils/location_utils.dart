import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

// Interface:-------------------------------------------------------------------
abstract class LocationUtilsInterface {
  Future<double> getDistanceBetweenTwoLocations(
    GeoPoint location1,
    GeoPoint location2,
  );
}

// Implementation:--------------------------------------------------------------
class LocationUtils implements LocationUtilsInterface {
  @override
  Future<double> getDistanceBetweenTwoLocations(
    GeoPoint location1,
    GeoPoint location2,
  ) async {
    double distanceInMeters = Geolocator.distanceBetween(
      location1.latitude,
      location1.longitude,
      location2.latitude,
      location2.longitude,
    );

    return distanceInMeters;
  }
}
