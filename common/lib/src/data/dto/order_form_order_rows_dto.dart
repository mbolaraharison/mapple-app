import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/data/dto/order_form_order_rows_supplier_dto.dart';
import 'package:maple_common/src/exceptions/dto_exception.dart';

class OrderFormOrderRowsDto {
  final String code;
  final String label;
  final String designation;
  final String quantity;
  final String unit;
  final String grossPrice;
  final String totalGrossExclTax;
  final String tax;
  final String grossTaxAmount;
  final String totalGrossInclTax;
  final String options;
  final OrderFormOrderRowsSupplierDto? suppliersDto;

  OrderFormOrderRowsDto({
    required this.code,
    required this.label,
    required this.designation,
    required this.quantity,
    required this.unit,
    required this.grossPrice,
    required this.totalGrossExclTax,
    required this.tax,
    required this.grossTaxAmount,
    required this.totalGrossInclTax,
    required this.options,
    this.suppliersDto,
  });

  void verify() {
    if (code.isEmpty) {
      throw DtoException('order_form.generate_errors.order_rows_dto.code'.tr());
    }
    if (label.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_rows_dto.label'.tr());
    }
    if (designation.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_rows_dto.designation'.tr());
    }
    if (quantity.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_rows_dto.quantity'.tr());
    }
    if (unit.isEmpty) {
      throw DtoException('order_form.generate_errors.order_rows_dto.unit'.tr());
    }
    if (grossPrice.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_rows_dto.grossPrice'.tr());
    }
    if (totalGrossExclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_rows_dto.totalGrossExclTax'.tr());
    }
    if (tax.isEmpty) {
      throw DtoException('order_form.generate_errors.order_rows_dto.tax'.tr());
    }
    if (grossTaxAmount.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_rows_dto.grossTaxAmount'.tr());
    }
    if (totalGrossInclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_rows_dto.totalGrossInclTax'.tr());
    }
    // Suppliers
    if (suppliersDto != null) {
      suppliersDto!.verify();
    }
  }
}
