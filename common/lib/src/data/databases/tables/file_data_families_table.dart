import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(FileDataFamily)
class FileDataFamilies extends Table with DefaultTable {
  TextColumn get label => text()();
  TextColumn get backgroundImage => text()();
  TextColumn get icon => text()();

  @override
  Set<Column> get primaryKey => {id};
}
