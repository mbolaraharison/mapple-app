import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:maple_common/maple_common.dart';
import 'package:maple_common/src/data/dto/order_form_order_rows_supplier_dto.dart';
import 'package:maple_common/src/exceptions/dto_exception.dart';
import 'package:pdf/widgets.dart' as pw;

// Theme:-----------------------------------------------------------------------
abstract class OrderFormDtoThemeInterface {
  String get logoWithTextImage;
}

// DTO:-------------------------------------------------------------------------
class OrderFormDto {
  // Constructor:---------------------------------------------------------------
  OrderFormDto({
    // Agency
    required this.agencyLabel,
    required this.agencyAddress,
    required this.agencyPostalCode,
    required this.agencyCity,
    required this.agencyPhone,
    required this.agencyEmail,
    required this.agencySiret,
    required this.agencyNaf,
    // Customer
    required this.customerAddress,
    required this.customerPostalCode,
    required this.customerCity,
    required this.customerContacts,
    // Order
    required this.orderHasCustomerSiteDetails,
    required this.orderAddress,
    required this.orderPostalCode,
    required this.orderCity,
    required this.orderNumber,
    required this.orderRows,
    required this.orderTotalGrossExclTax,
    required this.orderTotalGrossInclTax,
    required this.orderDiscountRows,
    required this.orderTotalNetInclTax,
    required this.orderTaxColumns,
    required this.isCashPayment,
    required this.cashPaymentMethod,
    required this.isFinancingPayment,
    required this.funder,
    required this.hasDeposit,
    required this.deposit,
    required this.intermediatePayment,
    required this.endOfWorkPayment,
    required this.credit,
    required this.monthlyPaymentsCount,
    required this.creditTotalCost,
    required this.monthlyPaymentAmount,
    required this.nominalRate,
    required this.apr,
    required this.insuranceType,
    required this.deferment,
    required this.installationDate,
    required this.deadlineDate,
    required this.keepOldStuff,
    // Representative
    required this.representatives,
    required this.hasFairAccess,
    // Fair
    required this.fairCity,
    // Others
    required this.isOrderForm,
    required this.logo,
    required this.terms,
  });

  // Variables:-----------------------------------------------------------------
  // Agency
  final String agencyLabel;
  final String agencyAddress;
  final String agencyPostalCode;
  final String agencyCity;
  final String agencyPhone;
  final String agencyEmail;
  final String agencySiret;
  final String agencyNaf;

  // Customer
  final String customerAddress;
  final String customerPostalCode;
  final String customerCity;
  final List<OrderFormContactDto> customerContacts;

  // Order
  final bool orderHasCustomerSiteDetails;
  final String orderAddress;
  final String orderPostalCode;
  final String orderCity;
  final String orderNumber;
  final List<OrderFormOrderRowsDto> orderRows;
  final String orderTotalGrossExclTax;
  final String orderTotalGrossInclTax;
  final List<OrderFormDiscountRowDto> orderDiscountRows;
  final String orderTotalNetInclTax;
  final Map<TaxLevel, OrderFormTaxColumnDto> orderTaxColumns;
  final bool isCashPayment;
  final String cashPaymentMethod;
  final bool isFinancingPayment;
  final String funder;
  final bool hasDeposit;
  final String deposit;
  final String intermediatePayment;
  final String endOfWorkPayment;
  final String credit;
  final String monthlyPaymentsCount;
  final String creditTotalCost;
  final String monthlyPaymentAmount;
  final String nominalRate;
  final String apr;
  final String insuranceType;
  final String deferment;
  final String installationDate;
  final String deadlineDate;
  final bool keepOldStuff;

  // Representative
  final List<OrderFormRepresentativeDto> representatives;
  final bool hasFairAccess;

  // Fair
  final String fairCity;

  // Others
  final bool isOrderForm;
  final pw.MemoryImage logo;
  final String terms;

  // Getters:-------------------------------------------------------------------
  String get dateTimeString =>
      DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  String get dateString => DateFormat('dd/MM/yyyy').format(DateTime.now());

