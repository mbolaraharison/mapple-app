import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(ServiceOptionItem)
class ServiceOptionItems extends Table with DefaultTable {
  TextColumn get label => text()();
  IntColumn get type => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
