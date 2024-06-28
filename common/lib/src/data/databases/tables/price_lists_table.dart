import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(PriceList)
class PriceLists extends Table with DefaultTable {
  TextColumn get serviceId => text().references(Services, #id)();
  TextColumn get agencyId => text().nullable().references(Agencies, #id)();
  TextColumn get priceListType => textEnum<PriceListType>()();
  IntColumn get priority => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
