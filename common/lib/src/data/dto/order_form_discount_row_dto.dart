import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/exceptions/dto_exception.dart';

class OrderFormDiscountRowDto {
  final String code;
  final String label;
  final String discount;
  final String totalNetInclTax;

  OrderFormDiscountRowDto({
    required this.code,
    required this.label,
    required this.discount,
    required this.totalNetInclTax,
  });

  void verify() {
    if (code.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.discount_row_dto.code'.tr());
    }
    if (label.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.discount_row_dto.label'.tr());
    }
    if (discount.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.discount_row_dto.discount'.tr());
    }
    if (totalNetInclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.discount_row_dto.total_net_incl_tax'
              .tr());
    }
  }
}
