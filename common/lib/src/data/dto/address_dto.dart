import 'package:cloud_firestore/cloud_firestore.dart';

class AddressDTO {
  const AddressDTO({
    required this.address,
    required this.postalCode,
    required this.city,
    this.location,
  });

  final String address;
  final String postalCode;
  final String city;
  final GeoPoint? location;
}
