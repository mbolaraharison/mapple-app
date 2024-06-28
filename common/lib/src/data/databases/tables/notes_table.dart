import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Note)
class Notes extends Table with DefaultTable {
  TextColumn get representativeId => text().references(Representatives, #id)();
  TextColumn get customerId => text().references(Customers, #id)();
  TextColumn get agencyId => text().references(Agencies, #id)();
  TextColumn get title => text().nullable()();
  TextColumn get note => text()();

  @override
  Set<Column> get primaryKey => {id};
}
