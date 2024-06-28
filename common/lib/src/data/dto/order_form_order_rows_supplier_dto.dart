import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/exceptions/dto_exception.dart';

class OrderFormOrderRowsSupplierDto {
  final String projectEndDate;
  final String name;
  final String address;
  final String postalCodeCity;
  final String siret;
  final String rgeCertificateNumber;
  final String rgeQualification;

  final String suppliesGrossPrice;
  final String suppliesTotalGrossExclTax;
  final String suppliesGrossTaxAmount;
  final String suppliesTotalGrossInclTax;

  final String? workforceGrossPrice;
  final String? workforceTotalGrossExclTax;
  final String? workforceGrossTaxAmount;
  final String? workforceTotalGrossInclTax;

  OrderFormOrderRowsSupplierDto({
    required this.projectEndDate,
    required this.name,
    required this.address,
    required this.postalCodeCity,
    required this.siret,
    required this.rgeCertificateNumber,
    required this.rgeQualification,
    required this.suppliesGrossPrice,
    required this.suppliesTotalGrossExclTax,
    required this.suppliesGrossTaxAmount,
    required this.suppliesTotalGrossInclTax,
    this.workforceGrossPrice,
    this.workforceTotalGrossExclTax,
    this.workforceGrossTaxAmount,
    this.workforceTotalGrossInclTax,
  });

  void verify() {
    if (projectEndDate.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.project_end_date'.tr());
    }
    if (name.isEmpty) {
      throw DtoException('order_form.generate_errors.supplier_dto.name'.tr());
    }
    if (address.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.address'.tr());
    }
    if (postalCodeCity.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.postal_code_city'.tr());
    }
    if (siret.isEmpty) {
      throw DtoException('order_form.generate_errors.supplier_dto.siret'.tr());
    }
    if (rgeCertificateNumber.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.rge_certificate_number'
              .tr());
    }
    if (rgeQualification.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.rge_qualification'.tr());
    }
    if (suppliesGrossPrice.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.supplies_gross_price'.tr());
    }
    if (suppliesTotalGrossExclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.supplies_total_gross_excl_tax'
              .tr());
    }
    if (suppliesGrossTaxAmount.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.supplies_gross_tax_amount'
              .tr());
    }
    if (suppliesTotalGrossInclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.supplier_dto.supplies_total_gross_incl_tax'
              .tr());
    }

    var withWorkforce = workforceGrossPrice is String ||
        workforceTotalGrossExclTax != null ||
        workforceGrossTaxAmount != null ||
        workforceTotalGrossInclTax != null;
    if (withWorkforce) {
      if (workforceGrossPrice == null || workforceGrossPrice!.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.supplier_dto.workforce_gross_price'
                .tr());
      }
      if (workforceTotalGrossExclTax == null ||
          workforceTotalGrossExclTax!.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.supplier_dto.workforce_total_gross_excl_tax'
                .tr());
      }
      if (workforceGrossTaxAmount == null || workforceGrossTaxAmount!.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.supplier_dto.workforce_gross_tax_amount'
                .tr());
      }
      if (workforceTotalGrossInclTax == null ||
          workforceTotalGrossInclTax!.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.supplier_dto.workforce_total_gross_incl_tax'
                .tr());
      }
    }
  }
}
