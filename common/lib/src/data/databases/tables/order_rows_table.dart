import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(OrderRow)
class OrderRows extends Table with DefaultTable {
  TextColumn get orderId => text().references(Orders, #id)();
  TextColumn get agencyId => text().references(Agencies, #id)();
  TextColumn get serviceId => text().references(Services, #id)();
  TextColumn get designation => text()();
  RealColumn get discount => real().nullable()();
  TextColumn get option1Id =>
      text().nullable().references(ServiceOptionItems, #id)();
  TextColumn get option2Id =>
      text().nullable().references(ServiceOptionItems, #id)();
  RealColumn get quantity => real()();
  RealColumn get grossPrice => real()();
  TextColumn get unit => text()();
  TextColumn get taxLevel => textEnum<TaxLevel>()();
  TextColumn get discountCodeId =>
      text().nullable().references(DiscountCodes, #id)();
  TextColumn get priceListItemId =>
      text().nullable().references(PriceListItems, #id)();
  BoolColumn get optionsHaveChanged =>
      boolean().withDefault(const Constant(false))();
  TextColumn get supplierId => text().nullable().references(Suppliers, #id)();
  BoolColumn get withWorkforce =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
