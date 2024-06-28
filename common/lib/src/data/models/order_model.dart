import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

class Order extends AbstractBaseModel implements Insertable<Order> {
  Order({
    required super.id,
    required this.agencyId,
    required this.customerId,
    required this.fairId,
    this.representative1Id,
    this.representative2Id,
    this.representative3Id,
    required this.address1,
    this.address2,
    required this.addressCode,
    required this.city,
    required this.postalCode,
    this.amountHT = 0,
    this.amountTTC = 0,
    required this.orderFormId,
    required this.orderType,
    required this.origin,
    required this.originDetails,
    this.installAt,
    this.endProjectAt,
    required this.deferment,
    required this.signingMethod,
    required this.status,
    required this.cartStatus,
    this.signatureStep = 1,
    required this.apr,
    this.keepOldStuff = false,
    this.houseAge,
    this.isProPremise = false,
    // Payment
    this.paymentTerms =
        PaymentTerms.CB, // Set a default value for retrocompatibility
    this.cashPaymentMethod,
    this.financingPaymentMethod,
    this.intermediatePaymentPercentage,
    this.intermediatePaymentAmount,
    required this.creditAmount,
    required this.creditTotalCost,
    required this.depositAmount,
    required this.fundingStatus,
    required this.insuranceType,
    required this.monthlyPaymentAmount,
    required this.monthlyPaymentsCount,
    required this.nominalRate,
    this.isCashPayment = false,
    this.isFinancingPayment = false,
    // envelope for docusign
    this.envelopeId,
    required this.envelopeAlreadySigned,
    required this.envelopeRecipientIds,
    required this.envelopeSignedRecipientIds,
    this.envelopeSignedAt,
    this.shouldRecreateEnvelope = false,
    // contacts
    this.contacts = const [], // These are selected contacts
    this.location,
    this.locationAlreadyFetched = false,
    required this.syncStatus,
    // Files
    this.orderFormFileDataId,
    this.termsDocumentFileDataId,
    this.vatCertificateFileDataId,
    // Timestamps
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String agencyId;
  final String customerId;
  String? fairId;
  String? representative1Id;
  String? representative2Id;
  String? representative3Id;
  String address1;
  final String? address2;
  final String addressCode;
  String city;
  String postalCode;
  final double amountHT;
  final double amountTTC;
  String orderFormId;
  final OrderType orderType;
  Origin? origin;
  OriginDetails? originDetails;
  DateTime? installAt;
  DateTime? endProjectAt;
  Deferment deferment;
  final SigningMethod? signingMethod;
  OrderStatus status;
  CartStatus cartStatus; // not persisted in sage
  int signatureStep;
  double apr;
  bool keepOldStuff;
  int? houseAge;
  bool isProPremise;
  // Payment
  @Deprecated('Use cashPaymentMethod or financingPaymentMethod instead')
  PaymentTerms paymentTerms;
  CashPaymentMethod? cashPaymentMethod;
  FinancingPaymentMethod? financingPaymentMethod;
  int? intermediatePaymentPercentage;
  double? intermediatePaymentAmount;
  double creditAmount;
  double creditTotalCost;
  double depositAmount;
  final FundingStatus? fundingStatus;
  InsuranceType insuranceType;
  double monthlyPaymentAmount;
  int monthlyPaymentsCount;
  double nominalRate;
  bool? isCashPayment;
  bool? isFinancingPayment;
  // envelope for docusign
  String? envelopeId;
  bool envelopeAlreadySigned;
  List<String> envelopeRecipientIds;
  List<String> envelopeSignedRecipientIds;
  DateTime? envelopeSignedAt;
  bool shouldRecreateEnvelope;
  // contacts
  List<String> contacts;
  // location
  GeoPoint? location;
  bool locationAlreadyFetched;
  // Sync
  SyncStatus syncStatus;
  // Files
  String? orderFormFileDataId;
  String? termsDocumentFileDataId;
  String? vatCertificateFileDataId;

  List<Contact> contactsList = [];
  List<OrderRow> orderRows = [];
  Customer? customer;
  Fair? fair;
  Representative? representative1;
  Representative? representative2;
  Representative? representative3;
  FileData? orderFormFileData;
  FileData? termsDocumentFileData;
  FileData? vatCertificateFileData;

  // Getters:-------------------------------------------------------------------
  List<Color> get colors => status.colors;

  String get statusIcon => status.icon;

  String get address {
    if (address1.isNotEmpty) {
      return address1;
    }
    return address2 ?? '';
  }

  String get formattedAddress => '$address, $postalCode, $city';

  double get totalNetInclTax {
    double total = 0;

    for (final OrderRow row in orderRows) {
      double rowTotal = row.totalNetInclTax;
      total += rowTotal;
    }
    return total;
  }

  double get totalWithDeposit {
    return totalNetInclTax - depositAmount;
  }

  double get cleaningRelatedTotal {
    double cleaningTotal = 0;
    List<OrderRow> cleaningRows = orderRows.where((element) {
      return element.service!.isCleaning;
    }).toList();

    for (final OrderRow row in cleaningRows) {
      double rowTotalNetInclTax = row.totalNetInclTax;
      cleaningTotal += rowTotalNetInclTax;
    }
    return cleaningTotal;
  }

  double get depositPercentage {
    return (depositAmount / totalNetInclTax) * 100;
  }

  double get cleaningRelatedTotalWithDeposit {
    return cleaningRelatedTotal * (1 - (depositPercentage / 100));
  }

  List<Representative> get representatives {
    List<Representative> reps = [];
    if (representative1 != null) {
      reps.add(representative1!);
    }
    if (representative2 != null) {
      reps.add(representative2!);
    }
    if (representative3 != null) {
      reps.add(representative3!);
    }
    return reps;
  }

  String get representivesFullnames {
    return representatives.map((r) => r.fullName).join(', ');
  }

  String get formattedTotalNetInclTax {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalNetInclTax);
  }

  double get totalGrossExclTax {
    double total = 0;

    for (final OrderRow row in orderRows) {
      total += row.totalGrossExclTax;
    }
    return total;
  }

  double get totalGrossInclTax {
    double total = 0;

    for (final OrderRow row in orderRows) {
      total += row.totalGrossInclTax;
    }
    return total;
  }

  double get totalDiscount {
    double totalDiscount = 0;

    for (final OrderRow row in orderRows) {
      totalDiscount += row.discountAmount;
    }

    return totalDiscount;
  }

  bool get isEnergyRelated {
    for (final OrderRow row in orderRows) {
      ServiceSubFamily serviceSubFamily = row.service!.subFamily!;
      ServiceFamily serviceFamily = serviceSubFamily.family!;
      if (serviceFamily.isEnergyRelated) {
        return true;
      }
    }
    return false;
  }

  bool get isCleaningRelated {
    for (final OrderRow row in orderRows) {
      Service service = row.service!;
      if (service.isCleaning) {
        return true;
      }
    }
    return false;
  }

  String get originWithDetails {
    if (originDetails != null) {
      return '${origin!.label} - ${originDetails!.label}';
    }
    return origin != null ? origin!.label : '';
  }

  bool get envelopePartiallySigned {
    return envelopeRecipientIds.isNotEmpty &&
        envelopeSignedRecipientIds.isNotEmpty &&
        envelopeRecipientIds.length != envelopeSignedRecipientIds.length;
  }

  void setIntermediatePaymentPercentage() {
    intermediatePaymentPercentage = isCleaningRelated ? 40 : 0;
  }

  int get computedEndOfWorkPaymentPercentage {
    return 100 - (intermediatePaymentPercentage ?? 0);
  }

  double get computedIntermediatePaymentAmount {
    if (isCleaningRelated == true) {
      return cleaningRelatedTotalWithDeposit *
          ((intermediatePaymentPercentage ?? 0) / 100);
    } else {
      return totalWithDeposit * ((intermediatePaymentPercentage ?? 0) / 100);
    }
  }

  double get endOfWorkPaymentAmount {
    // Retrocompatibility
    if (isCashPayment == null || isFinancingPayment == null) {
      return totalWithDeposit - (intermediatePaymentAmount ?? 0);
    }

    // If not cash payment => end of works payment amount is 0
    if (isCashPayment == false) {
      return 0;
    }

    // If cash payment only => end of works payment amount is total with deposit - intermediate payment amount
    if (isCashPayment! && isFinancingPayment == false) {
      return totalWithDeposit - (intermediatePaymentAmount ?? 0);
    }

    // If cash payment and financing payment => end of works payment amount is total with deposit - intermediate payment amount - credit amount
    return totalWithDeposit - (intermediatePaymentAmount ?? 0) - creditAmount;
  }

  String get formattedTotalGrossExclTax {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalGrossExclTax);
  }

