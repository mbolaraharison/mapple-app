import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(ServiceOption)
class ServiceOptions extends Table with DefaultTable {
  TextColumn get serviceId => text().references(Services, #id)();
  TextColumn get agencyId => text().nullable().references(Agencies, #id)();
  TextColumn get option1Id => text().references(ServiceOptionItems, #id)();
  TextColumn get option2Id =>
      text().nullable().references(ServiceOptionItems, #id)();
  TextColumn get designation => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
