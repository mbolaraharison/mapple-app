import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(PriceListItem)
class PriceListItems extends Table with DefaultTable {
  TextColumn get priceListId => text().references(PriceLists, #id)();
  TextColumn get agencyId => text().nullable().references(Agencies, #id)();
  TextColumn get option1Id =>
      text().nullable().references(ServiceOptionItems, #id)();
  TextColumn get option2Id =>
      text().nullable().references(ServiceOptionItems, #id)();
  RealColumn get minQuantity => real()();
  RealColumn get maxQuantity => real()();
  RealColumn get price => real()();
  TextColumn get unit => text()();

  @override
  Set<Column> get primaryKey => {id};
}
