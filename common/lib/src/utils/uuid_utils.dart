import 'package:uuid/uuid.dart';

// Interface:-------------------------------------------------------------------
abstract class UuidUtilsInterface {
  String generate();
}

// Implementation:--------------------------------------------------------------
class UuidUtils implements UuidUtilsInterface {
  UuidUtils();

  final Uuid _uuid = const Uuid();

  @override
  String generate() {
    return _uuid.v4();
  }
}
