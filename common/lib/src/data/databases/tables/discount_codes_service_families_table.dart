import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(DiscountCodeServiceFamily)
class DiscountCodesServiceFamilies extends Table {
  TextColumn get discountCodeId => text().references(DiscountCodes, #id)();
  TextColumn get serviceFamilyId => text().references(ServiceFamilies, #id)();

  @override
  Set<Column> get primaryKey => {discountCodeId, serviceFamilyId};
}
