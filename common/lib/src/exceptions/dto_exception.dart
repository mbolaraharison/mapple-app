import 'package:maple_common/maple_common.dart';

class DtoException implements ValidationException {
  @override
  final String message;

  DtoException(this.message);

  @override
  String toString() => message;
}
