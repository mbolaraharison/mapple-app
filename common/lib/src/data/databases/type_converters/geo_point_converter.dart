import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';

class GeoPointConverter extends TypeConverter<GeoPoint, String> {
  const GeoPointConverter();

  @override
  GeoPoint fromSql(String fromDb) {
    Map<String, dynamic> json = jsonDecode(fromDb);
    return GeoPoint(json['latitude'], json['longitude']);
  }

  @override
  String toSql(GeoPoint value) {
    Map<String, dynamic> json = {
      'latitude': value.latitude,
      'longitude': value.longitude,
    };
    return jsonEncode(json);
  }
}
