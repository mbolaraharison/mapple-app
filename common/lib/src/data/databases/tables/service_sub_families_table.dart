import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(ServiceSubFamily)
class ServiceSubFamilies extends Table with DefaultTable {
  TextColumn get label => text()();
  TextColumn get familyId => text().references(ServiceFamilies, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
