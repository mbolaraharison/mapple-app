import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, SnapshotOptions, Timestamp;
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderRow extends AbstractBaseModel implements Insertable<OrderRow> {
  OrderRow({
    required super.id,
    required this.orderId,
    required this.agencyId,
    required this.serviceId,
    required this.designation,
    this.discount,
    this.option1Id,
    this.option2Id,
    required this.quantity,
    required this.grossPrice,
    required this.unit,
    required this.taxLevel,
    this.discountCodeId,
    this.priceListItemId,
    this.optionsHaveChanged = false,
    this.supplierId,
    this.withWorkforce = false,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String orderId;
  final String agencyId;
  final String serviceId;
  String designation;
  double? discount;
  String? option1Id;
  String? option2Id;
  double quantity;
  double grossPrice;
  String unit;
  TaxLevel taxLevel;
  final String? discountCodeId;
  String? priceListItemId;
  bool optionsHaveChanged;
  String? supplierId;
  bool withWorkforce;

  Service? service;
  ServiceOptionItem? option1;
  ServiceOptionItem? option2;
  PriceListItem? priceListItem;
  DiscountCode? discountCode;
  Supplier? supplier;

  // Getters:-------------------------------------------------------------------
  bool get isPackagePrice {
    PriceListItem? priceListItem = this.priceListItem;
    return priceListItem != null &&
        priceListItem.unit == PriceListItem.packageUnit;
  }

  double get grossPriceInclTax {
    return getIt<PriceCalculatorUtilsInterface>().calculatePriceInclTax(
      price: grossPrice,
      tax: taxLevel.value,
    );
  }

  double get totalGrossExclTax {
    PriceListItem? priceListItem = this.priceListItem;
    if (priceListItem != null &&
        priceListItem.unit == PriceListItem.packageUnit) {
      return grossPrice;
    }

    return getIt<PriceCalculatorUtilsInterface>().calculateTotalPrice(
      unitPrice: grossPrice,
      quantity: quantity,
    );
  }

  double get totalGrossInclTax {
    PriceListItem? priceListItem = this.priceListItem;
    if (priceListItem != null &&
        priceListItem.unit == PriceListItem.packageUnit) {
      return grossPriceInclTax;
    }
    double totalGrossExclTax = this.totalGrossExclTax;
    return getIt<PriceCalculatorUtilsInterface>().calculatePriceInclTax(
      price: totalGrossExclTax,
      tax: taxLevel.value,
    );
  }

  double get totalNetExclTax {
    if (discount == null) {
      return this.totalGrossExclTax;
    }
    double totalGrossExclTax = this.totalGrossExclTax;
    return getIt<PriceCalculatorUtilsInterface>().calculateDiscountedPrice(
      totalPrice: totalGrossExclTax,
      discount: discount!,
    );
  }

  double get grossTaxAmount {
    double totalGrossExclTax = this.totalGrossExclTax;
    return getIt<PriceCalculatorUtilsInterface>().calculateTaxAmount(
      price: totalGrossExclTax,
      tax: taxLevel.value,
    );
  }

  double get netTaxAmount {
    double totalNetExclTax = this.totalNetExclTax;
    return getIt<PriceCalculatorUtilsInterface>().calculateTaxAmount(
      price: totalNetExclTax,
      tax: taxLevel.value,
    );
  }

  double get totalNetInclTax {
    if (discount == null) {
      return totalGrossInclTax;
    }
    double totalNetExclTax = this.totalNetExclTax;
    return getIt<PriceCalculatorUtilsInterface>().calculatePriceInclTax(
      price: totalNetExclTax,
      tax: taxLevel.value,
    );
  }

  double get discountAmount {
    if (discount == null) {
      return 0;
    }
    double totalGrossInclTax = this.totalGrossInclTax;
    double totalNetInclTax = this.totalNetInclTax;
    return getIt<PriceCalculatorUtilsInterface>().calculateDiscountAmount(
      price: totalGrossInclTax,
      discountedPrice: totalNetInclTax,
    );
  }

  String get formattedGrossPrice {
    return getIt<NumberFormatterUtilsInterface>().formatToCurrency(grossPrice);
  }

  String get formattedGrossPriceInclTax {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(grossPriceInclTax);
  }

  String get formattedTotalGrossInclTax {
    double totalGrossInclTax = this.totalGrossInclTax;
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalGrossInclTax);
  }

  String get formattedTotalNetInclTax {
    if (discount == null) {
      return formattedTotalGrossInclTax;
    }
    double totalNetInclTax = this.totalNetInclTax;
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalNetInclTax);
  }

  String get formattedDiscount {
    if (discount == null) {
      return '';
    }

    if (discountCodeId != null) {
      return discountCode!.formattedDiscount;
    }

    return '${getIt<NumberFormatterUtilsInterface>().formatToDoubleWith2Decimals(discount!.toDouble())}%';
  }

  String get formattedTaxLevel {
    return getIt<NumberFormatterUtilsInterface>()
        .formatWithoutTrailingZeros(taxLevel.value);
  }

  String getUnit() {
    String computedUnit = unit;
    PriceListItem? priceListItem = this.priceListItem;

    if (priceListItem != null &&
        priceListItem.unit == PriceListItem.packageUnit) {
      computedUnit = 'FOR';
    }

    return computedUnit;
  }

  String getUnitLabel() {
    String computedUnit = getUnit();

    if (computedUnit == 'FOR') {
      return 'FOR'.tr();
    }

    return computedUnit;
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadService(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(OrderRow)) {
      flow.add(OrderRow);
    } else {
      return;
    }
    service = await getIt<ServiceServiceInterface>()
        .getById(serviceId, eager: eager, flow: flow);
  }

  Future<void> loadOption1({List<Type> flow = const []}) async {
    if (option1Id == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(OrderRow)) {
      flow.add(OrderRow);
    } else {
      return;
    }
    option1 =
        await getIt<ServiceOptionItemServiceInterface>().getById(option1Id!);
  }

  Future<void> loadOption2({List<Type> flow = const []}) async {
    if (option2Id == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(OrderRow)) {
      flow.add(OrderRow);
    } else {
      return;
    }
    option2 =
        await getIt<ServiceOptionItemServiceInterface>().getById(option2Id!);
  }

  Future<void> loadPriceListItem(
      {bool eager = false, List<Type> flow = const []}) async {
    if (priceListItemId == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(OrderRow)) {
      flow.add(OrderRow);
    } else {
      return;
    }
    priceListItem = await getIt<PriceListItemServiceInterface>()
        .getById(priceListItemId!, eager: eager, flow: flow);
  }

  Future<void> loadDiscountCode(
      {bool eager = false, List<Type> flow = const []}) async {
    if (discountCodeId == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(OrderRow)) {
      flow.add(OrderRow);
    } else {
      return;
    }
    discountCode = await getIt<DiscountCodeServiceInterface>()
        .getById(discountCodeId!, eager: eager, flow: flow);
  }

  Future<void> loadSupplier(
      {bool eager = false, List<Type> flow = const []}) async {
    if (supplierId == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(OrderRow)) {
      flow.add(OrderRow);
    } else {
      return;
    }
    supplier = await getIt<SupplierServiceInterface>()
        .getById(supplierId!, eager: eager, flow: flow);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadService(eager: eager, flow: flow);
    await loadOption1(flow: flow);
    await loadOption2(flow: flow);
    await loadPriceListItem(eager: eager, flow: flow);
    await loadDiscountCode(eager: eager, flow: flow);
    await loadDiscountCode(eager: eager, flow: flow);
    await loadSupplier(eager: eager, flow: flow);
  }

  bool canApplyDiscountCode(DiscountCode discountCode) {
    if (discountCode.isExpired) {
      return false;
    }
    final families = discountCode.families;
    if (families.isNotEmpty) {
      return families
              .firstWhereOrNull((e) => e.id == service!.subFamily!.familyId) !=
          null;
    }

    final subFamilies = discountCode.subFamilies;
    if (subFamilies.isNotEmpty) {
      return subFamilies
              .firstWhereOrNull((e) => e.id == service!.subFamilyId) !=
          null;
    }

    final services = discountCode.services;
    if (services.isNotEmpty) {
      return services.firstWhereOrNull((e) => e.id == serviceId) != null;
    }

    return true;
  }

  bool get isReadonly {
    return (service != null &&
            !service!.isMiscellanous &&
            priceListItemId == null) ||
        optionsHaveChanged == true;
  }

  void updateDiscount() {
    if (discountCodeId == null ||
        discountCode!.type == DiscountCodeType.percentage) {
      return;
    }
    discount = discountCode!.getDiscountPercentage(totalGrossInclTax);
  }

  // Base methods:--------------------------------------------------------------
  @override
  OrderRow copyWith({
    String? id,
    String? orderId,
    String? agencyId,
    String? serviceId,
    String? designation,
    ValueGetter<double?>? discount,
    ValueGetter<String?>? option1Id,
    ValueGetter<String?>? option2Id,
    double? quantity,
    double? grossPrice,
    String? unit,
    TaxLevel? taxLevel,
    ValueGetter<String?>? discountCodeId,
    ValueGetter<String?>? priceListItemId,
    bool? optionsHaveChanged,
    ValueGetter<String?>? supplierId,
    bool? withWorkforce,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderRow(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      agencyId: agencyId ?? this.agencyId,
      serviceId: serviceId ?? this.serviceId,
      designation: designation ?? this.designation,
      discount: discount != null ? discount() : this.discount,
      option1Id: option1Id != null ? option1Id() : this.option1Id,
      option2Id: option2Id != null ? option2Id() : this.option2Id,
      quantity: quantity ?? this.quantity,
      grossPrice: grossPrice ?? this.grossPrice,
      unit: unit ?? this.unit,
      taxLevel: taxLevel ?? this.taxLevel,
      discountCodeId:
          discountCodeId != null ? discountCodeId() : this.discountCodeId,
      priceListItemId:
          priceListItemId != null ? priceListItemId() : this.priceListItemId,
      optionsHaveChanged: optionsHaveChanged ?? this.optionsHaveChanged,
      supplierId: supplierId != null ? supplierId() : this.supplierId,
      withWorkforce: withWorkforce ?? this.withWorkforce,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory OrderRow.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OrderRow(
      id: snapshot.id,
      orderId: data?['orderId'],
      agencyId: data?['agencyId'],
      serviceId: data?['serviceId'],
      designation: data?['designation'],
      discount: data?['discount'] != null
          ? double.parse(data?['discount'].toString() ?? '0')
          : null,
      option1Id: data?['option1Id'],
      option2Id: data?['option2Id'],
      quantity: double.parse(data?['quantity'].toString() ?? '0'),
      grossPrice: getIt<NumberFormatterUtilsInterface>()
          .parseToDouble(data?['grossPrice']),
      unit: data?['unit'],
      taxLevel: TaxLevel.values.firstWhere(
        (e) => e.name == data?['taxLevel'],
      ),
      discountCodeId: data?['discountCodeId'],
      priceListItemId: data?['priceListItemId'],
      optionsHaveChanged: data?['optionsHaveChanged'] ?? false,
      supplierId: data?['supplierId'],
      withWorkforce: data?['withWorkforce'] ?? false,
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'agencyId': agencyId,
      'serviceId': serviceId,
      'designation': designation,
      'discount': discount,
      'option1Id': option1Id,
      'option2Id': option2Id,
      'quantity': quantity,
      'grossPrice': grossPrice,
      'unit': unit,
      'taxLevel': taxLevel.name,
      'discountCodeId': discountCodeId,
      'priceListItemId': priceListItemId,
      'optionsHaveChanged': optionsHaveChanged,
      'supplierId': supplierId,
      'withWorkforce': withWorkforce,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'order_id': Variable<String>(orderId),
      'agency_id': Variable<String>(agencyId),
      'service_id': Variable<String>(serviceId),
      'designation': Variable<String>(designation),
      'discount': Variable<double>(discount),
      'option1_id': Variable<String>(stringUtils.valueIfNotEmpty(option1Id)),
      'option2_id': Variable<String>(stringUtils.valueIfNotEmpty(option2Id)),
      'quantity': Variable<double>(quantity),
      'gross_price': Variable<double>(grossPrice),
      'unit': Variable<String>(unit),
      'tax_level': Variable<String>(taxLevel.name),
      'discount_code_id':
          Variable<String>(stringUtils.valueIfNotEmpty(discountCodeId)),
      'price_list_item_id':
          Variable<String>(stringUtils.valueIfNotEmpty(priceListItemId)),
      'options_have_changed': Variable<bool>(optionsHaveChanged),
      'supplier_id': Variable<String>(stringUtils.valueIfNotEmpty(supplierId)),
      'with_workforce': Variable<bool>(withWorkforce),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is OrderRow &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.orderId == orderId &&
        other.agencyId == agencyId &&
        other.serviceId == serviceId &&
        other.designation == designation &&
        other.discount == discount &&
        other.option1Id == option1Id &&
        other.option2Id == option2Id &&
        other.quantity == quantity &&
        other.grossPrice == grossPrice &&
        other.unit == unit &&
        other.taxLevel == taxLevel &&
        other.discountCodeId == discountCodeId &&
        other.priceListItemId == priceListItemId &&
        other.optionsHaveChanged == optionsHaveChanged &&
        other.supplierId == supplierId &&
        other.withWorkforce == withWorkforce &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
