import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(DiscountCode)
class DiscountCodes extends Table with DefaultTable {
  TextColumn get code => text()();
  TextColumn get type => textEnum<DiscountCodeType>()();
  RealColumn get discount => real()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get agencyId => text().nullable().references(Agencies, #id)();
  TextColumn get userId => text().nullable().references(Representatives, #id)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
