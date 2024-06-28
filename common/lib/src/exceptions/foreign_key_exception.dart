import 'dart:convert';

class ForeignKeyException implements Exception {
  String message = 'Foreign key check failed.';

  List<Map<String, String>> errors = [];

  String get errorsString {
    return json.encode(errors);
  }

  ForeignKeyException(this.errors);

  @override
  String toString() => message;
}
