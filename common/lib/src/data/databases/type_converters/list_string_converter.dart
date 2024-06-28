import 'dart:convert';
import 'package:drift/drift.dart';

class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();

  @override
  List<String> fromSql(String fromDb) {
    List<dynamic> decoded = json.decode(fromDb);
    List<String> result = [];
    for (dynamic item in decoded) {
      result.add(item.toString());
    }
    return result;
  }

  @override
  String toSql(List<String> value) {
    List<dynamic> encoded = [];
    for (String item in value) {
      encoded.add(item);
    }
    return json.encode(encoded);
  }
}