  String get formattedTotalGrossInclTax {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalGrossInclTax);
  }

  String get formattedDepositAmount {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(depositAmount);
  }

  String get formattedTotalDiscount {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalDiscount);
  }

  String get formattedIntermediatePaymentAmount {
    if (intermediatePaymentAmount == null) {
      return '';
    }
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(intermediatePaymentAmount!);
  }

  String get formattedEndOfWorkPaymentAmount {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(endOfWorkPaymentAmount);
  }

  String get formattedCreditAmount =>
      getIt<NumberFormatterUtilsInterface>().formatToCurrency(creditAmount);

  String get formattedCreditTotalCost =>
      getIt<NumberFormatterUtilsInterface>().formatToCurrency(creditTotalCost);

  String get formattedMonthlyPaymentAmount =>
      getIt<NumberFormatterUtilsInterface>()
          .formatToCurrency(monthlyPaymentAmount);

  bool get isReadonly => status != OrderStatus.Z;

  // Methods:-------------------------------------------------------------------
  Future<void> loadContacts(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Order)) {
      flow.add(Order);
    } else {
      return;
    }
    contactsList = await getIt<ContactServiceInterface>()
        .getByOrderId(id, eager: eager, flow: flow);
    contacts = contactsList.map((e) => e.id).toList();
  }

  Future<void> loadOrderRows(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Order)) {
      flow.add(Order);
    } else {
      return;
    }
    orderRows = await getIt<OrderRowServiceInterface>()
        .getByOrderId(id, eager: eager, flow: flow);
  }

  Future<void> loadCustomer(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Order)) {
      flow.add(Order);
    } else {
      return;
    }
    customer = await getIt<CustomerServiceInterface>()
        .getById(customerId, eager: eager, flow: flow);
  }

  Future<void> loadFair() async {
    if (fairId == null) {
      return;
    }
    fair = await getIt<FairServiceInterface>().getById(fairId!);
  }

  Future<void> loadRepresentative1(
      {bool eager = false, List<Type> flow = const []}) async {
    if (representative1Id == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Order)) {
      flow.add(Order);
    } else {
      return;
    }
    representative1 = await getIt<RepresentativeServiceInterface>()
        .getById(representative1Id!, eager: eager);
  }

  Future<void> loadRepresentative2(
      {bool eager = false, List<Type> flow = const []}) async {
    if (representative2Id == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Order)) {
      flow.add(Order);
    } else {
      return;
    }
    representative2 = await getIt<RepresentativeServiceInterface>()
        .getById(representative2Id!, eager: eager);
  }

  Future<void> loadRepresentative3(
      {bool eager = false, List<Type> flow = const []}) async {
    if (representative3Id == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Order)) {
      flow.add(Order);
    } else {
      return;
    }
    representative3 = await getIt<RepresentativeServiceInterface>()
        .getById(representative3Id!, eager: eager);
  }

  Future<void> loadOrderFormFileData() async {
    if (orderFormFileDataId == null) {
      return;
    }
    orderFormFileData =
        await getIt<FileDataServiceInterface>().getById(orderFormFileDataId!);
  }

  Future<void> loadTermsDocumentFileData() async {
    if (termsDocumentFileDataId == null) {
      return;
    }
    termsDocumentFileData = await getIt<FileDataServiceInterface>()
        .getById(termsDocumentFileDataId!);
  }

  Future<void> loadVatCertificateFileData() async {
    if (vatCertificateFileDataId == null) {
      return;
    }
    vatCertificateFileData = await getIt<FileDataServiceInterface>()
        .getById(vatCertificateFileDataId!);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadContacts(eager: eager, flow: flow);
    await loadOrderRows(eager: eager, flow: flow);
    await loadCustomer(eager: eager, flow: flow);
    await loadFair();
    await loadRepresentative1(eager: eager, flow: flow);
    await loadRepresentative2(eager: eager, flow: flow);
    await loadRepresentative3(eager: eager, flow: flow);
    await loadOrderFormFileData();
    await loadTermsDocumentFileData();
    await loadVatCertificateFileData();
  }

  List<String?> getTotalsForTaxLevel(TaxLevel taxLevel) {
    double totalNetExclTax = 0;
    double taxAmount = 0;
    double totalNetInclTax = 0;

    for (var element in orderRows) {
      if (element.taxLevel != taxLevel) {
        continue;
      }
      totalNetExclTax += element.totalNetExclTax;
      taxAmount += element.netTaxAmount;
      totalNetInclTax += element.totalNetInclTax;
    }

    if (totalNetInclTax == 0) {
      return [null, null, null];
    }

    return [
      getIt<NumberFormatterUtilsInterface>().formatToCurrency(totalNetExclTax),
      getIt<NumberFormatterUtilsInterface>().formatToCurrency(taxAmount),
      getIt<NumberFormatterUtilsInterface>().formatToCurrency(totalNetInclTax),
    ];
  }

  void setShouldRecreateEnvelope(bool value) {
    shouldRecreateEnvelope = value;
    if (shouldRecreateEnvelope && !envelopeAlreadySigned) {
      if (signatureStep == 4) {
        signatureStep = 3;
      }
      // reset envelope
      envelopeRecipientIds = [];
      envelopeSignedRecipientIds = [];
    }
  }

  String defineTermsFileName(Representative representative) {
    String termsFileName = '';
    // if representative is in direct sale mode
    if (representative.isDirectSale) {
      if (isEnergyRelated) {
        termsFileName = 'Terms_Direct_Sale_Energy.md';
      } else {
        termsFileName = 'Terms_Direct_Sale.md';
      }
    } else {
      if (representative.canAccessFair) {
        if (isEnergyRelated) {
          termsFileName = 'Terms_Fair_Energy.md';
        } else {
          termsFileName = 'Terms_Fair.md';
        }
      }
    }
    return termsFileName;
  }

  Future<String> getTerms(Representative representative) async {
    FileDataServiceInterface fileDataService =
        getIt<FileDataServiceInterface>();
    String termsFileName = defineTermsFileName(representative);
    // get terms
    String terms = '';
    FileData? fileData = await fileDataService.getByUniqueName(termsFileName);
    if (fileData != null) {
      File? termsFile = await fileDataService
          .getFileFromFileSystem(fileData.uniqueName, withDownload: true);
      if (termsFile != null) {
        terms = await termsFile.readAsString();
      }
    }
    return terms;
  }

  // Base methods:--------------------------------------------------------------
  factory Order.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Order(
      id: snapshot.id,
      agencyId: data?['agencyId'],
      customerId: data?['customerId'],
      fairId: data?['fairId'],
      representative1Id: data?['representative1Id'],
      representative2Id: data?['representative2Id'],
      representative3Id: data?['representative3Id'],
      address1: data?['address1'],
      address2: data?['address2'],
      addressCode: data?['addressCode'],
      city: data?['city'],
      postalCode: data?['postalCode'],
      amountHT: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['amountHT']),
      amountTTC: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['amountTTC']),
      intermediatePaymentPercentage: data?['intermediatePaymentPercentage'],
      creditAmount: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['creditAmount']),
      creditTotalCost: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['creditTotalCost']),
      depositAmount: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['depositAmount']),
      fundingStatus: data?['fundingStatus'] != null
          ? FundingStatus.values.firstWhere(
              (e) => e.name == data?['fundingStatus'],
            )
          : null,
      insuranceType: InsuranceType.fromValue(data?['insuranceType']),
      monthlyPaymentAmount: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['monthlyPaymentAmount']),
      monthlyPaymentsCount: data?['monthlyPaymentsCount'],
      nominalRate: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['nominalRate']),
      orderFormId: data?['orderFormId'],
      orderType: OrderType.values.firstWhere(
        (e) => e.name == data?['orderType'],
      ),
      origin: data?['origin'] != null
          ? Origin.values.firstWhere(
              (e) => e.name == data?['origin'],
            )
          : null,
      originDetails: data?['originDetails'] != null
          ? OriginDetails.values.firstWhere(
              (e) => e.name == data?['originDetails'],
            )
          : null,
      paymentTerms: PaymentTerms.values.firstWhere(
        (e) => e.name == data?['paymentTerms'],
      ),
      // Convert to local date without applying timezone offset
      installAt: data?['installAt'] != null
          ? DateTime(
              data!['installAt'].toDate().toUtc().year,
              data['installAt'].toDate().toUtc().month,
              data['installAt'].toDate().toUtc().day)
          : null,
      endProjectAt: data?['endProjectAt'] != null
          ? DateTime(
              data!['endProjectAt'].toDate().toUtc().year,
              data['endProjectAt'].toDate().toUtc().month,
              data['endProjectAt'].toDate().toUtc().day)
          : null,
      deferment: Deferment.fromValue(data?['deferment']),
      signingMethod: data?['signingMethod'] != null
          ? SigningMethod.values.firstWhere(
              (e) => e.name == data?['signingMethod'],
            )
          : null,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == data?['status'],
      ),
      cartStatus: CartStatus.values.firstWhere(
        (e) => e.name == data?['cartStatus'],
      ),
      signatureStep: data?['signatureStep'] ?? 1,
      apr: getIt<NumberFormatterUtilsInterface>().parseToDouble(data?['apr']),
      intermediatePaymentAmount: getIt<NumberFormatterUtilsInterface>()
          .parseToDoubleOrNull(data?['intermediatePaymentAmount']),
      keepOldStuff: data?['keepOldStuff'] ?? false,
      houseAge: data?['houseAge'],
      isProPremise: data?['isProPremise'] ?? false,
      envelopeId: data?['envelopeId'],
      envelopeAlreadySigned: data?['envelopeAlreadySigned'],
      envelopeRecipientIds: List<String>.from(data?['envelopeRecipientIds']),
      envelopeSignedRecipientIds:
          List<String>.from(data?['envelopeSignedRecipientIds']),
      envelopeSignedAt: data?['envelopeSignedAt']?.toDate(),
      shouldRecreateEnvelope: data?['shouldRecreateEnvelope'] ?? false,
      contacts: List<String>.from(data?['contacts']),
      location: data?['location'] as GeoPoint?,
      locationAlreadyFetched: data?['locationAlreadyFetched'] ?? false,
      syncStatus: SyncStatus.values.firstWhere(
        (e) => e.name == data?['syncStatus'],
      ),
      orderFormFileDataId: data?['orderFormFileDataId'],
      termsDocumentFileDataId: data?['termsDocumentFileDataId'],
      vatCertificateFileDataId: data?['vatCertificateFileDataId'],
      isCashPayment: data?['isCashPayment'],
      isFinancingPayment: data?['isFinancingPayment'],
      cashPaymentMethod:
          CashPaymentMethod.fromValue(data?['cashPaymentMethod']),
      financingPaymentMethod:
          FinancingPaymentMethod.fromValue(data?['financingPaymentMethod']),
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'agencyId': agencyId,
      'customerId': customerId,
      'fairId': fairId,
      'representative1Id': representative1Id,
      'representative2Id': representative2Id,
      'representative3Id': representative3Id,
      'address1': address1,
      'address2': address2,
      'addressCode': addressCode,
      'city': city,
      'postalCode': postalCode,
      'amountHT': amountHT,
      'amountTTC': amountTTC,
      'intermediatePaymentPercentage': intermediatePaymentPercentage,
      'creditAmount': creditAmount,
      'creditTotalCost': creditTotalCost,
      'depositAmount': depositAmount,
      'fundingStatus': fundingStatus?.name,
      'insuranceType': insuranceType.value,
      'monthlyPaymentAmount': monthlyPaymentAmount,
      'monthlyPaymentsCount': monthlyPaymentsCount,
      'nominalRate': nominalRate,
      'orderFormId': orderFormId,
      'orderType': orderType.name,
      'origin': origin?.name,
      'originDetails': originDetails?.name,
      'paymentTerms': paymentTerms.name,
      // Convert to utc date without applying timezone offset
      'installAt': installAt != null
          ? DateTime.utc(installAt!.year, installAt!.month, installAt!.day)
          : null,
      'endProjectAt': endProjectAt != null
          ? DateTime.utc(
              endProjectAt!.year, endProjectAt!.month, endProjectAt!.day)
          : null,
      'deferment': deferment.value,
      'signingMethod': signingMethod?.name,
      'status': status.name,
      'cartStatus': cartStatus.name,
      'signatureStep': signatureStep,
      'apr': apr,
      'intermediatePaymentAmount': intermediatePaymentAmount,
      'keepOldStuff': keepOldStuff,
      'houseAge': houseAge,
      'isProPremise': isProPremise,
      'envelopeId': envelopeId,
      'envelopeAlreadySigned': envelopeAlreadySigned,
      'envelopeRecipientIds': envelopeRecipientIds,
      'envelopeSignedRecipientIds': envelopeSignedRecipientIds,
      'envelopeSignedAt': envelopeSignedAt,
      'shouldRecreateEnvelope': shouldRecreateEnvelope,
      'contacts': contacts,
      'location': location,
      'locationAlreadyFetched': locationAlreadyFetched,
      'syncStatus': syncStatus.name,
      'orderFormFileDataId': orderFormFileDataId,
      'termsDocumentFileDataId': termsDocumentFileDataId,
      'vatCertificateFileDataId': vatCertificateFileDataId,
      'isCashPayment': isCashPayment,
      'isFinancingPayment': isFinancingPayment,
      'cashPaymentMethod': cashPaymentMethod?.name,
      'financingPaymentMethod': financingPaymentMethod?.name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Order copyWith({
    String? id,
    String? agencyId,
    String? customerId,
    String? fairId,
    String? representative1Id,
    String? representative2Id,
    String? representative3Id,
    String? address1,
    String? address2,
    String? addressCode,
    String? city,
    String? postalCode,
    double? amountHT,
    double? amountTTC,
    int? intermediatePaymentPercentage,
    double? creditAmount,
    double? creditTotalCost,
    double? depositAmount,
    FundingStatus? fundingStatus,
    InsuranceType? insuranceType,
    double? monthlyPaymentAmount,
    int? monthlyPaymentsCount,
    double? nominalRate,
    String? orderFormId,
    OrderType? orderType,
    Origin? origin,
    OriginDetails? originDetails,
    PaymentTerms? paymentTerms,
    DateTime? installAt,
    DateTime? endProjectAt,
    Deferment? deferment,
    SigningMethod? signingMethod,
    OrderStatus? status,
    CartStatus? cartStatus,
    int? signatureStep,
    double? apr,
    double? intermediatePaymentAmount,
    bool? keepOldStuff,
    int? houseAge,
    bool? isProPremise,
    String? envelopeId,
    bool? envelopeAlreadySigned,
    List<String>? envelopeRecipientIds,
    List<String>? envelopeSignedRecipientIds,
    DateTime? envelopeSignedAt,
    bool? shouldRecreateEnvelope,
    List<String>? contacts,
    SyncStatus? syncStatus,
    String? orderFormFileDataId,
    String? termsDocumentFileDataId,
    String? vatCertificateFileDataId,
    GeoPoint? location,
    bool? locationAlreadyFetched,
    bool? isCashPayment,
    bool? isFinancingPayment,
    CashPaymentMethod? cashPaymentMethod,
    FinancingPaymentMethod? financingPaymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      agencyId: agencyId ?? this.agencyId,
      customerId: customerId ?? this.customerId,
      fairId: fairId ?? this.fairId,
      representative1Id: representative1Id ?? this.representative1Id,
      representative2Id: representative2Id ?? this.representative2Id,
      representative3Id: representative3Id ?? this.representative3Id,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      addressCode: addressCode ?? this.addressCode,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      amountHT: amountHT ?? this.amountHT,
      amountTTC: amountTTC ?? this.amountTTC,
      intermediatePaymentPercentage:
          intermediatePaymentPercentage ?? this.intermediatePaymentPercentage,
      creditAmount: creditAmount ?? this.creditAmount,
      creditTotalCost: creditTotalCost ?? this.creditTotalCost,
      depositAmount: depositAmount ?? this.depositAmount,
      fundingStatus: fundingStatus ?? this.fundingStatus,
      insuranceType: insuranceType ?? this.insuranceType,
      monthlyPaymentAmount: monthlyPaymentAmount ?? this.monthlyPaymentAmount,
      monthlyPaymentsCount: monthlyPaymentsCount ?? this.monthlyPaymentsCount,
      nominalRate: nominalRate ?? this.nominalRate,
      orderFormId: orderFormId ?? this.orderFormId,
      orderType: orderType ?? this.orderType,
      origin: origin ?? this.origin,
      originDetails: originDetails ?? this.originDetails,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      installAt: installAt ?? this.installAt,
      endProjectAt: endProjectAt ?? this.endProjectAt,
      deferment: deferment ?? this.deferment,
      signingMethod: signingMethod ?? this.signingMethod,
      status: status ?? this.status,
      cartStatus: cartStatus ?? this.cartStatus,
      signatureStep: signatureStep ?? this.signatureStep,
      keepOldStuff: keepOldStuff ?? this.keepOldStuff,
      houseAge: houseAge ?? this.houseAge,
      isProPremise: isProPremise ?? this.isProPremise,
      apr: apr ?? this.apr,
      intermediatePaymentAmount:
          intermediatePaymentAmount ?? this.intermediatePaymentAmount,
      envelopeId: envelopeId ?? this.envelopeId,
      envelopeAlreadySigned:
          envelopeAlreadySigned ?? this.envelopeAlreadySigned,
      envelopeRecipientIds: envelopeRecipientIds ?? this.envelopeRecipientIds,
      envelopeSignedRecipientIds:
          envelopeSignedRecipientIds ?? this.envelopeSignedRecipientIds,
      envelopeSignedAt: envelopeSignedAt ?? this.envelopeSignedAt,
      shouldRecreateEnvelope:
          shouldRecreateEnvelope ?? this.shouldRecreateEnvelope,
      contacts: contacts ?? this.contacts,
      syncStatus: syncStatus ?? this.syncStatus,
      orderFormFileDataId: orderFormFileDataId ?? this.orderFormFileDataId,
      termsDocumentFileDataId:
          termsDocumentFileDataId ?? this.termsDocumentFileDataId,
      vatCertificateFileDataId:
          vatCertificateFileDataId ?? this.vatCertificateFileDataId,
      location: location ?? this.location,
      locationAlreadyFetched:
          locationAlreadyFetched ?? this.locationAlreadyFetched,
      isCashPayment: isCashPayment ?? this.isCashPayment,
      isFinancingPayment: isFinancingPayment ?? this.isFinancingPayment,
      cashPaymentMethod: cashPaymentMethod ?? this.cashPaymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'Order{id: $id, agencyId: $agencyId, customerId: $customerId, fairId: $fairId, representative1Id: $representative1Id, representative2Id: $representative2Id, representative3Id: $representative3Id, address1: $address1, address2: $address2, addressCode: $addressCode, city: $city, postalCode: $postalCode, amountHT: $amountHT, amountTTC: $amountTTC, intermediatePaymentPercentage: $intermediatePaymentPercentage, creditAmount: $creditAmount, creditTotalCost: $creditTotalCost, depositAmount: $depositAmount, fundingStatus: $fundingStatus, insuranceType: $insuranceType, monthlyPaymentAmount: $monthlyPaymentAmount, monthlyPaymentsCount: $monthlyPaymentsCount, nominalRate: $nominalRate, orderFormId: $orderFormId, orderType: $orderType, origin: $origin, originDetails: $originDetails, paymentTerms: $paymentTerms, installAt: $installAt, endProjectAt: $endProjectAt, deferment: $deferment, signingMethod: $signingMethod, status: $status, cartStatus: $cartStatus, signatureStep: $signatureStep, keepOldStuff: $keepOldStuff, houseAge: $houseAge, isProPremise: $isProPremise, apr: $apr, intermediatePaymentAmount: $intermediatePaymentAmount, envelopeId: $envelopeId, envelopeAlreadySigned: $envelopeAlreadySigned, envelopeRecipientIds: $envelopeRecipientIds, envelopeSignedRecipientIds: $envelopeSignedRecipientIds, envelopeSignedAt: $envelopeSignedAt, shouldRecreateEnvelope: $shouldRecreateEnvelope, contacts: $contacts, syncStatus: $syncStatus, orderFormFileDataId: $orderFormFileDataId, termsDocumentFileDataId: $termsDocumentFileDataId, vatCertificateFileDataId: $vatCertificateFileDataId, location: $location, locationAlreadyFetched: $locationAlreadyFetched, isCashPayment: $isCashPayment, isFinancingPayment: $isFinancingPayment, cashPaymentMethod: $cashPaymentMethod, createdAt: $createdAt, updatedAt: $updatedAt}';

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    ListStringConverter listStringConverter = const ListStringConverter();
    GeoPointConverter geoPointConverter = const GeoPointConverter();
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'agency_id': Variable<String>(agencyId),
      'customer_id': Variable<String>(customerId),
      'fair_id': Variable<String>(stringUtils.valueIfNotEmpty(fairId)),
      'representative1_id':
          Variable<String>(stringUtils.valueIfNotEmpty(representative1Id)),
      'representative2_id':
          Variable<String>(stringUtils.valueIfNotEmpty(representative2Id)),
      'representative3_id':
          Variable<String>(stringUtils.valueIfNotEmpty(representative3Id)),
      'address1': Variable<String>(address1),
      'address2': Variable<String>(address2),
      'address_code': Variable<String>(addressCode),
      'city': Variable<String>(city),
      'postal_code': Variable<String>(postalCode),
      'amount_h_t': Variable<double>(amountHT),
      'amount_t_t_c': Variable<double>(amountTTC),
      'intermediate_payment_percentage':
          Variable<int>(intermediatePaymentPercentage),
      'credit_amount': Variable<double>(creditAmount),
      'credit_total_cost': Variable<double>(creditTotalCost),
      'deposit_amount': Variable<double>(depositAmount),
      'funding_status': Variable<String>(fundingStatus?.name),
      'insurance_type': Variable<String>(insuranceType.name),
      'monthly_payment_amount': Variable<double>(monthlyPaymentAmount),
      'monthly_payments_count': Variable<int>(monthlyPaymentsCount),
      'nominal_rate': Variable<double>(nominalRate),
      'order_form_id': Variable<String>(orderFormId),
      'order_type': Variable<String>(orderType.name),
      'origin': Variable<String>(origin?.name),
      'origin_details': Variable<String>(originDetails?.name),
      'payment_terms': Variable<String>(paymentTerms.name),
      'install_at': Variable<DateTime>(installAt),
      'end_project_at': Variable<DateTime>(endProjectAt),
      'deferment': Variable<String>(deferment.name),
      'signing_method': Variable<String>(signingMethod?.name),
      'status': Variable<String>(status.name),
      'cart_status': Variable<String>(cartStatus.name),
      'signature_step': Variable<int>(signatureStep),
      'apr': Variable<double>(apr),
      'intermediate_payment_amount':
          Variable<double>(intermediatePaymentAmount),
      'keep_old_stuff': Variable<bool>(keepOldStuff),
      'house_age': Variable<int>(houseAge),
      'is_pro_premise': Variable<bool>(isProPremise),
      'envelope_id': Variable<String>(envelopeId),
      'envelope_already_signed': Variable<bool>(envelopeAlreadySigned),
      'envelope_recipient_ids':
          Variable<String>(listStringConverter.toSql(envelopeRecipientIds)),
      'envelope_signed_recipient_ids': Variable<String>(
          listStringConverter.toSql(envelopeSignedRecipientIds)),
      'envelope_signed_at': Variable<DateTime>(envelopeSignedAt),
      'should_recreate_envelope': Variable<bool>(shouldRecreateEnvelope),
      'location': Variable<String>(
          location != null ? geoPointConverter.toSql(location!) : null),
      'location_already_fetched': Variable<bool>(locationAlreadyFetched),
      'sync_status': Variable<String>(syncStatus.name),
      'order_form_file_data_id':
          Variable<String>(stringUtils.valueIfNotEmpty(orderFormFileDataId)),
      'terms_document_file_data_id': Variable<String>(
          stringUtils.valueIfNotEmpty(termsDocumentFileDataId)),
      'vat_certificate_file_data_id': Variable<String>(
          stringUtils.valueIfNotEmpty(vatCertificateFileDataId)),
      'is_cash_payment': Variable<bool>(isCashPayment),
      'is_financing_payment': Variable<bool>(isFinancingPayment),
      'cash_payment_method': Variable<String>(cashPaymentMethod?.name),
      'financing_payment_method':
          Variable<String>(financingPaymentMethod?.name),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.agencyId == agencyId &&
        other.customerId == customerId &&
        other.fairId == fairId &&
        other.representative1Id == representative1Id &&
        other.representative2Id == representative2Id &&
        other.representative3Id == representative3Id &&
        other.address1 == address1 &&
        other.address2 == address2 &&
        other.addressCode == addressCode &&
        other.city == city &&
        other.postalCode == postalCode &&
        other.amountHT == amountHT &&
        other.amountTTC == amountTTC &&
        other.orderFormId == orderFormId &&
        other.orderType == orderType &&
        other.origin == origin &&
        other.originDetails == originDetails &&
        other.installAt == installAt &&
        other.endProjectAt == endProjectAt &&
        other.deferment == deferment &&
        other.signingMethod == signingMethod &&
        other.status == status &&
        other.cartStatus == cartStatus &&
        other.signatureStep == signatureStep &&
        other.apr == apr &&
        other.keepOldStuff == keepOldStuff &&
        other.houseAge == houseAge &&
        other.isProPremise == isProPremise &&
        other.paymentTerms == paymentTerms &&
        other.cashPaymentMethod == cashPaymentMethod &&
        other.financingPaymentMethod == financingPaymentMethod &&
        other.intermediatePaymentPercentage == intermediatePaymentPercentage &&
        other.intermediatePaymentAmount == intermediatePaymentAmount &&
        other.creditAmount == creditAmount &&
        other.creditTotalCost == creditTotalCost &&
        other.depositAmount == depositAmount &&
        other.fundingStatus == fundingStatus &&
        other.insuranceType == insuranceType &&
        other.monthlyPaymentAmount == monthlyPaymentAmount &&
        other.monthlyPaymentsCount == monthlyPaymentsCount &&
        other.nominalRate == nominalRate &&
        other.isCashPayment == isCashPayment &&
        other.isFinancingPayment == isFinancingPayment &&
        other.envelopeId == envelopeId &&
        other.envelopeAlreadySigned == envelopeAlreadySigned &&
        other.envelopeRecipientIds.equals(envelopeRecipientIds) &&
        other.envelopeSignedRecipientIds.equals(envelopeSignedRecipientIds) &&
        other.envelopeSignedAt == envelopeSignedAt &&
        other.shouldRecreateEnvelope == shouldRecreateEnvelope &&
        other.contacts.equals(contacts) &&
        other.location == location &&
        other.locationAlreadyFetched == locationAlreadyFetched &&
        other.syncStatus == syncStatus &&
        other.orderFormFileDataId == orderFormFileDataId &&
        other.termsDocumentFileDataId == termsDocumentFileDataId &&
        other.vatCertificateFileDataId == vatCertificateFileDataId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