  // Static methods:------------------------------------------------------------
  static Future<OrderFormDto> create({
    required Order order,
    required Representative representative,
    required bool isOrderForm,
    List<Representative> representatives = const [],
    Fair? fair,
  }) async {
    // Theme
    OrderFormDtoThemeInterface theme = getIt<OrderFormDtoThemeInterface>();

    for (int i = 0; i < order.orderRows.length; i++) {
      await order.orderRows[i].loadData(eager: true);
    }
    // Dependencies
    NumberFormatterUtilsInterface numberFormatterUtils =
        getIt<NumberFormatterUtilsInterface>();
    UserSettingServiceInterface userSettingService =
        getIt<UserSettingServiceInterface>();

    // Agency
    Agency agency = representative.agency!;
    // Customer
    Customer customer = order.customer!;
    List<OrderFormContactDto> customerContacts = order.contactsList
        .map((contact) => OrderFormContactDto(
              fullName: contact.fullNameWithCivility,
              phone: contact.formattedPhone.trim(),
              mobilePhone: contact.formattedMobilePhone.trim(),
              email: contact.email,
            ))
        .toList();

    // Order
    List<OrderFormDiscountRowDto> orderDiscountRows = [];
    List<OrderFormOrderRowsDto> orderRows = order.orderRows.map((orderRow) {
      // Check if the order row is a discount row
      if (orderRow.discount != null && orderRow.discount != 0) {
        orderDiscountRows.add(OrderFormDiscountRowDto(
          code: orderRow.service!.sageId,
          label: orderRow.service!.label,
          discount: orderRow.formattedDiscount,
          totalNetInclTax: numberFormatterUtils.formatToCurrency(
            orderRow.totalNetInclTax,
            withSymbol: false,
          ),
        ));
      }

      // Suppliers information
      OrderFormOrderRowsSupplierDto? supplierDto;
      if (orderRow.supplier != null) {
        double suppliesPercentage = orderRow.withWorkforce ? 0.8 : 1;
        double workforcePercentage = 0.2;

        supplierDto = OrderFormOrderRowsSupplierDto(
          projectEndDate: order.endProjectAt != null
              ? getIt<DateTimeUtilsInterface>()
                  .formatToFrenchDate(order.endProjectAt!)
              : '',
          name: orderRow.supplier!.name ?? '',
          address: orderRow.supplier!.address ?? '',
          postalCodeCity:
              '${orderRow.supplier!.postalCode} ' ' ${orderRow.supplier!.city}',
          siret: orderRow.supplier!.siret ?? '',
          rgeCertificateNumber: orderRow.supplier!.rgeCertificateNumber ?? '',
          rgeQualification: orderRow.supplier!.rgeQualification ?? '',
          suppliesGrossPrice: numberFormatterUtils.formatToCurrency(
            orderRow.grossPrice * suppliesPercentage,
            withSymbol: false,
          ),
          suppliesTotalGrossExclTax: numberFormatterUtils.formatToCurrency(
            orderRow.totalGrossExclTax * suppliesPercentage,
            withSymbol: false,
          ),
          suppliesGrossTaxAmount: numberFormatterUtils.formatToCurrency(
            orderRow.grossTaxAmount * suppliesPercentage,
            withSymbol: false,
          ),
          suppliesTotalGrossInclTax: numberFormatterUtils.formatToCurrency(
            orderRow.totalGrossInclTax * suppliesPercentage,
            withSymbol: false,
          ),
          workforceGrossPrice: orderRow.withWorkforce
              ? numberFormatterUtils.formatToCurrency(
                  orderRow.grossPrice * workforcePercentage,
                  withSymbol: false,
                )
              : null,
          workforceTotalGrossExclTax: orderRow.withWorkforce
              ? numberFormatterUtils.formatToCurrency(
                  orderRow.totalGrossExclTax * workforcePercentage,
                  withSymbol: false,
                )
              : null,
          workforceGrossTaxAmount: orderRow.withWorkforce
              ? numberFormatterUtils.formatToCurrency(
                  orderRow.grossTaxAmount * workforcePercentage,
                  withSymbol: false,
                )
              : null,
          workforceTotalGrossInclTax: orderRow.withWorkforce
              ? numberFormatterUtils.formatToCurrency(
                  orderRow.totalGrossInclTax * workforcePercentage,
                  withSymbol: false,
                )
              : null,
        );
      }

      return OrderFormOrderRowsDto(
        code: orderRow.service!.sageId,
        label: orderRow.service!.label,
        designation: orderRow.designation,
        quantity: orderRow.isPackagePrice
            ? '1'
            : numberFormatterUtils
                .formatWithoutTrailingZeros(orderRow.quantity),
        unit: orderRow.priceListItem?.unit ?? orderRow.unit,
        grossPrice: numberFormatterUtils.formatToCurrency(
          orderRow.grossPrice,
          withSymbol: false,
        ),
        totalGrossExclTax: numberFormatterUtils.formatToCurrency(
          orderRow.totalGrossExclTax,
          withSymbol: false,
        ),
        tax: orderRow.formattedTaxLevel,
        grossTaxAmount: numberFormatterUtils.formatToCurrency(
          orderRow.grossTaxAmount,
          withSymbol: false,
        ),
        totalGrossInclTax: numberFormatterUtils.formatToCurrency(
          orderRow.totalGrossInclTax,
          withSymbol: false,
        ),
        options: [orderRow.option1?.label, orderRow.option2?.label]
            .nonNulls
            .join(', '),
        suppliersDto: supplierDto,
      );
    }).toList();
    Map<TaxLevel, OrderFormTaxColumnDto> orderTaxColumns = [
      TaxLevel.RED,
      TaxLevel.RED10,
      TaxLevel.NOR,
    ].fold(
      {},
      (Map<TaxLevel, OrderFormTaxColumnDto> map, TaxLevel taxLevel) {
        final totals = order.getTotalsForTaxLevel(taxLevel);
        map[taxLevel] = OrderFormTaxColumnDto(
            tax: numberFormatterUtils.formatToDouble(taxLevel.value),
            amountExclTax: totals[0] != null ? totals[0]! : '-',
            amountTax: totals[1] != null ? totals[1]! : '-',
            amountInclTax: totals[2] != null ? totals[2]! : '-');
        return map;
      },
    );

    // Payment
    // TODO: remove when paymentTerms will be removed (retrocompatibility)
    final isCashPayment = order.isCashPayment != null
        ? order.isCashPayment!
        : !order.paymentTerms.isFunderStatus;
    final cashPaymentMethod = isCashPayment == true
        ? (order.cashPaymentMethod?.label ?? order.paymentTerms.label)
        : '';
    // TODO: remove when paymentTerms will be removed (retrocompatibility)
    final isFinancingPayment = order.isFinancingPayment != null
        ? order.isFinancingPayment!
        : order.paymentTerms.isFunderStatus;
    final funder = isFinancingPayment == true
        ? (order.financingPaymentMethod?.label ?? order.paymentTerms.label)
        : '';

    // Representative
    // if is order form, consider all selected reps at the finalization step, else, consider only the current rep (the authenticated one)
    UserSetting? setting = await userSettingService.getCurrent();
    List<OrderFormRepresentativeDto> representativesDto = isOrderForm
        ? representatives
            .map((rep) => OrderFormRepresentativeDto(
                  fullName: rep.fullName,
                  phone: rep.formattedPhone.trim(),
                  email: rep.email.trim(),
                  showPhone: setting?.showPhoneInOrderForm ?? false,
                  showEmail: setting?.showEmailInOrderForm ?? false,
                ))
            .toList()
        : [
            OrderFormRepresentativeDto(
              fullName: representative.fullName,
              phone: representative.formattedPhone.trim(),
              email: representative.email.trim(),
              showPhone: setting?.showPhoneInOrderForm ?? false,
              showEmail: setting?.showEmailInOrderForm ?? false,
            )
          ];

    // Others
    pw.MemoryImage logo = pw.MemoryImage(
      (await rootBundle.load(theme.logoWithTextImage)).buffer.asUint8List(),
    );

    String terms = '';
    if (isOrderForm) {
      terms = await order.getTerms(representative);
    } else {
      FileDataServiceInterface fileDataService =
          getIt<FileDataServiceInterface>();
      FileData? fileData =
          await fileDataService.getByUniqueName('Terms_Quote.md');
      if (fileData != null) {
        File? termsFile = await fileDataService
            .getFileFromFileSystem(fileData.uniqueName, withDownload: true);
        if (termsFile != null) {
          terms = await termsFile.readAsString();
        }
      }
    }

    return OrderFormDto(
      // Agency
      agencyLabel: agency.label,
      agencyAddress: agency.address1,
      agencyPostalCode: agency.postalCode,
      agencyCity: agency.city,
      agencyPhone: agency.formattedPhone,
      agencyEmail: agency.email,
      agencySiret: agency.siret,
      agencyNaf: agency.naf,
      // Customer
      customerAddress: customer.addressAddress1,
      customerPostalCode: customer.addressPostalCode,
      customerCity: customer.addressCity,
      customerContacts: customerContacts,
      // Order
      orderHasCustomerSiteDetails:
          order.formattedAddress != customer.formattedAddress,
      orderAddress: order.address1,
      orderPostalCode: order.postalCode,
      orderCity: order.city,
      orderNumber: order.orderFormId,
      orderRows: orderRows,
      orderTotalGrossExclTax: order.formattedTotalGrossExclTax,
      orderTotalGrossInclTax: order.formattedTotalGrossInclTax,
      orderDiscountRows: orderDiscountRows,
      orderTotalNetInclTax: order.formattedTotalNetInclTax,
      orderTaxColumns: orderTaxColumns,
      isCashPayment: isCashPayment,
      cashPaymentMethod: cashPaymentMethod,
      isFinancingPayment: isFinancingPayment,
      funder: funder,
      hasDeposit: order.depositAmount > 0,
      deposit: order.formattedDepositAmount,
      intermediatePayment: order.formattedIntermediatePaymentAmount,
      endOfWorkPayment: order.formattedEndOfWorkPaymentAmount,
      credit: order.formattedCreditAmount,
      monthlyPaymentsCount: order.monthlyPaymentsCount.toString(),
      creditTotalCost: order.formattedCreditTotalCost,
      monthlyPaymentAmount: order.formattedMonthlyPaymentAmount,
      nominalRate: '${order.nominalRate.toStringAsFixed(3)} %',
      apr: '${order.apr.toStringAsFixed(3)} %',
      insuranceType: order.insuranceType.label,
      deferment: order.deferment.label,
      installationDate: order.installAt != null
          ? getIt<DateTimeUtilsInterface>().formatToFrenchDate(order.installAt!)
          : '',
      deadlineDate: order.endProjectAt != null
          ? getIt<DateTimeUtilsInterface>()
              .formatToFrenchDate(order.endProjectAt!)
          : '',
      keepOldStuff: order.keepOldStuff,
      // Representative
      representatives: representativesDto,
      hasFairAccess: representative.hasFairAccess,
      // Fair
      fairCity: fair?.city ?? '',
      // Others
      isOrderForm: isOrderForm,
      terms: terms,
      logo: logo,
    );
  }

