import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(DiscountCodeServiceSubFamily)
class DiscountCodesServiceSubFamilies extends Table {
  TextColumn get discountCodeId => text().references(DiscountCodes, #id)();
  TextColumn get serviceSubFamilyId =>
      text().references(ServiceSubFamilies, #id)();

  @override
  Set<Column> get primaryKey => {discountCodeId, serviceSubFamilyId};
}
