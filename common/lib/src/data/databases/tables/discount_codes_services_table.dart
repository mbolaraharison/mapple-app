import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(DiscountCodeService)
class DiscountCodesServices extends Table {
  TextColumn get discountCodeId => text().references(DiscountCodes, #id)();
  TextColumn get serviceId => text().references(Services, #id)();

  @override
  Set<Column> get primaryKey => {discountCodeId, serviceId};
}