  void verify() {
    // Agency
    if (agencyLabel.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_label'.tr());
    }
    if (agencyAddress.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_address'.tr());
    }
    if (agencyPostalCode.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_postal_code'.tr());
    }
    if (agencyCity.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_city'.tr());
    }
    if (agencyPhone.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_phone'.tr());
    }
    if (agencyEmail.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_email'.tr());
    }
    if (agencySiret.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_siret'.tr());
    }
    if (agencyNaf.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.agency_naf'.tr());
    }

    // Customer
    if (customerAddress.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.customer_address'.tr());
    }
    if (customerPostalCode.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.customer_postal_code'
              .tr());
    }
    if (customerCity.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.customer_city'.tr());
    }

    // CustomerContacts
    if (customerContacts.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.customer_contacts'.tr());
    } else {
      customerContacts.map((c) => c.verify());
    }

    // Fair
    if (hasFairAccess == true && fairCity.trim().isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.fair_city'.tr());
    }

    // Order
    if (orderAddress.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_address'.tr());
    }
    if (orderPostalCode.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_postal_code'.tr());
    }
    if (orderCity.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_city'.tr());
    }
    if (orderNumber.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_number'.tr());
    }
    if (orderTotalGrossExclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_total_gross_excl_tax'
              .tr());
    }
    if (orderTotalGrossInclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_total_gross_incl_tax'
              .tr());
    }
    if (orderTotalNetInclTax.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_total_net_incl_tax'
              .tr());
    }
    if (isCashPayment) {
      if (cashPaymentMethod.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.cash_payment_method'
                .tr());
      }
      if (intermediatePayment.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.intermediate_payment'
                .tr());
      }
      if (endOfWorkPayment.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.end_of_work_payment'
                .tr());
      }
    }
    if (isFinancingPayment) {
      if (funder.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.funder'.tr());
      }
      if (credit.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.credit'.tr());
      }
      if (monthlyPaymentsCount.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.monthly_payments_count'
                .tr());
      }
      if (creditTotalCost.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.credit_total_cost'.tr());
      }
      if (monthlyPaymentAmount.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.monthly_payment_amount'
                .tr());
      }
      if (nominalRate.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.nominal_rate'.tr());
      }
      if (apr.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.apr'.tr());
      }
      if (insuranceType.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.insurance_type'.tr());
      }
      if (deferment.isEmpty) {
        throw DtoException(
            'order_form.generate_errors.order_form_dto.deferment'.tr());
      }
    }
    if (installationDate.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.installation_date'.tr());
    }
    if (hasDeposit && deposit.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.deposit'.tr());
    }
    if (deadlineDate.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.deadline_date'.tr());
    }

    // OrderRows
    if (orderRows.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.order_rows'.tr());
    } else {
      orderRows.map((o) => o.verify());
    }

    // OrderDiscountRows
    if (orderDiscountRows.isNotEmpty) {
      orderDiscountRows.map((otc) => otc.verify());
    }

    // Representatives
    if (representatives.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.representatives'.tr());
    } else {
      representatives.map((e) => e.verify());
    }

    // Terms
    if (terms.isEmpty) {
      throw DtoException(
          'order_form.generate_errors.order_form_dto.terms'.tr());
    }
  }
}
