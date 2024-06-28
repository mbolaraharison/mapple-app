import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:maple_common/maple_common.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class OrderFormGeneratorInterface {
  Future<void> generate({
    required List<Representative> repValues,
    required Order order,
    bool openFile = true,
  });

  Future<void> generateQuote({
    required Order order,
    bool withSave = false,
  });
}

// Implementation:--------------------------------------------------------------
class OrderFormGenerator
    with PrivateDirectoryMixin
    implements OrderFormGeneratorInterface {
  // Variables:-----------------------------------------------------------------
  // Font
  final double _defaultFontSize = 8;

  // Colors
  late final PdfColor _primaryColor =
      PdfColor.fromInt(_appThemeData.orderFormTitleBannerColor.value);

  final PdfColor _secondaryColor = const PdfColor.fromInt(0xFF1B81CF);

  final PdfColor _tertiaryColor = PdfColors.green600;

  // Other variables
  late Representative? _representative;
  late Fair? _fair;

  // DTO
  late OrderFormDto _orderFormDto;

  // Services:------------------------------------------------------------------
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();
  late final AgencyServiceInterface _agencyService =
      getIt<AgencyServiceInterface>();
  late final EmailServiceInterface _emailService =
      getIt<EmailServiceInterface>();
  late final FairServiceInterface _fairService = getIt<FairServiceInterface>();

  // Utils:---------------------------------------------------------------------
  late final MarkdownUtilsInterface _markdownUtils =
      getIt<MarkdownUtilsInterface>();
  late final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();
  late final UuidUtilsInterface uuidUtils = getIt<UuidUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<void> generate({
    required List<Representative> repValues,
    required Order order,
    bool openFile = true,
  }) async {
    String uniqueName = 'order-form-${order.id}.pdf';

    // If envelope is already signed, don't generate the file
    // Download the file and open it
    if (order.envelopeAlreadySigned) {
      await _fileDataService.openFromFileSystemByUniqueName(
        uniqueName,
        withRemove: true,
      );
      return Future.value();
    }

    _representative = await _representativeService.getCurrent(eager: true);
    if (_representative == null) {
      return Future.value();
    }
    _fair = await _fairService.getCurrent();
    _orderFormDto = await OrderFormDto.create(
      order: order,
      representative: _representative!,
      isOrderForm: true,
      representatives: repValues,
      fair: _fair,
    );

    // Check if we have correct data and terms to add to create order form
    _orderFormDto.verify();

    Directory directory = await privateDirectory;
    File file = File('${directory.path}/$uniqueName');
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoRegular)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoBold)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoItalic)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.cupertinoIcons)),
        ),
        footer: _buildFooter,
        build: (context) => _buildOrderForm(),
      ),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoRegular)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoBold)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoItalic)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.cupertinoIcons)),
        ),
        footer: _buildFooter,
        build: (context) => _buildTerms(),
      ),
    );

    // save the file
    await file.writeAsBytes(await doc.save(), flush: true);
    if (openFile) {
      await _fileDataService.openFromFileSystemByUniqueName(
        uniqueName,
        download: false,
        withRemove: true,
      );
    }
  }

  @override
  Future<void> generateQuote({
    required Order order,
    bool open = true,
    bool withSave = false,
  }) async {
    late final String uniqueName;
    late final String displayName;
    late final File file;

    _representative = await _representativeService.getCurrent(eager: true);
    Agency currentAgency = (await _agencyService.getCurrent())!;
    Customer? customer = await _customerService.getById(order.customerId);
    if (customer == null) {
      return Future.value();
    }
    _fair = await _fairService.getCurrent();

    _orderFormDto = await OrderFormDto.create(
      order: order,
      representative: _representative!,
      isOrderForm: false,
      fair: _fair,
    );

    // If withSave -> send quote by email (increment version), else preview
    if (withSave == true) {
      final version =
          await _customerService.getQuoteFormIdAndIncrement(customer.id);
      uniqueName = 'quote_form.filename_version'.tr(namedArgs: {
        'orderFormId': _orderFormDto.orderNumber,
        'version': version.toString(),
      });
      displayName = 'quote_form.display_filename_version'.tr(namedArgs: {
        'version': version.toString(),
      });
      file = await _fileUtils.save(
        path: await _fileUtils.getUploadPath(
          agencyName: currentAgency.label,
          customerName: customer.name,
          fileName: uniqueName,
        ),
      );
    } else {
      uniqueName = 'quote_form.filename_preview'.tr(namedArgs: {
        'orderFormId': _orderFormDto.orderNumber,
      });
      Directory directory = await privateDirectory;
      file = File('${directory.path}/$uniqueName');
    }

    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoRegular)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoBold)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoItalic)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.cupertinoIcons)),
        ),
        footer: _buildFooter,
        build: (context) => _buildQuoteForm(),
      ),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoRegular)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoBold)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.robotoItalic)),
          Font.ttf(await rootBundle.load(MapleCommonAssets.cupertinoIcons)),
        ),
        footer: _buildFooter,
        build: (context) => _buildQuoteTerms(),
      ),
    );

    await file.writeAsBytes(await doc.save());

    // If withSave -> create file data, open it and upload it
    if (withSave == true) {
      final fileData = FileData(
        id: uuidUtils.generate(),
        uniqueName: uniqueName,
        displayName: displayName,
        syncStatus: SyncStatus.NOT_READY,
        mode: FileDataMode.remote,
        customerId: customer.id,
        type: FileDataType.quote,
        size: 0, // Set in firebase,
        agencyId: _representative!.agencyId,
      );

      await _fileDataService.createAndUpload(fileData, file);
      await _emailService.sendQuote(fileData, order, _representative);

      return;
    } else {
      await _fileDataService.openFromFileSystemByUniqueName(
        uniqueName,
        download: false,
        withRemove: true,
      );
    }
  }

  pw.PageTheme _buildTheme(
      pw.Font base, pw.Font bold, pw.Font italic, pw.Font icons) {
    return pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
        icons: icons,
      ),
      margin: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(children: [
      pw.SizedBox(height: 20),
      _buildSeparator(color: PdfColors.black),
      pw.SizedBox(height: 8),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            _orderFormDto.dateTimeString,
            style: pw.TextStyle(fontSize: _defaultFontSize),
          ),
          pw.Text(
            '${context.pageNumber} / ${context.document.pdfPageList.pages.length.toString()}',
            style: pw.TextStyle(fontSize: _defaultFontSize),
          ),
        ],
      ),
    ]);
  }

  List<pw.Widget> _buildOrderForm() {
    return [
      _buildLogoAndInfo(),
      pw.SizedBox(height: 8),
      _buildOrderFormRow(),
      pw.SizedBox(height: 4),
      _buildSignersDetailsRow(),
      pw.SizedBox(height: 4),
      _buildOrderDetailRow(),
      pw.SizedBox(height: 6),
      _buildHeadersRow(),
      pw.SizedBox(height: 3),
      _buildOrderRows(),
      pw.SizedBox(height: 6),
      _buildTotalsRow(),
      pw.SizedBox(height: 10),
      _buildDiscountHeaders(),
      pw.SizedBox(height: 6),
      _buildDiscountRows(),
      pw.SizedBox(height: 8),
      _buildSeparator(),
      pw.SizedBox(height: 12),
      _buildTaxRow(),
      pw.SizedBox(height: 12),
      _buildPaymentRow(),
      pw.SizedBox(height: 12),
      _buildDatesRow(),
      pw.SizedBox(height: 12),
      _buildKeepOldStuffRow(),
      pw.SizedBox(height: 12),
      _buildAcceptTerms(),
      pw.SizedBox(height: 16),
      _buildSignatures(),
      pw.Spacer(),
      _buildCancellationForm(),
    ];
  }

  List<pw.Widget> _buildQuoteForm() {
    return [
      _buildLogoAndInfo(),
      pw.SizedBox(height: 8),
      _buildQuoteFormRow(),
      pw.SizedBox(height: 4),
      _buildSignersDetailsRow(),
      pw.SizedBox(height: 4),
      _buildOrderDetailRow(),
      pw.SizedBox(height: 6),
      _buildHeadersRow(),
      pw.SizedBox(height: 3),
      _buildOrderRows(),
      pw.SizedBox(height: 6),
      _buildTotalsRow(),
      pw.SizedBox(height: 10),
      _buildDiscountHeaders(),
      pw.SizedBox(height: 6),
      _buildDiscountRows(),
      pw.SizedBox(height: 8),
      _buildSeparator(),
      pw.SizedBox(height: 12),
      _buildTaxRow(),
      pw.SizedBox(height: 12),
      _buildDatesRow(),
      pw.SizedBox(height: 12),
      _buildQuoteAcceptTerms(),
      pw.SizedBox(height: 16),
      _buildQuoteSignatures(),
      pw.Spacer(),
      _buildCancellationForm(),
    ];
  }

  List<pw.Widget> _buildTerms() {
    return [
      pw.Text(
        'order_form.terms.title'.tr(),
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 10),
      ..._markdownUtils.parseForPdf(_orderFormDto.terms, {
        'agencyName': _orderFormDto.agencyLabel,
        'agencyAddress': _orderFormDto.agencyAddress,
        'agencyPostalCode': _orderFormDto.agencyPostalCode,
        'agencyCity': _orderFormDto.agencyCity,
        'agencyPhone': _orderFormDto.agencyPhone,
        'agencyEmail': _orderFormDto.agencyEmail,
        'agencySiret': _orderFormDto.agencySiret,
      }),
    ];
  }

  List<pw.Widget> _buildQuoteTerms() {
    return [
      pw.Text(
        'order_form.terms.title'.tr(),
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 10),
      ..._markdownUtils.parseForPdf(_orderFormDto.terms, {
        'agencyName': _orderFormDto.agencyLabel,
        'agencyAddress': _orderFormDto.agencyAddress,
        'agencyPostalCode': _orderFormDto.agencyPostalCode,
        'agencyCity': _orderFormDto.agencyCity,
        'agencyPhone': _orderFormDto.agencyPhone,
        'agencyEmail': _orderFormDto.agencyEmail,
        'agencySiret': _orderFormDto.agencySiret,
      }),
    ];
  }

  pw.Widget _buildLogoAndInfo() {
    return pw.Row(children: [
      pw.Expanded(
        flex: 5,
        child: pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Image(_orderFormDto.logo),
            ),
            if (_orderFormDto.hasFairAccess)
              pw.Column(children: [
                pw.SizedBox(height: 10),
                pw.Container(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4, horizontal: 4),
                    child: pw.Center(
                      child: pw.Text(
                        'order_form.no_right_of_withdrawal_for_fair'.tr(),
                        style: const pw.TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 0.5,
                    ),
                  ),
                ),
              ]),
          ],
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
        child: pw.Container(
          width: 1,
          height: 85,
          color: PdfColors.black,
        ),
      ),
      pw.Expanded(
        flex: 4,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              _orderFormDto.agencyLabel,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(_orderFormDto.agencyAddress,
                style: const pw.TextStyle(fontSize: 9)),
            pw.SizedBox(height: 10),
            pw.Text(
              '${_orderFormDto.agencyPostalCode} ${_orderFormDto.agencyCity}',
              style: const pw.TextStyle(fontSize: 9),
            ),
            pw.Text(
              'order_form.phone_with_label'
                  .tr(namedArgs: {'phone': _orderFormDto.agencyPhone}),
              style: const pw.TextStyle(fontSize: 9),
            ),
            pw.Text(
              'order_form.mail_with_label'
                  .tr(namedArgs: {'mail': _orderFormDto.agencyEmail}),
              style: const pw.TextStyle(fontSize: 9),
            ),
            pw.Text(
              'order_form.agency_siret'
                  .tr(namedArgs: {'siret': _orderFormDto.agencySiret}),
              style: const pw.TextStyle(fontSize: 9),
            ),
          ],
        ),
      ),
    ]);
  }

  pw.Widget _buildOrderFormRow() {
    return pw.Container(
      color: _primaryColor,
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 4),
        child: pw.Center(
          child: pw.Text(
            'order_form.order_form_number'.tr(
              namedArgs: {'number': _orderFormDto.orderNumber},
            ),
            style: const pw.TextStyle(
              color: PdfColors.white,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  pw.Widget _buildQuoteFormRow() {
    return pw.Container(
      color: _primaryColor,
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 4),
        child: pw.Center(
          child: pw.Text(
            'quote_form.quote_form_number'.tr(
              namedArgs: {'number': _orderFormDto.orderNumber},
            ),
            style: const pw.TextStyle(
              color: PdfColors.white,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  pw.Widget _buildSignersDetailsRow() {
    return pw.Table(
      defaultColumnWidth: const pw.FlexColumnWidth(1),
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.full,
      children: [
        pw.TableRow(
          children: [
            pw.Container(
              margin: const pw.EdgeInsets.only(right: 3),
              child: pw.Center(
                child: pw.Text(
                  'order_form.customer_details'.tr(),
                  style: pw.TextStyle(
                    fontSize: 7,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.symmetric(horizontal: 3),
              child: pw.Center(
                child: pw.Text(
                  'order_form.customer_site_details'.tr(),
                  style: pw.TextStyle(
                    fontSize: 7,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.only(left: 3),
              child: pw.Center(
                child: pw.Text(
                  'order_form.seller_details'.tr(),
                  style: pw.TextStyle(
                    fontSize: 7,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              margin: const pw.EdgeInsets.only(right: 3),
              padding: const pw.EdgeInsets.all(4),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: _buildCustomerDetails(),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.symmetric(horizontal: 3),
              padding: const pw.EdgeInsets.all(4),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: _buildCustomerSiteDetails(),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.only(left: 3),
              padding: const pw.EdgeInsets.all(4),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: _buildSellersDetails(),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildCustomerDetails() {
    final List<pw.Widget> children = [];

    for (var contact in _orderFormDto.customerContacts) {
      children.addAll([
        pw.Text(
          contact.fullName,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: _defaultFontSize,
          ),
        ),
        if (contact.phone.isNotEmpty)
          pw.Text(
            'order_form.phone_with_label'
                .tr(namedArgs: {'phone': contact.phone}),
            style: pw.TextStyle(fontSize: _defaultFontSize),
          ),
        if (contact.mobilePhone.isNotEmpty)
          pw.Text(
            'order_form.mobile_phone_with_label'
                .tr(namedArgs: {'mobilePhone': contact.mobilePhone}),
            style: pw.TextStyle(fontSize: _defaultFontSize),
          ),
        pw.Text(
          'order_form.mail_with_label'.tr(namedArgs: {'mail': contact.email}),
          style: pw.TextStyle(fontSize: _defaultFontSize),
        ),
        pw.SizedBox(height: 3),
      ]);
    }

    children.addAll([
      pw.Text(
        _orderFormDto.customerAddress,
        style: pw.TextStyle(fontSize: _defaultFontSize),
      ),
      pw.Text(
        '${_orderFormDto.customerPostalCode} ${_orderFormDto.customerCity}',
        style: pw.TextStyle(fontSize: _defaultFontSize),
      ),
    ]);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    );
  }

  pw.Widget _buildCustomerSiteDetails() {
    if (_orderFormDto.orderHasCustomerSiteDetails == false) {
      return pw.Container();
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          _orderFormDto.orderAddress,
          style: pw.TextStyle(fontSize: _defaultFontSize),
        ),
        pw.Text(
          '${_orderFormDto.orderPostalCode} ${_orderFormDto.orderCity}',
          style: pw.TextStyle(fontSize: _defaultFontSize),
        ),
      ],
    );
  }

  pw.Widget _buildSellersDetails() {
    List<pw.Widget> children = [];

    for (var rep in _orderFormDto.representatives) {
      children.add(
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text(
            rep.fullName,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: _defaultFontSize,
            ),
          ),
          if (rep.showPhone)
            rep.phone != ''
                ? pw.Text(
                    'order_form.phone_with_label'
                        .tr(namedArgs: {'phone': rep.phone}),
                    style: pw.TextStyle(fontSize: _defaultFontSize),
                  )
                : pw.Container(),
          if (rep.showEmail)
            rep.email != ''
                ? pw.Text(
                    'order_form.mail_with_label'
                        .tr(namedArgs: {'mail': rep.email}),
                    style: pw.TextStyle(fontSize: _defaultFontSize),
                  )
                : pw.Container(),
        ]),
      );
      children.add(pw.SizedBox(height: 4));
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    );
  }

  pw.Widget _buildOrderDetailRow() {
    return pw.Container(
      color: PdfColors.grey800,
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 4),
        child: pw.Center(
          child: pw.Text(
            'order_form.order_detail'.tr().toUpperCase(),
            style: const pw.TextStyle(
              color: PdfColors.white,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  pw.Widget _buildHeadersRow() {
    return pw.Row(
      children: [
        _buildHeaderCell(
          'order_form.headers.product_code'.tr(),
          width: 50,
        ),
        pw.SizedBox(width: 2),
        pw.Expanded(
          child: _buildHeaderCell('order_form.headers.description'.tr()),
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.qty'.tr(),
          width: 25,
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.unity'.tr(),
          width: 25,
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.price_without_tax'.tr(),
          width: 46,
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.total_without_tax'.tr(),
          width: 43,
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.tax_rate'.tr(),
          width: 26,
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.tax_amount'.tr(),
          width: 42,
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.total_with_tax'.tr(),
          width: 46,
        ),
      ],
    );
  }

  pw.Widget _buildOrderRows() {
    List<pw.Widget> rows = _orderFormDto.orderRows
        .map(
          (e) => pw.Column(
            children: [
              _buildSeparator(),
              pw.SizedBox(height: 3),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 50,
                    padding: const pw.EdgeInsets.only(right: 6),
                    child: pw.Text(
                      e.code,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          e.label,
                          style: pw.TextStyle(fontSize: _defaultFontSize),
                        ),
                        if (e.options.isNotEmpty)
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(top: 4, left: 10),
                            child: pw.Text(
                              'order_form.options_with_label'
                                  .tr(namedArgs: {'options': e.options}),
                              style: const pw.TextStyle(fontSize: 6),
                            ),
                          ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 4, left: 10),
                          child: pw.Text(
                            e.designation,
                            style: const pw.TextStyle(fontSize: 6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.SizedBox(
                    width: 25,
                    child: pw.Text(
                      e.quantity,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.SizedBox(
                    width: 25,
                    child: pw.Text(
                      e.unit,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.SizedBox(
                    width: 43,
                    child: pw.Text(
                      e.grossPrice,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.SizedBox(
                    width: 46,
                    child: pw.Text(
                      e.totalGrossExclTax,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.SizedBox(
                    width: 26,
                    child: pw.Text(
                      e.tax,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.SizedBox(
                    width: 42,
                    child: pw.Text(
                      e.grossTaxAmount,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                  pw.SizedBox(width: 2),
                  pw.SizedBox(
                    width: 46,
                    child: pw.Text(
                      e.totalGrossInclTax,
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              e.suppliersDto != null
                  ? _buildSupplierOrderRow(e)
                  : pw.SizedBox(),
            ],
          ),
        )
        .toList();

    return pw.Column(children: rows);
  }

  pw.Widget _buildSupplierOrderRow(OrderFormOrderRowsDto orderRow) {
    return pw.Column(children: [
      _buildSuppliesOrderRow(orderRow),
      orderRow.suppliersDto!.workforceGrossPrice != null &&
              orderRow.suppliersDto!.workforceTotalGrossExclTax != null &&
              orderRow.suppliersDto!.workforceGrossTaxAmount != null &&
              orderRow.suppliersDto!.workforceTotalGrossInclTax != null
          ? _buildWorkforceOrderRow(orderRow)
          : pw.SizedBox(),
      pw.SizedBox(height: 8),
      _buildSupplierDetailsOrderRow(orderRow),
      pw.SizedBox(height: 8),
    ]);
  }

  pw.Widget _buildSuppliesOrderRow(OrderFormOrderRowsDto orderRow) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(width: 25),
        pw.Container(
          width: 25,
          padding: const pw.EdgeInsets.only(right: 6),
          child: pw.Text(
            '${'order_form.supplier.including'.tr()} : ',
            style: const pw.TextStyle(fontSize: 6),
          ),
        ),
        pw.SizedBox(width: 2),
        pw.Expanded(
          child: pw.Text(
            ('order_form.supplier.supplies').tr(),
            style: const pw.TextStyle(fontSize: 6),
          ),
        ),
        pw.SizedBox(width: 2),
        pw.SizedBox(
          width: 25,
          child: pw.Text(
            orderRow.quantity,
            style: const pw.TextStyle(fontSize: 6),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.SizedBox(width: 2),
        pw.SizedBox(
          width: 25,
          child: pw.Text(
            orderRow.unit,
            style: const pw.TextStyle(fontSize: 6),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.SizedBox(width: 2),
        pw.SizedBox(
          width: 43,
          child: pw.Text(
            orderRow.suppliersDto!.suppliesGrossPrice,
            style: const pw.TextStyle(fontSize: 6),
            textAlign: pw.TextAlign.right,
          ),
        ),
        pw.SizedBox(width: 2),
        pw.SizedBox(
          width: 46,
          child: pw.Text(
            orderRow.suppliersDto!.suppliesTotalGrossExclTax,
            style: const pw.TextStyle(fontSize: 6),
            textAlign: pw.TextAlign.right,
          ),
        ),
        pw.SizedBox(width: 2),
        pw.SizedBox(
          width: 26,
          child: pw.Text(
            orderRow.tax,
            style: const pw.TextStyle(fontSize: 6),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.SizedBox(width: 2),
        pw.SizedBox(
          width: 42,
          child: pw.Text(
            orderRow.suppliersDto!.suppliesGrossTaxAmount,
            style: const pw.TextStyle(fontSize: 6),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.SizedBox(width: 2),
        pw.SizedBox(
          width: 46,
          child: pw.Text(
            orderRow.suppliersDto!.suppliesTotalGrossInclTax,
            style: const pw.TextStyle(fontSize: 6),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildWorkforceOrderRow(OrderFormOrderRowsDto orderRow) {
    return pw.Column(children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(width: 25),
          pw.Container(
            width: 25,
            padding: const pw.EdgeInsets.only(right: 6),
          ),
          pw.SizedBox(width: 2),
          pw.Expanded(
            child: pw.Text(
              ('order_form.supplier.workforce').tr(),
              style: const pw.TextStyle(fontSize: 6),
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 25,
            child: pw.Text(
              orderRow.quantity,
              style: const pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 25,
            child: pw.Text(
              orderRow.unit,
              style: const pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 43,
            child: pw.Text(
              orderRow.suppliersDto!.workforceGrossPrice!,
              style: const pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 46,
            child: pw.Text(
              orderRow.suppliersDto!.workforceTotalGrossExclTax!,
              style: const pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 26,
            child: pw.Text(
              orderRow.tax,
              style: const pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 42,
            child: pw.Text(
              orderRow.suppliersDto!.workforceGrossTaxAmount!,
              style: const pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 46,
            child: pw.Text(
              orderRow.suppliersDto!.workforceTotalGrossInclTax!,
              style: const pw.TextStyle(fontSize: 6),
              textAlign: pw.TextAlign.right,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: 8),
    ]);
  }

  pw.Widget _buildSupplierDetailsOrderRow(OrderFormOrderRowsDto orderRow) {
    return pw.Column(children: [
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.SizedBox(width: 25),
        pw.Expanded(
          child: pw.Text(
            '${'order_form.supplier.project_end_date'.tr()} : ${orderRow.suppliersDto!.projectEndDate}',
            style: const pw.TextStyle(fontSize: 6),
          ),
        ),
        pw.SizedBox(width: 2),
        pw.Expanded(
          child: pw.Text(
            '${'order_form.supplier.supplied_by'.tr()} : ${orderRow.suppliersDto!.name}',
            style: const pw.TextStyle(fontSize: 6),
          ),
        ),
        pw.SizedBox(width: 2),
        pw.Expanded(
          child: pw.Text(
            '${'order_form.supplier.siret'.tr()} : ${orderRow.suppliersDto!.siret}',
            style: const pw.TextStyle(fontSize: 6),
          ),
        ),
      ]),
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.SizedBox(width: 25),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
        pw.SizedBox(width: 2),
        pw.Expanded(
          child: pw.Text(
            orderRow.suppliersDto!.address,
            style: const pw.TextStyle(fontSize: 6),
          ),
        ),
        pw.SizedBox(width: 2),
        orderRow.suppliersDto!.rgeCertificateNumber.trim().isNotEmpty
            ? pw.Expanded(
                child: pw.Text(
                  '${'order_form.supplier.rge_certificate'.tr()} : ${orderRow.suppliersDto!.rgeCertificateNumber}',
                  style: const pw.TextStyle(fontSize: 6),
                ),
              )
            : pw.SizedBox(),
      ]),
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.SizedBox(width: 25),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
        pw.SizedBox(width: 2),
        pw.Expanded(
          child: pw.Text(
            orderRow.suppliersDto!.postalCodeCity,
            style: const pw.TextStyle(fontSize: 6),
          ),
        ),
        pw.SizedBox(width: 2),
        orderRow.suppliersDto!.rgeQualification.trim().isNotEmpty
            ? pw.Expanded(
                child: pw.Text(
                  '${'order_form.supplier.rge_qualifications'.tr()} : ${orderRow.suppliersDto!.rgeQualification}',
                  style: const pw.TextStyle(fontSize: 6),
                ),
              )
            : pw.SizedBox(),
      ]),
    ]);
  }

  pw.Widget _buildTotalsRow() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Column(
          children: [
            pw.Text(
              'order_form.headers.total_without_tax'.tr(),
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
            pw.SizedBox(height: 4),
            _buildValueBox(
              label: "order_form.without_tax".tr(),
              value: _orderFormDto.orderTotalGrossExclTax,
            ),
          ],
        ),
        pw.SizedBox(width: 14),
        pw.Column(
          children: [
            pw.Text(
              'order_form.headers.total_with_tax'.tr(),
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
            pw.SizedBox(height: 4),
            _buildValueBox(
              label: "order_form.with_tax".tr(),
              value: _orderFormDto.orderTotalGrossInclTax,
            )
          ],
        ),
      ],
    );
  }

  pw.Widget _buildDiscountHeaders() {
    if (_orderFormDto.orderDiscountRows.isEmpty) {
      return pw.Container();
    }
    return pw.Row(
      children: [
        pw.Expanded(
          child: _buildHeaderCell(
            'order_form.headers.product'.tr(),
          ),
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.discount'.tr(),
          width: 50,
        ),
        pw.SizedBox(width: 2),
        _buildHeaderCell(
          'order_form.headers.discounted_amount'.tr(),
          width: 50,
        ),
      ],
    );
  }

  pw.Widget _buildDiscountRows() {
    if (_orderFormDto.orderDiscountRows.isEmpty) {
      return pw.Container();
    }
    List<pw.Widget> children = _orderFormDto.orderDiscountRows.map((e) {
      return pw.Row(
        children: [
          pw.Container(
            constraints: const pw.BoxConstraints(minWidth: 50),
            child: pw.Text(
              e.code,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ),
          pw.SizedBox(width: 2),
          pw.Expanded(
            child: pw.Text(
              e.label,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 50,
            child: pw.Text(
              e.discount,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ),
          pw.SizedBox(width: 2),
          pw.SizedBox(
            width: 50,
            child: pw.Text(
              e.totalNetInclTax,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ),
        ],
      );
    }).toList();

    return pw.Column(children: children);
  }

  pw.Widget _buildTaxRow() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: _buildTaxColumn(TaxLevel.RED),
        ),
        pw.SizedBox(width: 14),
        pw.Expanded(
          child: _buildTaxColumn(TaxLevel.RED10),
        ),
        pw.SizedBox(width: 14),
        pw.Expanded(
          child: _buildTaxColumn(TaxLevel.NOR),
        ),
        pw.SizedBox(width: 14),
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.SizedBox(height: 6.5),
              pw.Text(
                'order_form.total_to_be_paid'.tr(),
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 6),
              _buildValueBox(
                label: 'order_form.with_tax'.tr(),
                labelFontSize: 11,
                value: _orderFormDto.orderTotalNetInclTax,
                valueColor: _tertiaryColor,
                fontSize: 13,
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTaxColumn(TaxLevel taxLevel) {
    final OrderFormTaxColumnDto taxColumnDto =
        _orderFormDto.orderTaxColumns[taxLevel]!;

    return pw.Column(
      children: [
        _buildValueBox(
          label: 'order_form.without_tax'.tr(),
          value: taxColumnDto.amountExclTax,
        ),
        pw.SizedBox(height: 6),
        _buildValueBox(
          label: 'order_form.tax'.tr(namedArgs: {'rate': taxColumnDto.tax}),
          value: taxColumnDto.amountTax,
          color: _secondaryColor,
        ),
        pw.SizedBox(height: 6),
        _buildValueBox(
          label: 'order_form.with_tax'.tr(),
          value: taxColumnDto.amountInclTax,
          valueColor: _tertiaryColor,
        ),
      ],
    );
  }

  pw.Widget _buildPaymentRow() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 4,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(4),
            constraints: const pw.BoxConstraints(
              minHeight: 120,
            ),
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(4),
              color: PdfColors.grey200,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'order_form.terms_of_payment'.tr(),
                  style: pw.TextStyle(
                    fontSize: 7,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  children: [
                    getIt<PdfCheckboxWidgetInterface>(
                      param1: PdfCheckboxProps(
                        label: 'order_form.deposit'.tr(),
                        isChecked: _orderFormDto.hasDeposit,
                      ),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Text(
                      '${_orderFormDto.deposit} ${'order_form.with_tax'.tr()}',
                      style: pw.TextStyle(fontSize: _defaultFontSize),
                    ),
                  ],
                ),
                pw.SizedBox(height: 6),
                getIt<PdfCheckboxWidgetInterface>(
                  param1: PdfCheckboxProps(
                    label: 'order_form.cash'.tr(),
                    isChecked: _orderFormDto.isCashPayment,
                  ),
                ),
                if (_orderFormDto.isCashPayment) ...[
                  pw.SizedBox(height: 6),
                  _buildCashPayment()
                ],
                pw.SizedBox(height: 6),
                getIt<PdfCheckboxWidgetInterface>(
                  param1: PdfCheckboxProps(
                    label: 'order_form.funding'.tr(),
                    isChecked: _orderFormDto.isFinancingPayment,
                  ),
                ),
                if (_orderFormDto.isFinancingPayment) ...[
                  pw.SizedBox(height: 6),
                  _buildFinancingPayment()
                ],
              ],
            ),
          ),
        ),
        pw.SizedBox(width: 8),
        pw.Expanded(
          flex: 3,
          child: _buildRepsSignatures(),
        ),
      ],
    );
  }

  pw.Widget _buildCashPayment() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Text(
              'order_form.cash_payment_method'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.cashPaymentMethod,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Row(
          children: [
            pw.Text(
              'order_form.intermediate_payment'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              '${_orderFormDto.intermediatePayment} ${'cart.with_vat'.tr()}',
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Row(
          children: [
            pw.Text(
              'order_form.end_of_works_payment'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              '${_orderFormDto.endOfWorkPayment} ${'cart.with_vat'.tr()}',
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildFinancingPayment() {
    return pw.Container(
      width: 50,
      child: pw.Row(children: [
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Row(children: [
            pw.Text(
              'order_form.funder'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.funder,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
          pw.SizedBox(height: 6),
          pw.Row(children: [
            pw.Text(
              'order_form.credit_amount'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              '${_orderFormDto.credit} ${'cart.with_vat'.tr()}',
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
          pw.SizedBox(height: 6),
          pw.Row(children: [
            pw.Text(
              'order_form.monthly_payments_count'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.monthlyPaymentsCount,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
          pw.SizedBox(height: 6),
          pw.Row(children: [
            pw.Text(
              'order_form.credit_total_cost'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.creditTotalCost,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
          pw.SizedBox(height: 6),
          pw.Row(children: [
            pw.Text(
              'order_form.monthly_payment_amount'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.monthlyPaymentAmount,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
        ]),
        pw.SizedBox(width: 10),
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Row(children: [
            pw.Text(
              'order_form.nominal_rate'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.nominalRate,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
          pw.SizedBox(height: 6),
          pw.Row(children: [
            pw.Text(
              'order_form.apr'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.apr,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
          pw.SizedBox(height: 6),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'order_form.insurance'.tr(namedArgs: {
                  'type': _orderFormDto.insuranceType,
                }),
                style: pw.TextStyle(
                  fontSize: _defaultFontSize,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Container(
                width: 150,
                child: pw.Text(
                  _orderFormDto.insuranceType,
                  maxLines: 3,
                  style: pw.TextStyle(fontSize: _defaultFontSize, height: 20),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Row(children: [
            pw.Text(
              'order_form.deferment'.tr(),
              style: pw.TextStyle(
                fontSize: _defaultFontSize,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(width: 6),
            pw.Text(
              _orderFormDto.deferment,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ]),
        ]),
      ]),
    );
  }

  pw.Widget _buildRepsSignatures() {
    List<pw.Widget> children = [];

    for (var i = 0; i < _orderFormDto.representatives.length; i++) {
      var rep = _orderFormDto.representatives[i];

      children.add(
        pw.Row(
          children: [
            pw.Container(
              width: 100,
              padding: const pw.EdgeInsets.symmetric(vertical: 6),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(4),
                color: PdfColors.grey200,
              ),
              child: pw.Center(
                child: pw.Text(
                  'order_form.consulting_technician'.tr(
                    namedArgs: {'number': (i + 1).toString()},
                  ),
                  style: pw.TextStyle(fontSize: _defaultFontSize),
                ),
              ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
              child: pw.Center(
                child: pw.Text(
                  rep.fullName.toUpperCase(),
                  style: pw.TextStyle(fontSize: _defaultFontSize),
                ),
              ),
            ),
          ],
        ),
      );

      children.add(pw.SizedBox(height: 40));
    }

    return pw.Column(children: children);
  }

  pw.Widget _buildDatesRow() {
    List<pw.Widget> children = [];
    if (_orderFormDto.isOrderForm) {
      children.addAll([
        pw.Expanded(
          child: _buildDateField(
            'order_form.date_of_order'.tr(),
            _orderFormDto.dateString,
          ),
        ),
        pw.SizedBox(width: 14),
      ]);
    }
    children.add(
      pw.Expanded(
        child: _buildDateField(
          'order_form.desired_installation_date'.tr(),
          _orderFormDto.installationDate,
        ),
      ),
    );
    if (_orderFormDto.isOrderForm) {
      children.addAll([
        pw.SizedBox(width: 14),
        pw.Expanded(
          child: _buildDateField(
            'order_form.deadline_date'.tr(),
            _orderFormDto.deadlineDate,
          ),
        ),
      ]);
    }
    return pw.Row(
      children: children,
    );
  }

  pw.Widget _buildKeepOldStuffRow() {
    return pw.SizedBox(
      width: 260,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'order_form.keep_old_stuff'.tr(),
            style: pw.TextStyle(fontSize: _defaultFontSize),
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Row(
                children: [
                  getIt<PdfCheckboxWidgetInterface>(
                    param1: PdfCheckboxProps(
                      isChecked: _orderFormDto.keepOldStuff,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Text(
                    'yes'.tr(),
                    style: pw.TextStyle(fontSize: _defaultFontSize),
                  ),
                ],
              ),
              getIt<PdfCheckboxWidgetInterface>(
                param1: PdfCheckboxProps(
                  label: 'no'.tr(),
                  isChecked: !_orderFormDto.keepOldStuff,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildAcceptTerms() {
    return pw.SizedBox(
      child: pw.Column(
        children: [
          getIt<PdfCheckboxWidgetInterface>(
            param1: PdfCheckboxProps(
              label: 'order_form.accept_the_terms'.tr(),
              labelWidth: 300,
              isChecked: true,
            ),
          ),
          pw.SizedBox(height: 8),
          getIt<PdfCheckboxWidgetInterface>(
            param1: PdfCheckboxProps(
              label: 'order_form.accept_the_dematerialization'.tr(),
              isChecked: true,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildQuoteAcceptTerms() {
    return getIt<PdfCheckboxWidgetInterface>(
      param1: PdfCheckboxProps(
        label: 'quote_form.accept_the_terms'.tr(),
        labelWidth: 300,
        isChecked: false,
      ),
    );
  }

  pw.Widget _buildSignatures() {
    List<pw.Widget> children = [];
    for (var i = 0; i < _orderFormDto.customerContacts.length; i++) {
      children.add(
        pw.Expanded(
          child: pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 6),
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(4),
              color: PdfColors.grey200,
            ),
            child: pw.Center(
              child: pw.Text(
                _orderFormDto.customerContacts.length > 1
                    ? 'order_form.co_contractor'.tr(
                        namedArgs: {'number': '${i + 1}'},
                      )
                    : 'order_form.contractor'.tr(),
                style: pw.TextStyle(fontSize: _defaultFontSize),
              ),
            ),
          ),
        ),
      );
      if (i != _orderFormDto.customerContacts.length - 1) {
        children.add(
          pw.SizedBox(width: 14),
        );
      }
    }
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'order_form.done_at'.tr(namedArgs: {
            'place': _orderFormDto.hasFairAccess && _orderFormDto.fairCity != ''
                ? _orderFormDto.fairCity
                : _orderFormDto.orderCity,
            'date': _orderFormDto.dateTimeString
          }),
          style: pw.TextStyle(fontSize: _defaultFontSize),
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          children: children,
        ),
        pw.SizedBox(height: 40),
      ],
    );
  }

  pw.Widget _buildQuoteSignatures() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'order_form.done_at'.tr(namedArgs: {
            'place': _orderFormDto.hasFairAccess && _orderFormDto.fairCity != ''
                ? _orderFormDto.fairCity
                : _orderFormDto.orderCity,
            'date': _orderFormDto.dateTimeString
          }),
          style: pw.TextStyle(fontSize: _defaultFontSize),
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    color: PdfColors.grey800,
                    height: 30,
                    padding: const pw.EdgeInsets.symmetric(vertical: 6),
                    child: pw.Center(
                      child: pw.Text(
                        textAlign: pw.TextAlign.center,
                        'quote_form.signature_before_acceptance'
                            .tr()
                            .toUpperCase(),
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Container(
                          height: 80,
                          margin: const pw.EdgeInsets.only(right: 3),
                          padding: const pw.EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.grey200,
                            borderRadius: pw.BorderRadius.circular(4),
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                'quote_form.company_signature'.tr(),
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                'quote_form.read_and_approved'.tr(),
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 4),
                      pw.Expanded(
                        child: pw.Container(
                          height: 80,
                          margin: const pw.EdgeInsets.only(right: 3),
                          padding: const pw.EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.grey200,
                            borderRadius: pw.BorderRadius.circular(4),
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                'quote_form.customer_signature'.tr(),
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                'quote_form.read_and_approved'.tr(),
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 8,
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
            pw.SizedBox(width: 14),
            pw.Column(
              children: [
                pw.Container(
                  color: PdfColors.grey800,
                  width: 200,
                  height: 30,
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Center(
                    child: pw.Text(
                      'quote_form.signature_after_acceptance'
                          .tr()
                          .toUpperCase(),
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Container(
                  width: 200,
                  height: 80,
                  margin: const pw.EdgeInsets.only(right: 3),
                  padding: const pw.EdgeInsets.symmetric(
                      vertical: 4, horizontal: 10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'quote_form.customer_signature'.tr(),
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        'quote_form.read_and_approved'.tr(),
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 40),
      ],
    );
  }

  pw.Widget _buildCancellationForm() {
    if (_orderFormDto.hasFairAccess) {
      return pw.Container();
    } else {
      return pw.Row(children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'order_form.cancellation_form.first_instruction'.tr(),
                  style: pw.TextStyle(fontSize: _defaultFontSize),
                ),
              ),
              pw.Row(
                children: [
                  pw.Icon(
                    const pw.IconData(0xf7c9),
                    size: 16,
                  ),
                  pw.Expanded(child: _buildSeparator(color: PdfColors.black)),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Container(
                color: PdfColors.grey800,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Center(
                    child: pw.Text(
                      _orderFormDto.isOrderForm
                          ? 'order_form.cancellation_form.title'.tr(namedArgs: {
                              'number': _orderFormDto.orderNumber
                            }).toUpperCase()
                          : 'quote_form.cancellation_form.title'.tr(),
                      style: const pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'order_form.cancellation_form.second_instruction'
                              .tr(),
                          style: pw.TextStyle(fontSize: _defaultFontSize),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Text(
                          'order_form.cancellation_form.for_the_attention_of'
                              .tr(),
                          style: pw.TextStyle(
                            fontSize: _defaultFontSize,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Container(
                          width: double.infinity,
                          padding: const pw.EdgeInsets.all(4),
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(4),
                            color: PdfColors.grey200,
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                _orderFormDto.agencyLabel,
                                style: pw.TextStyle(fontSize: _defaultFontSize),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                '${_orderFormDto.agencyAddress}, ${_orderFormDto.agencyPostalCode}, ${_orderFormDto.agencyCity}',
                                style: pw.TextStyle(fontSize: _defaultFontSize),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                _orderFormDto.agencyEmail,
                                style: pw.TextStyle(fontSize: _defaultFontSize),
                              ),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                'order_form.cancellation_form.siret_ape'.tr(
                                  namedArgs: {
                                    'siret': _orderFormDto.agencySiret,
                                    'ape': _orderFormDto.agencyNaf,
                                  },
                                ),
                                style: pw.TextStyle(fontSize: _defaultFontSize),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 12),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'order_form.cancellation_form.to_complete'.tr(),
                          style: pw.TextStyle(fontSize: _defaultFontSize),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'order_form.cancellation_form.signature'.tr(),
                          style: pw.TextStyle(fontSize: _defaultFontSize),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'order_form.cancellation_form.delete_as_appropriate'
                                  .tr(),
                              style: pw.TextStyle(
                                fontSize: 6,
                                fontStyle: pw.FontStyle.italic,
                              ),
                            ),
                            pw.SizedBox(width: 8),
                            pw.Expanded(
                              child: pw.Container(
                                height: 24,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(color: PdfColors.black),
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
            ],
          ),
        ),
      ]);
    }
  }

  pw.Widget _buildSeparator({PdfColor color = PdfColors.grey400}) {
    return pw.Container(
      height: .5,
      color: color,
    );
  }

  pw.Widget _buildHeaderCell(String headerName, {double? width}) {
    return pw.Container(
      width: width,
      height: 20,
      color: PdfColors.grey400,
      child: pw.Center(
        child: pw.Text(
          headerName,
          style: pw.TextStyle(fontSize: _defaultFontSize),
          textAlign: pw.TextAlign.center,
        ),
      ),
    );
  }

  pw.Widget _buildValueBox({
    required String label,
    required String value,
    PdfColor color = PdfColors.grey400,
    PdfColor valueColor = PdfColors.white,
    double fontSize = 10,
    double labelFontSize = 7,
  }) {
    return pw.Stack(
      overflow: pw.Overflow.visible,
      children: [
        pw.Container(
          width: 120,
          color: color,
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              fontSize: fontSize,
              color: valueColor,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Positioned.fill(
          left: -100,
          child: pw.Center(
            child: pw.Container(
              width: 34,
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              color: PdfColors.grey700,
              child: pw.Text(
                label,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: labelFontSize,
                  color: PdfColors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  pw.Widget _buildDateField(String label, String date) {
    return pw.Column(
      crossAxisAlignment: _orderFormDto.isOrderForm
          ? pw.CrossAxisAlignment.center
          : pw.CrossAxisAlignment.start,
      children: [
        pw.Text(label, style: pw.TextStyle(fontSize: _defaultFontSize)),
        pw.SizedBox(height: 2),
        pw.Container(
          color: PdfColors.grey200,
          width: _orderFormDto.isOrderForm ? null : 123,
          padding: const pw.EdgeInsets.symmetric(vertical: 8),
          child: pw.Center(
            child: pw.Text(
              date,
              style: pw.TextStyle(fontSize: _defaultFontSize),
            ),
          ),
        )
      ],
    );
  }
}
