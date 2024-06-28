import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:maple_common/maple_common.dart';
import 'package:pdf/widgets.dart' as pw;

@immutable
class SiteSheetPdfDto {
  // Constructor:---------------------------------------------------------------
  const SiteSheetPdfDto._({
    // Assets
    required this.logo,
    required this.drawingArea,
    // Customer details
    required this.customerId,
    required this.customerName,
    required this.customerAddress,
    required this.customerPostalCodeCity,
    required this.customerContacts,
    // Agency
    required this.agencyId,
    required this.agencyLabel,
    required this.agencyAddress,
    required this.agencyPostalCode,
    required this.agencyCity,
    required this.agencyPhone,
    required this.agencyEmail,
    required this.agencySiret,
    required this.agencyNaf,
    // Order
    required this.orderId,
    required this.orderNumber,
    required this.orderHasCustomerSiteDetails,
    required this.orderAddress,
    required this.orderPostalCodeCity,
    required this.representatives,
    // Site sheet
    required this.siteSheet,
    required this.dateTimeString,
  });

  // Variables:-----------------------------------------------------------------
  // Assets
  final pw.MemoryImage logo;
  final pw.MemoryImage? drawingArea;

  // Customer details
  final String customerId;
  final String customerName;
  final String customerAddress;
  final String customerPostalCodeCity;
  final List<OrderFormContactDto> customerContacts;

  // Agency
  final String agencyId;
  final String agencyLabel;
  final String agencyAddress;
  final String agencyPostalCode;
  final String agencyCity;
  final String agencyPhone;
  final String agencyEmail;
  final String agencySiret;
  final String agencyNaf;

  // Order
  final String orderId;
  final String orderNumber;
  final bool orderHasCustomerSiteDetails;
  final String orderAddress;
  final String orderPostalCodeCity;
  final List<OrderFormRepresentativeDto> representatives;

  // Site sheet
  final SiteSheet siteSheet;
  final String dateTimeString;

  // Factory:-------------------------------------------------------------------
  static Future<SiteSheetPdfDto> create({
    required SiteSheet siteSheet,
    Uint8List? drawing,
  }) async {
    // Dependencies
    final AppThemeDataInterface theme = getIt<AppThemeDataInterface>();
    final AgencyServiceInterface agencyService =
        getIt<AgencyServiceInterface>();
    final UserSettingServiceInterface userSettingService =
        getIt<UserSettingServiceInterface>();
    late final ImageUtilsInterface imageUtils = getIt<ImageUtilsInterface>();

    // Load relationship data
    await siteSheet.loadData(eager: true);

    // Logo
    final logo = pw.MemoryImage(
      (await rootBundle.load(theme.siteSheetLogoImage)).buffer.asUint8List(),
    );

    // Drawing area
    pw.MemoryImage? drawingArea;
    if (drawing != null) {
      final rotatedImageData = imageUtils.rotateImage(drawing);
      drawingArea = pw.MemoryImage(rotatedImageData);
    } else if (siteSheet.drawingFileDataId != null) {
      final file = await siteSheet.drawingFile;
      if (file != null) {
        final imageData = file.readAsBytesSync();
        final rotatedImageData = imageUtils.rotateImage(imageData);
        drawingArea = pw.MemoryImage(rotatedImageData);
        file.deleteSync();
      }
    } else {
      // Switch width and height because the image will be rotated
      final gridImageData = await imageUtils.createGridImage(
        SiteSheet.drawingAreaHeight,
        SiteSheet.drawingAreaWidth,
      );
      drawingArea = pw.MemoryImage(gridImageData);
    }

    // Models
    final agency = await agencyService.getCurrent();
    final order = siteSheet.order!;
    final customer = order.customer!;

    if (agency == null) {
      throw Exception('Agency not found');
    }

    // Order
    final orderNumber = order.orderFormId;
    final orderHasCustomerSiteDetails =
        order.formattedAddress != customer.formattedAddress;
    final orderAddress = order.address;
    final orderPostalCodeCity = '${order.postalCode} ${order.city}';
    final List<OrderFormRepresentativeDto> representatives = [];
    UserSetting? setting = await userSettingService.getCurrent();
    if (order.representative1 != null) {
      representatives.add(OrderFormRepresentativeDto(
        fullName: order.representative1!.fullName,
        phone: order.representative1!.formattedPhone.trim(),
        email: order.representative1!.email.trim(),
        showPhone: setting?.showPhoneInOrderForm ?? false,
        showEmail: setting?.showEmailInOrderForm ?? false,
      ));
    }
    if (order.representative2 != null) {
      representatives.add(OrderFormRepresentativeDto(
        fullName: order.representative2!.fullName,
        phone: order.representative2!.formattedPhone.trim(),
        email: order.representative2!.email.trim(),
        showPhone: setting?.showPhoneInOrderForm ?? false,
        showEmail: setting?.showEmailInOrderForm ?? false,
      ));
    }
    if (order.representative3 != null) {
      representatives.add(OrderFormRepresentativeDto(
        fullName: order.representative3!.fullName,
        phone: order.representative3!.formattedPhone.trim(),
        email: order.representative3!.email.trim(),
        showPhone: setting?.showPhoneInOrderForm ?? false,
        showEmail: setting?.showEmailInOrderForm ?? false,
      ));
    }

    // Customer details
    final customerName = customer.name;
    final customerAddress = customer.address;
    final customerPostalCodeCity =
        '${customer.addressPostalCode} ${customer.addressCity}';
    List<OrderFormContactDto> customerContacts = order.contactsList
        .map((contact) => OrderFormContactDto(
              fullName: contact.fullNameWithCivility,
              phone: contact.formattedPhone.trim(),
              mobilePhone: contact.formattedMobilePhone.trim(),
              email: contact.email,
            ))
        .toList();

    final dateTimeString =
        DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    return SiteSheetPdfDto._(
      // Assets
      logo: logo,
      drawingArea: drawingArea,
      // Customer details
      customerId: customer.id,
      customerName: customerName,
      customerAddress: customerAddress,
      customerPostalCodeCity: customerPostalCodeCity,
      customerContacts: customerContacts,
      // Agency
      agencyId: agency.id,
      agencyLabel: agency.label,
      agencyAddress: agency.address1,
      agencyPostalCode: agency.postalCode,
      agencyCity: agency.city,
      agencyPhone: agency.formattedPhone,
      agencyEmail: agency.email,
      agencySiret: agency.siret,
      agencyNaf: agency.naf,
      // Order
      orderId: order.id,
      orderNumber: orderNumber,
      orderHasCustomerSiteDetails: orderHasCustomerSiteDetails,
      orderAddress: orderAddress,
      orderPostalCodeCity: orderPostalCodeCity,
      representatives: representatives,
      // Site sheet
      siteSheet: siteSheet,
      dateTimeString: dateTimeString,
    );
  }
}
