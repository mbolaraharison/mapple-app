import 'package:drift/drift.dart';

class DiscountCodeServiceFamily extends Insertable<DiscountCodeServiceFamily> {
  // Constructors:--------------------------------------------------------------
  DiscountCodeServiceFamily({
    required this.discountCodeId,
    required this.serviceFamilyId,
  });

  // Variables:-----------------------------------------------------------------
  String discountCodeId;
  String serviceFamilyId;

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'discount_code_id': Variable<String>(discountCodeId),
      'service_family_id': Variable<String>(serviceFamilyId),
    };
  }
}
