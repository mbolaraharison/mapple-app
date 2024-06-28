import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';

class PriceListItem extends AbstractBaseModel
    implements Insertable<PriceListItem> {
  PriceListItem({
    required super.id,
    required this.priceListId,
    required this.agencyId,
    required this.option1Id,
    required this.option2Id,
    required this.minQuantity,
    required this.maxQuantity,
    required this.price,
    required this.unit,
    super.createdAt,
    super.updatedAt,
  });

  // Static :-------------------------------------------------------------------
  static const String packageUnit = 'FOR';

  // Variables:-----------------------------------------------------------------
  final String priceListId;
  final String? agencyId;
  final String? option1Id;
  final String? option2Id;
  final double minQuantity;
  final double maxQuantity;
  final double price;
  final String unit;

  PriceList? priceList;
  ServiceOptionItem? option1;
  ServiceOptionItem? option2;

  // Getters:-------------------------------------------------------------------
  String get formattedPrice =>
      getIt<NumberFormatterUtilsInterface>().formatToCurrency(price);

  // Methods:-------------------------------------------------------------------
  Future<void> loadPriceList(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(PriceListItem)) {
      flow.add(PriceListItem);
    } else {
      return;
    }
    priceList = await getIt<PriceListServiceInterface>()
        .getById(priceListId, eager: eager, flow: flow);
  }

  Future<void> loadOption1({List<Type> flow = const []}) async {
    if (option1Id == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(PriceListItem)) {
      flow.add(PriceListItem);
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
    if (!flow.contains(PriceListItem)) {
      flow.add(PriceListItem);
    } else {
      return;
    }
    option2 =
        await getIt<ServiceOptionItemServiceInterface>().getById(option2Id!);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadPriceList(eager: eager, flow: flow);
    await loadOption1(flow: flow);
    await loadOption2(flow: flow);
  }

  // Base methods:--------------------------------------------------------------
  factory PriceListItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PriceListItem(
      id: snapshot.id,
      priceListId: data?['priceListId'] as String,
      agencyId: data?['agencyId'] as String?,
      option1Id: data?['option1Id'] as String?,
      option2Id: data?['option2Id'] as String?,
      minQuantity: double.parse(data?['minQuantity'].toString() ?? '0'),
      maxQuantity: double.parse(data?['maxQuantity'].toString() ?? '0'),
      price: double.parse(data?['price'].toString() ?? '0'),
      unit: data?['unit'] as String,
      createdAt: data?['createdAt'].toDate(),
      updatedAt: data?['updatedAt'].toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'priceListId': priceListId,
      'agencyId': agencyId,
      'option1Id': option1Id,
      'option2Id': option2Id,
      'minQuantity': minQuantity,
      'maxQuantity': maxQuantity,
      'price': price,
      'unit': unit,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  PriceListItem copyWith({
    String? id,
    String? priceListId,
    ValueGetter<String?>? agencyId,
    ValueGetter<String?>? option1Id,
    ValueGetter<String?>? option2Id,
    double? minQuantity,
    double? maxQuantity,
    double? price,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PriceListItem(
      id: id ?? this.id,
      priceListId: priceListId ?? this.priceListId,
      agencyId: agencyId != null ? agencyId() : this.agencyId,
      option1Id: option1Id != null ? option1Id() : null,
      option2Id: option2Id != null ? option2Id() : null,
      minQuantity: minQuantity ?? this.minQuantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'price_list_id': Variable<String>(priceListId),
      'agency_id': Variable<String>(stringUtils.valueIfNotEmpty(agencyId)),
      'option1_id': Variable<String>(stringUtils.valueIfNotEmpty(option1Id)),
      'option2_id': Variable<String>(stringUtils.valueIfNotEmpty(option2Id)),
      'min_quantity': Variable<double>(minQuantity),
      'max_quantity': Variable<double>(maxQuantity),
      'price': Variable<double>(price),
      'unit': Variable<String>(unit),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is PriceListItem &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.priceListId == priceListId &&
        other.agencyId == agencyId &&
        other.option1Id == option1Id &&
        other.option2Id == option2Id &&
        other.minQuantity == minQuantity &&
        other.maxQuantity == maxQuantity &&
        other.price == price &&
        other.unit == unit &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
