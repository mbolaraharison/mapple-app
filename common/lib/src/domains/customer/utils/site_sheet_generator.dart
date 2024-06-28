import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:maple_common/src/data/dto/site_sheet_pdf_dto.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SiteSheetGeneratorInterface {
  Future<void> generate({
    required SiteSheet siteSheet,
    bool openFile = true,
    bool withSave = false,
    Uint8List? drawing,
  });
}

// Implementation:--------------------------------------------------------------
class SiteSheetGenerator
    with PrivateDirectoryMixin
    implements SiteSheetGeneratorInterface {
  // Static:--------------------------------------------------------------------
  static const double _defaultFontSize = 10;
  static const double _defaultSpaceBetweenLines = 8;

  // Variables:-----------------------------------------------------------------
  late final PdfColor _primaryColor =
      PdfColor.fromInt(_theme.siteSheetPrimaryColor.value);

  late final PdfColor _secondaryColor =
      PdfColor.fromInt(_theme.siteSheetSecondaryColor.value);

  // Dependencies:--------------------------------------------------------------
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final AppThemeDataInterface _theme = getIt<AppThemeDataInterface>();
  late final SiteSheetServiceInterface _siteSheetService =
      getIt<SiteSheetServiceInterface>();
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<void> generate({
    required SiteSheet siteSheet,
    bool openFile = true,
    bool withSave = false,
    Uint8List? drawing,
  }) async {
    final dto =
        await SiteSheetPdfDto.create(siteSheet: siteSheet, drawing: drawing);

    late final String uniqueName;
    late final File file;

    // If withSave -> increment version
    if (withSave == true) {
      final version = await _siteSheetService.getNextVersion(siteSheet);
      uniqueName = 'site_sheet.filename_version'.tr(namedArgs: {
        'orderFormId': dto.orderNumber,
        'version': version.toString(),
      });
      file = await _fileUtils.save(
        path: await _fileUtils.getUploadPath(
          agencyName: dto.agencyLabel,
          customerName: dto.customerName,
          fileName: uniqueName,
        ),
      );
    } else {
      uniqueName = 'site_sheet.filename_preview'.tr(namedArgs: {
        'orderFormId': dto.orderNumber,
      });
      Directory directory = await privateDirectory;
      file = File('${directory.path}/$uniqueName');
    }

    final doc = Document();

    doc.addPage(
      MultiPage(
        maxPages: 40,
        pageTheme: _buildTheme(
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoRegular)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoBold)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoItalic)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.cupertinoIcons)),
        ),
        footer: (context) => _buildFooter(context: context, dto: dto),
        build: (context) => _buildContent(dto: dto),
      ),
    );

    // save the file
    await file.writeAsBytes(await doc.save(), flush: true);

    // If withSave -> create file data, open it and upload it
    if (withSave == true) {
      final fileData = FileData(
        id: _uuidUtils.generate(),
        uniqueName: uniqueName,
        displayName: uniqueName,
        agencyId: dto.agencyId,
        customerId: dto.customerId,
        orderId: dto.orderId,
      );
      await _fileDataService.create(fileData);
      await _fileDataService.openFromFileSystemByUniqueName(
        uniqueName,
        file: file,
        download: false,
        withRemove: false,
      );
      _fileDataService.tryUpload(file);

      return;
    }

    // If not withSave -> open file and remove it
    if (openFile) {
      await _fileDataService.openFromFileSystemByUniqueName(
        uniqueName,
        download: false,
        withRemove: true,
      );
    }
  }

  // PDF methods:---------------------------------------------------------------
  PageTheme _buildTheme(
    Font base,
    Font bold,
    Font italic,
    Font icons,
  ) {
    return PageTheme(
      pageFormat: PdfPageFormat.a4,
      theme: ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
        icons: icons,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    );
  }

  Widget _buildFooter({
    required SiteSheetPdfDto dto,
    required Context context,
  }) {
    return Column(
      children: [
        SizedBox(height: _defaultSpaceBetweenLines + 6),
        Container(height: .5, color: PdfColors.black),
        SizedBox(height: _defaultSpaceBetweenLines),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dto.dateTimeString,
              style: const TextStyle(fontSize: 8),
            ),
            Text(
              '${context.pageNumber} / ${context.document.pdfPageList.pages.length}',
              style: const TextStyle(fontSize: 8),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildContent({required SiteSheetPdfDto dto}) {
    return [
      _buildHeader(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines),
      _buildSiteSheetBanner(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines - 4),
      _buildRowDetails(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildSitePreparationBanner(),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildInformationsFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildRoofFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildCoverFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildExposureFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildGutterFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildFasciaBoardFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildFacadeFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildWoodTreatmentFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildInsulationFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildConnectionFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildCommentsFields(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildHousePlan(dto: dto),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildSiteRiskContent(),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildCollectiveProtectionContent(),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildIndividualProtectionContent(),
      SizedBox(height: _defaultSpaceBetweenLines + 10),
      _buildSiteSecurityFooter(),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildConditionReportContent(),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildSiteTraceabilityContent(),
      SizedBox(height: _defaultSpaceBetweenLines + 6),
      _buildCertificateContent(),
    ];
  }

  Widget _buildHeader({required SiteSheetPdfDto dto}) {
    return Row(children: [
      Expanded(
        flex: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Image(dto.logo),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: 1,
          height: 85,
          color: PdfColors.black,
        ),
      ),
      Expanded(
        flex: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dto.agencyLabel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(dto.agencyAddress, style: const TextStyle(fontSize: 9)),
            SizedBox(height: 10),
            Text(
              '${dto.agencyPostalCode} ${dto.agencyCity}',
              style: const TextStyle(fontSize: 9),
            ),
            Text(
              'order_form.phone_with_label'
                  .tr(namedArgs: {'phone': dto.agencyPhone}),
              style: const TextStyle(fontSize: 9),
            ),
            Text(
              'order_form.mail_with_label'
                  .tr(namedArgs: {'mail': dto.agencyEmail}),
              style: const TextStyle(fontSize: 9),
            ),
            Text(
              'order_form.agency_siret'
                  .tr(namedArgs: {'siret': dto.agencySiret}),
              style: const TextStyle(fontSize: 9),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildSiteSheetBanner({required SiteSheetPdfDto dto}) {
    return getIt<PdfBannerWidgetInterface>(
      param1: PdfBannerProps(
        backgroundColor: _primaryColor,
        content: 'site_sheet.pdf.site_sheet_banner'.tr(
          namedArgs: {'number': dto.orderNumber},
        ).toUpperCase(),
      ),
    );
  }

  Widget _buildRowDetails({required SiteSheetPdfDto dto}) {
    return Table(
      defaultColumnWidth: const FlexColumnWidth(1),
      defaultVerticalAlignment: TableCellVerticalAlignment.full,
      children: [
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 3),
              child: Center(
                child: Text(
                  'site_sheet.pdf.customer_details'.tr(),
                  style: TextStyle(
                    fontSize: 7,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: Center(
                child: Text(
                  'site_sheet.pdf.customer_site_details'.tr(),
                  style: TextStyle(
                    fontSize: 7,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 3),
              child: Center(
                child: Text(
                  'site_sheet.pdf.seller_details'.tr(),
                  style: TextStyle(
                    fontSize: 7,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 3),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: _buildCustomerDetails(dto: dto),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: _buildCustomerSiteDetails(dto: dto),
            ),
            Container(
              margin: const EdgeInsets.only(left: 3),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: _buildSellersDetails(dto: dto),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerDetails({required SiteSheetPdfDto dto}) {
    final List<Widget> children = [];

    for (var contact in dto.customerContacts) {
      children.addAll([
        Text(
          contact.fullName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _defaultFontSize,
          ),
        ),
        if (contact.phone.isNotEmpty)
          Text(
            'order_form.phone_with_label'
                .tr(namedArgs: {'phone': contact.phone}),
            style: const TextStyle(fontSize: _defaultFontSize),
          ),
        if (contact.mobilePhone.isNotEmpty)
          Text(
            'order_form.mobile_phone_with_label'
                .tr(namedArgs: {'mobilePhone': contact.mobilePhone}),
            style: const TextStyle(fontSize: _defaultFontSize),
          ),
        Text(
          'order_form.mail_with_label'.tr(namedArgs: {'mail': contact.email}),
          style: const TextStyle(fontSize: _defaultFontSize),
        ),
        SizedBox(height: 3),
      ]);
    }

    children.addAll([
      Text(
        dto.customerAddress,
        style: const TextStyle(fontSize: _defaultFontSize),
      ),
      Text(
        dto.customerPostalCodeCity,
        style: const TextStyle(fontSize: _defaultFontSize),
      ),
    ]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildCustomerSiteDetails({required SiteSheetPdfDto dto}) {
    if (dto.orderHasCustomerSiteDetails == false) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dto.orderAddress,
          style: const TextStyle(fontSize: _defaultFontSize),
        ),
        Text(
          dto.orderPostalCodeCity,
          style: const TextStyle(fontSize: _defaultFontSize),
        ),
      ],
    );
  }

  Widget _buildSellersDetails({required SiteSheetPdfDto dto}) {
    List<Widget> children = [];

    for (var rep in dto.representatives) {
      children.add(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            rep.fullName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _defaultFontSize,
            ),
          ),
          if (rep.showPhone)
            rep.phone != ''
                ? Text(
                    'order_form.phone_with_label'
                        .tr(namedArgs: {'phone': rep.phone}),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  )
                : Container(),
          if (rep.showEmail)
            rep.email != ''
                ? Text(
                    'order_form.mail_with_label'
                        .tr(namedArgs: {'mail': rep.email}),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  )
                : Container(),
        ]),
      );
      children.add(SizedBox(height: 4));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildSitePreparationBanner() {
    return getIt<PdfBannerWidgetInterface>(
      param1: PdfBannerProps(
        backgroundColor: _primaryColor,
        content: 'site_sheet.pdf.site_preparation'.tr().toUpperCase(),
      ),
    );
  }

  Widget _buildInformationsFields({required SiteSheetPdfDto dto}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getIt<PdfBannerWidgetInterface>(
                param1: PdfBannerProps(
                  backgroundColor: _secondaryColor,
                  verticalPadding: 2,
                  fontSize: _defaultFontSize,
                  content: 'site_sheet.pdf.statement_of_information'
                      .tr()
                      .toUpperCase(),
                ),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: HouseType.values
                    .map(
                      (e) => getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: e.label,
                          labelSize: _defaultFontSize,
                          isChecked: dto.siteSheet.houseTypes.contains(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoofFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.roof'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Text(
                    'site_sheet.content.roof.category.roof'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PdfColors.black, width: .5),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.pdf.number_of_sections'.tr(),
                          value: dto.siteSheet.numberOfSections,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.has_return_in_l'.tr(),
                          labelSize: _defaultFontSize,
                          isChecked: dto.siteSheet.hasReturnInL,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.content.roof.total_roof_area'.tr(),
                          value: dto.siteSheet.totalRoofArea,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.content.roof.age_of_roof'.tr(),
                          value: dto.siteSheet.ageOfRoof,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label: 'site_sheet.content.roof.state_of_roof'.tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 90,
                          valuesWidth: 70,
                          values: StateOfRoof.values
                              .map(
                                (e) => PdfSelectValue(
                                  value: e.label,
                                  isChecked: dto.siteSheet.stateOfRoof == e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label: 'site_sheet.content.roof.vegetation'.tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 90,
                          valuesWidth: 70,
                          values: Vegetation.values
                              .map(
                                (e) => PdfSelectValue(
                                  value: e.label,
                                  isChecked: dto.siteSheet.vegetation == e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label: 'site_sheet.content.roof.roof_pitch'.tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 90,
                          valuesWidth: 70,
                          values: RoofPitch.values
                              .map(
                                (e) => PdfSelectValue(
                                  value: e.label,
                                  isChecked: dto.siteSheet.roofPitch == e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label:
                              'site_sheet.content.roof.checking_recovery'.tr(),
                          value: dto.siteSheet.checkingRecovery,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'site_sheet.content.roof.category.gutter'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PdfColors.black, width: .5),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.content.roof.existing_gutter'.tr(),
                          value: dto.siteSheet.existingGutter,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label:
                              'site_sheet.content.roof.existing_gutters_colors'
                                  .tr(),
                          value: dto.siteSheet.existingGuttersColors,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.pdf.gable_height'.tr(),
                          value: dto.siteSheet.gableHeight,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.pdf.height_under_gutter'.tr(),
                          value: dto.siteSheet.heightUnderGutter,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'site_sheet.content.roof.category.roofing_elements'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PdfColors.black, width: .5),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label: 'site_sheet.content.roof.got_veranda'.tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 105,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked: dto.siteSheet.gotVeranda == true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked: dto.siteSheet.gotVeranda == false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label:
                              'site_sheet.content.roof.got_photovoltaic'.tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 105,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked: dto.siteSheet.gotPhotovoltaic == true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked: dto.siteSheet.gotPhotovoltaic == false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label:
                              'site_sheet.content.roof.number_of_chimneys'.tr(),
                          value: dto.siteSheet.numberOfChimneys,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label:
                              'site_sheet.content.roof.need_to_paint_chimneys'
                                  .tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 105,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked:
                                  dto.siteSheet.needToPaintChimneys == true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked:
                                  dto.siteSheet.needToPaintChimneys == false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label:
                              'site_sheet.content.roof.chimneys_to_paint_color'
                                  .tr(),
                          value: dto.siteSheet.chimneysToPaintColor,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label:
                              'site_sheet.content.roof.number_of_dormers'.tr(),
                          value: dto.siteSheet.numberOfDormers,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.content.roof.number_of_velux'.tr(),
                          value: dto.siteSheet.numberOfVelux,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.content.roof.type_of_ridge'.tr(),
                          value: dto.siteSheet.typeOfRidge,
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label: 'site_sheet.content.roof.state_of_ridge'.tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 105,
                          valuesWidth: 55,
                          values: StateOfRidge.values
                              .map(
                                (e) => PdfSelectValue(
                                  value: e.label,
                                  isChecked: dto.siteSheet.stateOfRidge == e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label: 'site_sheet.content.roof.need_for_cement_work'
                              .tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 105,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked:
                                  dto.siteSheet.needForCementWork == true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked:
                                  dto.siteSheet.needForCementWork == false,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'site_sheet.content.roof.category.water_repellent'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PdfColors.black, width: .5),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label:
                              'site_sheet.content.roof.velux_to_be_waterproofed'
                                  .tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 110,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked:
                                  dto.siteSheet.veluxToBeWaterproofed == true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked:
                                  dto.siteSheet.veluxToBeWaterproofed == false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label:
                              'site_sheet.content.roof.ridge_to_be_waterproofed'
                                  .tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 110,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked:
                                  dto.siteSheet.rigdeToBeWaterproofed == true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked:
                                  dto.siteSheet.rigdeToBeWaterproofed == false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label:
                              'site_sheet.content.roof.cladding_to_be_waterproofed'
                                  .tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 110,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked:
                                  dto.siteSheet.claddingToBeWaterproofed ==
                                      true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked:
                                  dto.siteSheet.claddingToBeWaterproofed ==
                                      false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfSelectWidgetInterface>(
                        param1: PdfSelectProps(
                          label:
                              'site_sheet.content.roof.edges_to_be_waterproofed'
                                  .tr(),
                          valuesSize: _defaultFontSize,
                          labelWidth: 110,
                          valuesWidth: 55,
                          values: [
                            PdfSelectValue(
                              value: 'yes'.tr(),
                              isChecked:
                                  dto.siteSheet.edgesToBeWaterproofed == true,
                            ),
                            PdfSelectValue(
                              value: 'no'.tr(),
                              isChecked:
                                  dto.siteSheet.edgesToBeWaterproofed == false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _defaultSpaceBetweenLines),
                      getIt<PdfTextFieldWidgetInterface>(
                        param1: PdfTextFieldProps(
                          label: 'site_sheet.content.roof.water_repellent_color'
                              .tr(),
                          value: dto.siteSheet.waterRepellentColor,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoverFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.cover'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfTextFieldWidgetInterface>(
                    param1: PdfTextFieldProps(
                      label:
                          'site_sheet.content.cover.models_and_dimensions'.tr(),
                      value: dto.siteSheet.modelsAndDimensions,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.cover.types'.tr(),
            valuesSize: _defaultFontSize,
            valuesWidth: 180,
            values: CoverType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.coverTypes.contains(e),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label:
                'site_sheet.content.cover.number_of_slates_or_tiles_in_advance'
                    .tr(),
            value: dto.siteSheet.numberOfSlatesOrTilesInAdvance,
          ),
        ),
      ],
    );
  }

  Widget _buildExposureFields({required SiteSheetPdfDto dto}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              getIt<PdfBannerWidgetInterface>(
                param1: PdfBannerProps(
                  backgroundColor: _secondaryColor,
                  verticalPadding: 2,
                  fontSize: _defaultFontSize,
                  content: 'site_sheet.pdf.exposure'.tr().toUpperCase(),
                ),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: Exposure.values
                    .map(
                      (e) => getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: e.label,
                          labelSize: _defaultFontSize,
                          isChecked: dto.siteSheet.exposures.contains(e),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGutterFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.gutter'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfSelectWidgetInterface>(
                    param1: PdfSelectProps(
                      label: 'site_sheet.content.gutters.gutter_types'.tr(),
                      valuesSize: _defaultFontSize,
                      values: GutterType.values
                          .map(
                            (e) => PdfSelectValue(
                              value: e.label,
                              isChecked: dto.siteSheet.gutterTypes.contains(e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.other_material'.tr(),
            value: dto.siteSheet.otherMaterial,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.length_in_linear_meters'.tr(),
            value: dto.siteSheet.lengthInLinearMeters,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.downspout_length'.tr(),
            value: dto.siteSheet.downspoutLength,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.gutters_color'.tr(),
            value: dto.siteSheet.guttersColor,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.downspouts_color'.tr(),
            value: dto.siteSheet.downspoutsColor,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.gutters.downspout_type'.tr(),
            valuesSize: _defaultFontSize,
            valuesWidth: 80,
            values: DownspoutType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.downspoutType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.left_angle_quantity'.tr(),
            value: dto.siteSheet.leftAngleQuantity,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.right_angle_quantity'.tr(),
            value: dto.siteSheet.rightAngleQuantity,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.number_of_gutter_bottoms'.tr(),
            value: dto.siteSheet.numberOfGutterBottoms,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.number_of_gutter_births'.tr(),
            value: dto.siteSheet.numberOfGutterBirths,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.gutters.number_of_gutter_bends'.tr(),
            value: dto.siteSheet.numberOfGutterBends,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label:
                'site_sheet.content.gutters.number_of_gutter_sleeves_or_dolphin'
                    .tr(),
            value: dto.siteSheet.numberOfGutterSleevesOrDolphin,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.gutters.with_water_recuperator'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 90,
            valuesWidth: 55,
            values: [
              PdfSelectValue(
                value: 'yes'.tr(),
                isChecked: dto.siteSheet.withWaterRecuperator == true,
              ),
              PdfSelectValue(
                value: 'no'.tr(),
                isChecked: dto.siteSheet.withWaterRecuperator == false,
              ),
            ],
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.gutters.with_leaf_guard'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 90,
            valuesWidth: 55,
            values: [
              PdfSelectValue(
                value: 'yes'.tr(),
                isChecked: dto.siteSheet.withLeafGuard == true,
              ),
              PdfSelectValue(
                value: 'no'.tr(),
                isChecked: dto.siteSheet.withLeafGuard == false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFasciaBoardFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.fascia_board'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfTextFieldWidgetInterface>(
                    param1: PdfTextFieldProps(
                      label:
                          'site_sheet.content.fascia_board.fascia_board_length'
                              .tr(),
                      value: dto.siteSheet.fasciaBoardLength,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.fascia_board.fascia_board_advance_in_cm'
                .tr(),
            value: dto.siteSheet.fasciaBoardAdvanceInCm,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.fascia_board.fascia_board_color'.tr(),
            value: dto.siteSheet.fasciaBoardColor,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.fascia_board.fascia_board_return'.tr(),
            value: dto.siteSheet.fasciaBoardReturn,
          ),
        ),
      ],
    );
  }

  Widget _buildFacadeFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.facade'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfTextFieldWidgetInterface>(
                    param1: PdfTextFieldProps(
                      label: 'site_sheet.content.facade.facade_area'.tr(),
                      value: dto.siteSheet.facadeArea,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.facade_age'.tr(),
            value: dto.siteSheet.facadeAge,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.type_of_existing_support'.tr(),
            value: dto.siteSheet.typeOfExistingSupport,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label:
                'site_sheet.content.facade.facade_existing_support_types'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 80,
            valuesWidth: 75,
            values: FacadeExistingSupportType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked:
                        dto.siteSheet.facadeExistingSupportTypes.contains(e),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.facade.facade_pointings'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 80,
            valuesWidth: 75,
            values: FacadePointing.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.facadePointings.contains(e),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfCheckboxWidgetInterface>(
          param1: PdfCheckboxProps(
            label: 'site_sheet.content.facade.is_damp_support'.tr(),
            labelSize: _defaultFontSize,
            isChecked: dto.siteSheet.isDampSupport,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.facade.is_blown_coating'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 80,
            valuesWidth: 75,
            values: [
              PdfSelectValue(
                value: 'yes'.tr(),
                isChecked: dto.siteSheet.isBlownCoating == true,
              ),
              PdfSelectValue(
                value: 'no'.tr(),
                isChecked: dto.siteSheet.isBlownCoating == false,
              ),
            ],
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.facade.facade_type_of_work'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 80,
            valuesWidth: 75,
            values: FacadeTypeOfWork.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.facadeTypeOfWork == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.facade.water_repellent_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 80,
            valuesWidth: 75,
            values: WaterRepellentType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.waterRepellentType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.number_of_windows'.tr(),
            value: dto.siteSheet.numberOfWindows,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.cracks'.tr(),
            value: dto.siteSheet.cracks,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.micro_cracks'.tr(),
            value: dto.siteSheet.microCracks,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.facade_color'.tr(),
            value: dto.siteSheet.facadeColor,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.base_color'.tr(),
            value: dto.siteSheet.baseColor,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.facade.window_surrounding_color'.tr(),
            value: dto.siteSheet.windowSurroundingColor,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label:
                'site_sheet.content.facade.external_ventilation_grilles'.tr(),
            value: dto.siteSheet.externalVentilationGrilles,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.facade.surrounding_windows_types'.tr(),
            valuesSize: _defaultFontSize,
            valuesWidth: 75,
            values: SurroundingWindowsType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked:
                        dto.siteSheet.surroundingWindowsTypes.contains(e),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWoodTreatmentFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content:
                          'site_sheet.pdf.wood_treatment'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfSelectWidgetInterface>(
                    param1: PdfSelectProps(
                      label:
                          'site_sheet.content.wood_treatment.wood_treatment_type'
                              .tr(),
                      valuesSize: _defaultFontSize,
                      valuesWidth: 75,
                      values: WoodTreatmentType.values
                          .map(
                            (e) => PdfSelectValue(
                              value: e.label,
                              isChecked: dto.siteSheet.woodTreatmentType == e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.wood_treatment.wood_treatment_area'.tr(),
            value: dto.siteSheet.woodTreatmentArea,
          ),
        ),
      ],
    );
  }

  Widget _buildInsulationFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.insulation'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfSelectWidgetInterface>(
                    param1: PdfSelectProps(
                      label:
                          'site_sheet.content.insulation.insulation_access_type'
                              .tr(),
                      valuesSize: _defaultFontSize,
                      labelWidth: 75,
                      valuesWidth: 75,
                      values: InsulationAccessType.values
                          .map(
                            (e) => PdfSelectValue(
                              value: e.label,
                              isChecked:
                                  dto.siteSheet.insulationAccessType == e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.insulation.insulators'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 75,
            valuesWidth: 120,
            values: Insulator.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.insulators.contains(e),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.insulation.insulation_area'.tr(),
            value: dto.siteSheet.insulationArea,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.insulation.mineral_wool_type'.tr(),
            value: dto.siteSheet.mineralWoolType,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label:
                'site_sheet.content.insulation.insulation_type_of_installation'
                    .tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 125,
            valuesWidth: 85,
            values: InsulationTypeOfInstallation.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.insulationTypeOfInstallation == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label:
                'site_sheet.content.insulation.existing_insulation_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 125,
            valuesWidth: 85,
            values: ExistingInsulationType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.existingInsulationType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.insulation.existing_insulation_age'.tr(),
            value: dto.siteSheet.existingInsulationAge,
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label:
                'site_sheet.content.insulation.removal_of_existing_insulation'
                    .tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 165,
            valuesWidth: 70,
            values: [
              PdfSelectValue(
                value: 'yes'.tr(),
                isChecked: dto.siteSheet.removalOfExistingInsulation == true,
              ),
              PdfSelectValue(
                value: 'no'.tr(),
                isChecked: dto.siteSheet.removalOfExistingInsulation == false,
              ),
            ],
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.insulation.attic_floor_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 165,
            valuesWidth: 70,
            values: AtticFloorType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.atticFloorType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.insulation.roof_structure_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 95,
            valuesWidth: 75,
            values: RoofStructureType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.roofStructureType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.insulation.ventilation_system'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 95,
            valuesWidth: 75,
            values: [
              PdfSelectValue(
                value: 'yes'.tr(),
                isChecked: dto.siteSheet.ventilationSystem == true,
              ),
              PdfSelectValue(
                value: 'no'.tr(),
                isChecked: dto.siteSheet.ventilationSystem == false,
              ),
            ],
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.insulation.ventilation_system_age'.tr(),
            value: dto.siteSheet.ventilationSystemAge,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.connection'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfSelectWidgetInterface>(
                    param1: PdfSelectProps(
                      label: 'site_sheet.content.connection.water_recuperator'
                          .tr(),
                      valuesSize: _defaultFontSize,
                      labelWidth: 100,
                      valuesWidth: 75,
                      values: [
                        PdfSelectValue(
                          value: 'yes'.tr(),
                          isChecked: dto.siteSheet.waterRecuperator == true,
                        ),
                        PdfSelectValue(
                          value: 'no'.tr(),
                          isChecked: dto.siteSheet.waterRecuperator == false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.connection.water_supply_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 100,
            valuesWidth: 75,
            values: WaterSupplyType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.waterSupplyType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label:
                'site_sheet.content.connection.water_supply_outdoor_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 100,
            valuesWidth: 75,
            values: WaterSupplyOutdoorType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.waterSupplyOutdoorType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.connection.water_pression_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 100,
            valuesWidth: 75,
            values: WaterPressionType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.waterPressionType == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.connection.electricity_type'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 100,
            valuesWidth: 75,
            values: ElectricityType.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.electricityType == e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsFields({required SiteSheetPdfDto dto}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.comments'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  getIt<PdfTextFieldWidgetInterface>(
                    param1: PdfTextFieldProps(
                      label:
                          'site_sheet.content.other.periods_of_unavailability'
                              .tr(),
                      value: dto.siteSheet.periodsOfUnavailability,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.other.heating_system'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 95,
            valuesWidth: 165,
            values: HeatingSystem.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.heatingSystem == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfSelectWidgetInterface>(
          param1: PdfSelectProps(
            label: 'site_sheet.content.other.zone'.tr(),
            valuesSize: _defaultFontSize,
            labelWidth: 95,
            valuesWidth: 75,
            values: Zone.values
                .map(
                  (e) => PdfSelectValue(
                    value: e.label,
                    isChecked: dto.siteSheet.zone == e,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        getIt<PdfTextFieldWidgetInterface>(
          param1: PdfTextFieldProps(
            label: 'site_sheet.content.other.others_observations'.tr(),
            value: dto.siteSheet.othersObservations,
          ),
        ),
      ],
    );
  }

  Widget _buildHousePlan({required SiteSheetPdfDto dto}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getIt<PdfBannerWidgetInterface>(
                param1: PdfBannerProps(
                  backgroundColor: _primaryColor,
                  content: 'site_sheet.pdf.house_plan'.tr().toUpperCase(),
                ),
              ),
              SizedBox(height: _defaultSpaceBetweenLines + 6),
              Container(
                width: double.infinity,
                height: 705,
                decoration: BoxDecoration(
                  border: Border.all(width: .5),
                ),
                child: dto.drawingArea != null
                    ? Image(
                        dto.drawingArea!,
                        fit: BoxFit.contain,
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSiteRiskContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _primaryColor,
                      content: 'site_sheet.pdf.site_safety'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: 14),
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.risks.banner'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PdfColors.black, width: .5),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'site_sheet.pdf.risks.first_group_question'.tr(),
                            style: const TextStyle(fontSize: _defaultFontSize),
                          ),
                        ),
                        SizedBox(height: _defaultSpaceBetweenLines),
                        RichText(
                          text: TextSpan(
                            text: '- ${'yes'.tr()} : ',
                            style: const TextStyle(fontSize: _defaultFontSize),
                            children: [
                              TextSpan(
                                text: 'site_sheet.pdf.scaffolding'.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: _defaultSpaceBetweenLines),
                        Text(
                          '- ${'no'.tr()} : ${'site_sheet.pdf.risks.last_question'.tr()}',
                          style: const TextStyle(fontSize: _defaultFontSize),
                        ),
                        SizedBox(height: _defaultSpaceBetweenLines),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: RichText(
                            text: TextSpan(
                              text: '- ${'yes'.tr()} : ',
                              style:
                                  const TextStyle(fontSize: _defaultFontSize),
                              children: [
                                TextSpan(
                                  text:
                                      'site_sheet.pdf.risks.last_question_second_answer'
                                          .tr(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: _defaultSpaceBetweenLines),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: RichText(
                            text: TextSpan(
                              text: '- ${'no'.tr()} : ',
                              style:
                                  const TextStyle(fontSize: _defaultFontSize),
                              children: [
                                TextSpan(
                                  text:
                                      'site_sheet.pdf.risks.last_question_first_answer'
                                          .tr(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: PdfColors.black, width: .5),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'site_sheet.pdf.risks.second_group_questions.first'.tr(),
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              Center(
                child: Text(
                  'and'.tr(),
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              Center(
                child: Text(
                  'site_sheet.pdf.risks.second_group_questions.second'.tr(),
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              Center(
                child: Text(
                  'and'.tr(),
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              Center(
                child: Text(
                  'site_sheet.pdf.risks.second_group_questions.third'.tr(),
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              Center(
                child: Text(
                  'and'.tr(),
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              Center(
                child: Text(
                  'site_sheet.pdf.risks.second_group_questions.fourth'.tr(),
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              RichText(
                text: TextSpan(
                  text: '- ${'yes'.tr()} : ',
                  style: const TextStyle(fontSize: _defaultFontSize),
                  children: [
                    TextSpan(
                      text: 'site_sheet.pdf.nacelle'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Text(
                '- ${'no'.tr()} : ${'site_sheet.pdf.risks.last_question'.tr()}',
                style: const TextStyle(fontSize: _defaultFontSize),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: RichText(
                  text: TextSpan(
                    text: '- ${'yes'.tr()} : ',
                    style: const TextStyle(fontSize: _defaultFontSize),
                    children: [
                      TextSpan(
                        text: 'site_sheet.pdf.risks.last_question_second_answer'
                            .tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: RichText(
                  text: TextSpan(
                    text: '- ${'no'.tr()} : ',
                    style: const TextStyle(fontSize: _defaultFontSize),
                    children: [
                      TextSpan(
                        text: 'site_sheet.pdf.risks.last_question_first_answer'
                            .tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollectiveProtectionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.collective_protection'
                          .tr()
                          .toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '- ${'site_sheet.pdf.scaffolding'.tr()}',
                              style: TextStyle(
                                fontSize: _defaultFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: _defaultSpaceBetweenLines),
                            getIt<PdfCheckboxWidgetInterface>(
                              param1: PdfCheckboxProps(
                                label: 'site_sheet.pdf.internal'.tr(),
                                isChecked: false,
                                labelSize: _defaultFontSize,
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Row(
                                children: [
                                  Text(
                                    '${'site_sheet.pdf.scaffolding_name'.tr()} : ',
                                    style: const TextStyle(
                                        fontSize: _defaultFontSize),
                                  ),
                                  Expanded(
                                    child:
                                        getIt<PdfDottedLineWidgetInterface>(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: _defaultSpaceBetweenLines),
                            getIt<PdfCheckboxWidgetInterface>(
                              param1: PdfCheckboxProps(
                                label: 'site_sheet.pdf.outsource'.tr(),
                                isChecked: false,
                                labelSize: _defaultFontSize,
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Row(
                                children: [
                                  Text(
                                    '${'site_sheet.pdf.company'.tr()} : ',
                                    style: const TextStyle(
                                        fontSize: _defaultFontSize),
                                  ),
                                  Expanded(
                                    child:
                                        getIt<PdfDottedLineWidgetInterface>(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Row(
                                children: [
                                  Text(
                                    '${'site_sheet.pdf.phone'.tr()} : ',
                                    style: const TextStyle(
                                        fontSize: _defaultFontSize),
                                  ),
                                  Expanded(
                                    child:
                                        getIt<PdfDottedLineWidgetInterface>(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Row(
                                children: [
                                  Text(
                                    '${'site_sheet.pdf.scaffolding_name'.tr()} : ',
                                    style: const TextStyle(
                                        fontSize: _defaultFontSize),
                                  ),
                                  Expanded(
                                    child:
                                        getIt<PdfDottedLineWidgetInterface>(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- ${'site_sheet.pdf.nacelle'.tr()}',
                    style: TextStyle(
                      fontSize: _defaultFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      children: [
                        Text(
                          '${'site_sheet.pdf.renter'.tr()} : ',
                          style: const TextStyle(fontSize: _defaultFontSize),
                        ),
                        Expanded(
                          child: getIt<PdfDottedLineWidgetInterface>(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      children: [
                        Text(
                          '${'site_sheet.pdf.driver'.tr()} : ',
                          style: const TextStyle(fontSize: _defaultFontSize),
                        ),
                        Expanded(
                          child: getIt<PdfDottedLineWidgetInterface>(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'site_sheet.pdf.check_authorizations'.tr(),
                    style: const TextStyle(
                      fontSize: 8,
                      color: PdfColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ],
    );
  }

  Widget _buildIndividualProtectionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content: 'site_sheet.pdf.individual_protection'
                          .tr()
                          .toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Row(
                    children: [
                      Text(
                        '- ${'site_sheet.pdf.house_scheme'.tr()}',
                        style: const TextStyle(fontSize: _defaultFontSize),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'site_sheet.pdf.house_scheme_description_1'.tr(),
                            style: const TextStyle(
                              fontSize: 8,
                              color: PdfColors.grey,
                            ),
                          ),
                          Text(
                            'site_sheet.pdf.house_scheme_description_2'.tr(),
                            style: const TextStyle(
                              fontSize: 8,
                              color: PdfColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      border: Border.all(color: PdfColors.black, width: .5),
                    ),
                    padding: const EdgeInsets.only(
                      left: 4,
                      top: 4,
                    ),
                    child: Text(
                      'site_sheet.pdf.drawing_area'.tr(),
                      style: const TextStyle(
                        fontSize: 8,
                        color: PdfColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        Row(
          children: [
            Text(
              '- ${'site_sheet.pdf.presence_of_sheathing'.tr()} : ',
              style: const TextStyle(fontSize: _defaultFontSize),
            ),
            SizedBox(width: 20),
            getIt<PdfCheckboxWidgetInterface>(
              param1: PdfCheckboxProps(
                label: 'no'.tr(),
                isChecked: false,
                labelSize: _defaultFontSize,
              ),
            ),
            SizedBox(width: 20),
            getIt<PdfCheckboxWidgetInterface>(
              param1: PdfCheckboxProps(
                label: 'yes'.tr(),
                isChecked: false,
                labelSize: _defaultFontSize,
              ),
            ),
            SizedBox(width: 2),
            Text(
              'site_sheet.pdf.presence_of_sheathing_yes_description'.tr(),
              style: const TextStyle(
                fontSize: 8,
                color: PdfColors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        Row(
          children: [
            Text(
              '- ${'site_sheet.pdf.presence_of_asbestos'.tr()} : ',
              style: const TextStyle(fontSize: _defaultFontSize),
            ),
            SizedBox(width: 20),
            getIt<PdfCheckboxWidgetInterface>(
              param1: PdfCheckboxProps(
                label: 'no'.tr(),
                isChecked: false,
                labelSize: _defaultFontSize,
              ),
            ),
            SizedBox(width: 20),
            getIt<PdfCheckboxWidgetInterface>(
              param1: PdfCheckboxProps(
                label: 'yes'.tr(),
                isChecked: false,
                labelSize: _defaultFontSize,
              ),
            ),
            SizedBox(width: 2),
            Text(
              'site_sheet.pdf.presence_of_asbestos_yes_description'.tr(),
              style: const TextStyle(
                fontSize: 8,
                color: PdfColors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        Row(
          children: [
            Text(
              '- ${'site_sheet.pdf.presence_of_electricity'.tr()} : ',
              style: const TextStyle(fontSize: _defaultFontSize),
            ),
            SizedBox(width: 20),
            getIt<PdfCheckboxWidgetInterface>(
              param1: PdfCheckboxProps(
                label: 'no'.tr(),
                isChecked: false,
                labelSize: _defaultFontSize,
              ),
            ),
            SizedBox(width: 20),
            getIt<PdfCheckboxWidgetInterface>(
              param1: PdfCheckboxProps(
                label: 'yes'.tr(),
                isChecked: false,
                labelSize: _defaultFontSize,
              ),
            ),
            SizedBox(width: 2),
            Text(
              'site_sheet.pdf.presence_of_electricity_yes_description'.tr(),
              style: const TextStyle(
                fontSize: 8,
                color: PdfColors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSiteSecurityFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: PdfColors.grey200,
              border: Border.all(
                width: .5,
                color: PdfColors.black,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: _defaultSpaceBetweenLines,
              vertical: _defaultSpaceBetweenLines / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ${'site_sheet.pdf.estimated_working_time'.tr()} : ',
                  style: TextStyle(
                    fontSize: _defaultFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: _defaultSpaceBetweenLines),
                Text(
                  '   ${'site_sheet.pdf.security_comments'.tr()} : ',
                  style: const TextStyle(fontSize: _defaultFontSize),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(
                width: .5,
                color: PdfColors.black,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: _defaultSpaceBetweenLines,
              vertical: _defaultSpaceBetweenLines / 2,
            ),
            child: Center(
              child: Text(
                'site_sheet.pdf.security_date_signature'.tr(),
                style: TextStyle(
                  fontSize: 8,
                  color: PdfColors.grey300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConditionReportContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _primaryColor,
                      content:
                          'site_sheet.pdf.condition_report'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          color: _secondaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Center(
                            child: Text(
                              'site_sheet.pdf.control_points'
                                  .tr()
                                  .toUpperCase(),
                              style: TextStyle(
                                color: PdfColors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          width: 100,
                          color: _secondaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Center(
                            child: Text(
                              'site_sheet.pdf.condition_found'
                                  .tr()
                                  .toUpperCase(),
                              style: TextStyle(
                                color: PdfColors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 100,
                          color: _secondaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Center(
                            child: Text(
                              'site_sheet.pdf.control_points_comments'
                                  .tr()
                                  .toUpperCase(),
                              style: TextStyle(
                                color: PdfColors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: PdfColors.grey200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  color: _primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 4,
                                  ),
                                  child: Text(
                                    'site_sheet.pdf.condition_report_water_supply'
                                        .tr()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 4,
                                  ),
                                  child: Text(
                                    'site_sheet.pdf.condition_report_water_supply_description'
                                        .tr(),
                                    style: const TextStyle(fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            color: PdfColors.grey200,
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getIt<PdfCheckboxWidgetInterface>(
                                  param1: PdfCheckboxProps(
                                    label: 'site_sheet.pdf.condition_found_good'
                                        .tr(),
                                    isChecked: false,
                                  ),
                                ),
                                getIt<PdfCheckboxWidgetInterface>(
                                  param1: PdfCheckboxProps(
                                    label:
                                        'site_sheet.pdf.condition_found_medium'
                                            .tr(),
                                    isChecked: false,
                                  ),
                                ),
                                getIt<PdfCheckboxWidgetInterface>(
                                  param1: PdfCheckboxProps(
                                    label: 'site_sheet.pdf.condition_found_bad'
                                        .tr(),
                                    isChecked: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: PdfColors.grey200,
                            padding: const EdgeInsets.only(
                              left: 2,
                              right: 2,
                              bottom: 6,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                getIt<PdfDottedLineWidgetInterface>(
                                  param1: PdfDottedLineProps(
                                    lineHeiht: 11,
                                    color: PdfColors.grey,
                                  ),
                                ),
                                getIt<PdfDottedLineWidgetInterface>(
                                  param1: PdfDottedLineProps(
                                    lineHeiht: 11,
                                    color: PdfColors.grey,
                                  ),
                                ),
                                getIt<PdfDottedLineWidgetInterface>(
                                  param1: PdfDottedLineProps(
                                    lineHeiht: 11,
                                    color: PdfColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_attic'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_attic_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_interior_ceilings'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_interior_ceilings_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_facade'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_facade_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_shutter_carpentry'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_shutter_carpentry_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_gutters'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_gutters_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_fascia_board'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_fascia_board_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_roof_window'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_roof_window_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: _primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_roof_window_shutters'
                              .tr()
                              .toUpperCase(),
                          style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          'site_sheet.pdf.condition_report_roof_window_shutters_description'
                              .tr(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_good'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_medium'.tr(),
                          isChecked: false,
                        ),
                      ),
                      getIt<PdfCheckboxWidgetInterface>(
                        param1: PdfCheckboxProps(
                          label: 'site_sheet.pdf.condition_found_bad'.tr(),
                          isChecked: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  color: PdfColors.grey200,
                  padding: const EdgeInsets.only(
                    left: 2,
                    right: 2,
                    bottom: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                      getIt<PdfDottedLineWidgetInterface>(
                        param1: PdfDottedLineProps(
                          lineHeiht: 11,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        getIt<PdfDottedLineWidgetInterface>(),
        getIt<PdfDottedLineWidgetInterface>(),
        getIt<PdfDottedLineWidgetInterface>(),
        getIt<PdfDottedLineWidgetInterface>(),
        getIt<PdfDottedLineWidgetInterface>(
          param1: PdfDottedLineProps(
            placeholder:
                'site_sheet.pdf.condition_report_comments'.tr().toUpperCase(),
          ),
        ),
        getIt<PdfDottedLineWidgetInterface>(
          param1: PdfDottedLineProps(
            placeholder:
                'site_sheet.pdf.condition_report_comments_description'.tr(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  getIt<PdfDottedLineWidgetInterface>(),
                  getIt<PdfDottedLineWidgetInterface>(),
                  getIt<PdfDottedLineWidgetInterface>(),
                  getIt<PdfDottedLineWidgetInterface>(),
                  getIt<PdfDottedLineWidgetInterface>(),
                  getIt<PdfDottedLineWidgetInterface>(),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Text(
                    '${'site_sheet.pdf.made_on'.tr()} : ',
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: .5),
                    ),
                    child: Center(
                      child: Text(
                        'site_sheet.pdf.signature_site_manager'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _defaultFontSize,
                          color: PdfColors.grey300,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Text(
                    '${'site_sheet.pdf.in'.tr()} : ',
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: .5),
                    ),
                    child: Center(
                      child: Text(
                        'site_sheet.pdf.signature_customer'.tr(),
                        style: TextStyle(
                          fontSize: _defaultFontSize,
                          color: PdfColors.grey300,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSiteTraceabilityContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _primaryColor,
                      content:
                          'site_sheet.pdf.site_traceability'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: 14),
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content:
                          'site_sheet.pdf.cleaning_banner'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: _defaultSpaceBetweenLines,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: .5),
                                ),
                                child: Center(
                                  child: Text(
                                    'site_sheet.pdf.technician_name'.tr(),
                                    style: const TextStyle(
                                      color: PdfColors.grey300,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              Center(
                                child: getIt<PdfDateFieldWidgetInterface>(
                                  param1: PdfDateFieldProps(),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'site_sheet.pdf.intervention_date'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(lineHeiht: 12),
                              ),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(lineHeiht: 12),
                              ),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(
                                  lineHeiht: 12,
                                  placeholder:
                                      'site_sheet.pdf.technician_comments'.tr(),
                                ),
                              ),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(lineHeiht: 12),
                              ),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(lineHeiht: 12),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: .5),
                                ),
                                child: Center(
                                  child: Text(
                                    'site_sheet.pdf.technician_signature'.tr(),
                                    style: const TextStyle(
                                      color: PdfColors.grey300,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ${'site_sheet.pdf.agency'.tr()} : ',
                                style: const TextStyle(
                                  fontSize: _defaultFontSize,
                                ),
                              ),
                              SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '- ${'site_sheet.pdf.tile_or_slate_dimensions'.tr()} ',
                                  style: const TextStyle(
                                    fontSize: _defaultFontSize,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'site_sheet.pdf.if_differents_from_support'
                                              .tr(),
                                      style: TextStyle(
                                        color: PdfColors.grey,
                                        fontSize: 8,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const TextSpan(text: ' : '),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '- ${'site_sheet.pdf.quantity_to_be_changed'.tr()} ',
                                  style: const TextStyle(
                                    fontSize: _defaultFontSize,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'site_sheet.pdf.if_different_from_support'
                                              .tr(),
                                      style: TextStyle(
                                        color: PdfColors.grey,
                                        fontSize: 8,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const TextSpan(text: ' : '),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '- ${'site_sheet.pdf.gutter_type_and_condition'.tr()} : ',
                                style: const TextStyle(
                                  fontSize: _defaultFontSize,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '- ${'site_sheet.pdf.repairs_to_be_made_and_materials_required'.tr()} : ',
                                style: const TextStyle(
                                  fontSize: _defaultFontSize,
                                ),
                              ),
                              SizedBox(height: 4),
                              getIt<PdfSelectWidgetInterface>(
                                param1: PdfSelectProps(
                                  label:
                                      '- ${'site_sheet.pdf.checking_and_protecting_unfinished_attics'.tr()}',
                                  valuesSize: _defaultFontSize,
                                  valuesWidth: 35,
                                  values: [
                                    PdfSelectValue(
                                      value: 'yes'.tr(),
                                      isChecked: false,
                                    ),
                                    PdfSelectValue(
                                      value: 'no'.tr(),
                                      isChecked: false,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: getIt<PdfSelectWidgetInterface>(
                                      param1: PdfSelectProps(
                                        label:
                                            '- ${'site_sheet.pdf.check_flashing'.tr()}',
                                        valuesSize: _defaultFontSize,
                                        valuesWidth: 35,
                                        values: [
                                          PdfSelectValue(
                                            value: 'yes'.tr(),
                                            isChecked: false,
                                          ),
                                          PdfSelectValue(
                                            value: 'no'.tr(),
                                            isChecked: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '- ${'site_sheet.pdf.ridge_type_and_condition'.tr()} : ',
                                      style: const TextStyle(
                                        fontSize: _defaultFontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: getIt<PdfSelectWidgetInterface>(
                                      param1: PdfSelectProps(
                                        label:
                                            '- ${'site_sheet.pdf.defoamer'.tr()}',
                                        valuesSize: _defaultFontSize,
                                        valuesWidth: 75,
                                        values: [
                                          PdfSelectValue(
                                            value:
                                                'site_sheet.pdf.already_completed'
                                                    .tr(),
                                            isChecked: false,
                                          ),
                                          PdfSelectValue(
                                            value:
                                                'site_sheet.pdf.to_be_realized'
                                                    .tr(),
                                            isChecked: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      '- ${'site_sheet.pdf.number_of_hooks'.tr()} : ',
                                      style: const TextStyle(
                                        fontSize: _defaultFontSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: .5,
                                          color: _primaryColor,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: _primaryColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 4,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${'site_sheet.pdf.to_be_completed_by_customer'.tr()}.',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: PdfColors.white,
                                                    fontSize: 8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 4,
                                                vertical: 2,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  getIt<
                                                      PdfSelectWidgetInterface>(
                                                    param1: PdfSelectProps(
                                                      label:
                                                          '- ${'site_sheet.pdf.cleaning'.tr()}',
                                                      valuesSize: 8,
                                                      valuesWidth: 60,
                                                      labelSize: 8,
                                                      labelWidth: 47,
                                                      checkboxSize: 8,
                                                      spacing: 4,
                                                      values: [
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.satisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.unsatisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  getIt<
                                                      PdfSelectWidgetInterface>(
                                                    param1: PdfSelectProps(
                                                      label:
                                                          '- ${'site_sheet.pdf.protection'.tr()}',
                                                      valuesSize: 8,
                                                      valuesWidth: 60,
                                                      labelSize: 8,
                                                      labelWidth: 47,
                                                      checkboxSize: 8,
                                                      spacing: 4,
                                                      values: [
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.satisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.unsatisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  getIt<
                                                      PdfSelectWidgetInterface>(
                                                    param1: PdfSelectProps(
                                                      label:
                                                          '- ${'site_sheet.pdf.security'.tr()}',
                                                      valuesSize: 8,
                                                      valuesWidth: 60,
                                                      labelSize: 8,
                                                      labelWidth: 47,
                                                      checkboxSize: 8,
                                                      spacing: 4,
                                                      values: [
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.satisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.unsatisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: .5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'site_sheet.pdf.date_signature_customer'
                                              .tr(),
                                          style: TextStyle(
                                            fontSize: _defaultFontSize,
                                            color: PdfColors.grey300,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content:
                          'site_sheet.pdf.water_repellent'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: _defaultSpaceBetweenLines,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: .5),
                                ),
                                child: Center(
                                  child: Text(
                                    'site_sheet.pdf.technician_name'.tr(),
                                    style: const TextStyle(
                                      color: PdfColors.grey300,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              Center(
                                child: getIt<PdfDateFieldWidgetInterface>(
                                  param1: PdfDateFieldProps(),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'site_sheet.pdf.intervention_date'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(lineHeiht: 12),
                              ),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(lineHeiht: 12),
                              ),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(
                                  lineHeiht: 12,
                                  placeholder:
                                      'site_sheet.pdf.technician_comments'.tr(),
                                ),
                              ),
                              getIt<PdfDottedLineWidgetInterface>(
                                param1: PdfDottedLineProps(
                                  lineHeiht: 12,
                                ),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: .5),
                                ),
                                child: Center(
                                  child: Text(
                                    'site_sheet.pdf.technician_signature'.tr(),
                                    style: const TextStyle(
                                      color: PdfColors.grey300,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ${'site_sheet.pdf.quantity_of_sales_and_tiles_changed'.tr()} : ',
                                style: const TextStyle(
                                  fontSize: _defaultFontSize,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '- ${'site_sheet.pdf.various_repairs_carried_out'.tr()} : ',
                                style: const TextStyle(
                                  fontSize: _defaultFontSize,
                                ),
                              ),
                              SizedBox(height: 28),
                              getIt<PdfSelectWidgetInterface>(
                                param1: PdfSelectProps(
                                  label:
                                      '- ${'site_sheet.pdf.chimney_paint'.tr()}',
                                  labelWidth: 95,
                                  valuesSize: _defaultFontSize,
                                  valuesWidth: 50,
                                  values: [
                                    PdfSelectValue(
                                      value: 'yes'.tr(),
                                      isChecked: false,
                                    ),
                                    PdfSelectValue(
                                      value: 'no'.tr(),
                                      isChecked: false,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              getIt<PdfSelectWidgetInterface>(
                                param1: PdfSelectProps(
                                  label:
                                      '- ${'site_sheet.pdf.ridge_waterproofing'.tr()}',
                                  labelWidth: 95,
                                  valuesSize: _defaultFontSize,
                                  valuesWidth: 50,
                                  values: [
                                    PdfSelectValue(
                                      value: 'yes'.tr(),
                                      isChecked: false,
                                    ),
                                    PdfSelectValue(
                                      value: 'no'.tr(),
                                      isChecked: false,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              getIt<PdfSelectWidgetInterface>(
                                param1: PdfSelectProps(
                                  label:
                                      '- ${'site_sheet.pdf.waterproof_eaves'.tr()}',
                                  labelWidth: 95,
                                  valuesSize: _defaultFontSize,
                                  valuesWidth: 50,
                                  values: [
                                    PdfSelectValue(
                                      value: 'yes'.tr(),
                                      isChecked: false,
                                    ),
                                    PdfSelectValue(
                                      value: 'no'.tr(),
                                      isChecked: false,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: .5,
                                          color: _primaryColor,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: _primaryColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 4,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${'site_sheet.pdf.to_be_completed_by_customer'.tr()}.',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: PdfColors.white,
                                                    fontSize: 8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 4,
                                                vertical: 2,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  getIt<
                                                      PdfSelectWidgetInterface>(
                                                    param1: PdfSelectProps(
                                                      label:
                                                          '- ${'site_sheet.pdf.cleaning'.tr()}',
                                                      valuesSize: 8,
                                                      valuesWidth: 60,
                                                      labelSize: 8,
                                                      labelWidth: 47,
                                                      checkboxSize: 8,
                                                      spacing: 4,
                                                      values: [
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.satisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.unsatisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  getIt<
                                                      PdfSelectWidgetInterface>(
                                                    param1: PdfSelectProps(
                                                      label:
                                                          '- ${'site_sheet.pdf.protection'.tr()}',
                                                      valuesSize: 8,
                                                      valuesWidth: 60,
                                                      labelSize: 8,
                                                      labelWidth: 47,
                                                      checkboxSize: 8,
                                                      spacing: 4,
                                                      values: [
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.satisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.unsatisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  getIt<
                                                      PdfSelectWidgetInterface>(
                                                    param1: PdfSelectProps(
                                                      label:
                                                          '- ${'site_sheet.pdf.security'.tr()}',
                                                      valuesSize: 8,
                                                      valuesWidth: 60,
                                                      labelSize: 8,
                                                      labelWidth: 47,
                                                      checkboxSize: 8,
                                                      spacing: 4,
                                                      values: [
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.satisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                        PdfSelectValue(
                                                          value:
                                                              'site_sheet.pdf.unsatisfactory'
                                                                  .tr(),
                                                          isChecked: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: .5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'site_sheet.pdf.date_signature_customer'
                                              .tr(),
                                          style: TextStyle(
                                            fontSize: _defaultFontSize,
                                            color: PdfColors.grey300,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _defaultSpaceBetweenLines),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getIt<PdfBannerWidgetInterface>(
                    param1: PdfBannerProps(
                      backgroundColor: _secondaryColor,
                      verticalPadding: 2,
                      fontSize: _defaultFontSize,
                      content:
                          'site_sheet.pdf.other_services'.tr().toUpperCase(),
                    ),
                  ),
                  SizedBox(height: _defaultSpaceBetweenLines),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: _defaultSpaceBetweenLines,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: .5),
                                ),
                                child: Center(
                                  child: Text(
                                    'site_sheet.pdf.technician_name'.tr(),
                                    style: const TextStyle(
                                      color: PdfColors.grey300,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              Center(
                                child: getIt<PdfDateFieldWidgetInterface>(
                                  param1: PdfDateFieldProps(),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'site_sheet.pdf.intervention_date'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              SizedBox(height: _defaultSpaceBetweenLines),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(width: .5),
                                ),
                                child: Center(
                                  child: Text(
                                    'site_sheet.pdf.technician_signature'.tr(),
                                    style: const TextStyle(
                                      color: PdfColors.grey300,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ${'site_sheet.pdf.description'.tr()} : ',
                                style: const TextStyle(
                                  fontSize: _defaultFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: PdfColors.grey200,
            border: Border.all(
              width: .5,
              color: _primaryColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                color: _primaryColor,
                child: Center(
                  child: Text(
                    'site_sheet.pdf.safety_reminders'.tr().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PdfColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    '\u2022 ${'site_sheet.pdf.safety_reminders_wearing_equipment_1'.tr()}',
                    style: TextStyle(
                      fontSize: 8,
                      color: _primaryColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'site_sheet.pdf.safety_reminders_wearing_equipment_2'
                          .tr(),
                      style: TextStyle(
                        fontSize: 8,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'site_sheet.pdf.safety_reminders_wearing_equipment_3'
                          .tr(),
                      style: TextStyle(
                        fontSize: 8,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    '\u2022 ${'site_sheet.pdf.safety_reminders_compliance_with_operating_procedures_1'.tr()}',
                    style: TextStyle(
                      fontSize: 8,
                      color: _primaryColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'site_sheet.pdf.safety_reminders_compliance_with_operating_procedures_2'
                          .tr(),
                      style: TextStyle(
                        fontSize: 8,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCertificateContent() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getIt<PdfBannerWidgetInterface>(
                param1: PdfBannerProps(
                  backgroundColor: _primaryColor,
                  content: 'site_sheet.pdf.site_completion_certificate'
                      .tr()
                      .toUpperCase(),
                ),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Row(
                children: [
                  Text(
                    'site_sheet.pdf.certificate_identity'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: getIt<PdfDottedLineWidgetInterface>(
                      param1: PdfDottedLineProps(lineHeiht: _defaultFontSize),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'site_sheet.pdf.certificate_address'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: getIt<PdfDottedLineWidgetInterface>(
                      param1: PdfDottedLineProps(lineHeiht: _defaultFontSize),
                    ),
                  ),
                ],
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'site_sheet.pdf.certificate_subject'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: getIt<PdfDottedLineWidgetInterface>(
                      param1: PdfDottedLineProps(lineHeiht: _defaultFontSize),
                    ),
                  ),
                ],
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'site_sheet.pdf.certificate_order_date'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: getIt<PdfDottedLineWidgetInterface>(
                      param1: PdfDottedLineProps(lineHeiht: _defaultFontSize),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Text(
                'site_sheet.pdf.certificate_order'.tr(),
                style: const TextStyle(fontSize: _defaultFontSize),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Row(
                children: [
                  Text(
                    'site_sheet.pdf.certificate_order_number'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: getIt<PdfDottedLineWidgetInterface>(
                      param1: PdfDottedLineProps(lineHeiht: _defaultFontSize),
                    ),
                  ),
                  SizedBox(width: 50),
                  Text(
                    'site_sheet.pdf.certificate_order_date_2'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 4),
                  getIt<PdfDateFieldWidgetInterface>(
                    param1: PdfDateFieldProps(),
                  ),
                  Spacer(flex: 3),
                ],
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Text(
                'site_sheet.pdf.certificate_order_executed'.tr(),
                style: const TextStyle(fontSize: _defaultFontSize),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Text(
                'site_sheet.pdf.certificate_end_of_works'.tr(),
                style: const TextStyle(fontSize: _defaultFontSize),
              ),
              SizedBox(height: _defaultSpaceBetweenLines),
              Text(
                'site_sheet.pdf.certificate_comments'.tr(),
                style: const TextStyle(fontSize: _defaultFontSize),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                  placeholder: 'site_sheet.pdf.certificate_comments_area'
                      .tr()
                      .toUpperCase(),
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              getIt<PdfDottedLineWidgetInterface>(
                param1: PdfDottedLineProps(
                  lineHeiht: _defaultFontSize + _defaultSpaceBetweenLines,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'site_sheet.pdf.made_on'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 4),
                  getIt<PdfDateFieldWidgetInterface>(
                    param1: PdfDateFieldProps(),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'site_sheet.pdf.in'.tr(),
                    style: const TextStyle(fontSize: _defaultFontSize),
                  ),
                  SizedBox(width: 4),
                  getIt<PdfDottedLineWidgetInterface>(
                    param1: PdfDottedLineProps(
                      width: 100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: .5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Text(
                        'site_sheet.pdf.signature_customer'.tr(),
                        style: TextStyle(
                          color: PdfColors.grey300,
                          fontSize: _defaultFontSize,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
