import 'package:drift/drift.dart';

class DiscountCodeServiceSubFamily
    extends Insertable<DiscountCodeServiceSubFamily> {
  // Constructors:--------------------------------------------------------------
  DiscountCodeServiceSubFamily({
    required this.discountCodeId,
    required this.serviceSubFamilyId,
  });

  // Variables:-----------------------------------------------------------------
  String discountCodeId;
  String serviceSubFamilyId;

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'discount_code_id': Variable<String>(discountCodeId),
      'service_sub_family_id': Variable<String>(serviceSubFamilyId),
    };
  }
}
