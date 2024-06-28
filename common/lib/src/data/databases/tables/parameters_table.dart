import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Parameter)
class Parameters extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
