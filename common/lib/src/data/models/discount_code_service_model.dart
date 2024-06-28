import 'package:drift/drift.dart';

class DiscountCodeService extends Insertable<DiscountCodeService> {
  // Constructors:--------------------------------------------------------------
  DiscountCodeService({
    required this.discountCodeId,
    required this.serviceId,
  });

  // Variables:-----------------------------------------------------------------
  String discountCodeId;
  String serviceId;

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'discount_code_id': Variable<String>(discountCodeId),
      'service_id': Variable<String>(serviceId),
    };
  }
}
