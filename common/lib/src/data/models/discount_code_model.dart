import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';

class DiscountCode extends AbstractIsSoftDeletable
    implements Insertable<DiscountCode> {
  DiscountCode({
    required super.id,
    required this.code,
    required this.type,
    required this.discount,
    this.startDate,
    this.endDate,
    this.agencyId,
    this.familyIds = const [],
    this.subFamilyIds = const [],
    this.serviceIds = const [],
    this.userId,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  // Static:--------------------------------------------------------------------
  static RegExp codeRegExp = RegExp(r'^[A-Z0-9]{4,10}$');

  // Variables:-----------------------------------------------------------------
  String code;
  DiscountCodeType type;
  double discount;
  DateTime? startDate;
  DateTime? endDate;
  String? agencyId;
  String? userId;

  List<String> familyIds;
  List<String> subFamilyIds;
  List<String> serviceIds;

  List<ServiceFamily> families = [];
  List<ServiceSubFamily> subFamilies = [];
  List<Service> services = [];

  // Getters:-------------------------------------------------------------------
  bool get hasExpiration => startDate != null && endDate != null;

  bool get isExpired {
    if (startDate == null || endDate == null) return false;

    final now = DateTime.now();

    return now.isBefore(startDate!) || now.isAfter(endDate!);
  }

  String get formattedDiscount {
    if (type == DiscountCodeType.fixedAmount) {
      return getIt<NumberFormatterUtilsInterface>().formatToCurrency(discount);
    }

    if (discount == discount.roundToDouble()) {
      return '${getIt<NumberFormatterUtilsInterface>().formatToInteger(discount)}%';
    }

    return '${getIt<NumberFormatterUtilsInterface>().formatToDoubleWith2Decimals(discount)}%';
  }

  String get subjectLabel {
    if (families.isNotEmpty) {
      return 'discount_codes.subject.family'.tr();
    }

    if (subFamilies.isNotEmpty) {
      return 'discount_codes.subject.sub_family'.tr();
    }

    if (services.isNotEmpty) {
      return 'discount_codes.subject.service'.tr();
    }

    return '';
  }

  String get subject {
    if (families.isNotEmpty) {
      return families.map((e) => e.label).join(', ');
    }

    if (subFamilies.isNotEmpty) {
      return subFamilies.map((e) => e.label).join(', ');
    }

    if (services.isNotEmpty) {
      return services.map((e) => e.label).join(', ');
    }

    return '';
  }

  String get formattedStartDate {
    if (startDate == null) return '';

    return getIt<DateTimeUtilsInterface>().formatToFrenchDate(startDate!);
  }

  String get formattedEndDate {
    if (endDate == null) return '';

    return getIt<DateTimeUtilsInterface>().formatToFrenchDate(endDate!);
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadFamilies() async {
    families = await getIt<ServiceFamilyServiceInterface>()
        .getByDiscountCodeId(id)
        .then((value) => value.toList());
    familyIds = families.map((e) => e.id).toList();
  }

  Future<void> loadSubFamilies(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(DiscountCode)) {
      flow.add(DiscountCode);
    } else {
      return;
    }
    subFamilies = await getIt<ServiceSubFamilyServiceInterface>()
        .getByDiscountCodeId(id, eager: eager, flow: flow)
        .then((value) => value.toList());
    subFamilyIds = subFamilies.map((e) => e.id).toList();
  }

  Future<void> loadServices(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(DiscountCode)) {
      flow.add(DiscountCode);
    } else {
      return;
    }
    services = await getIt<ServiceServiceInterface>()
        .getByDiscountCodeId(id, eager: eager, flow: flow)
        .then((value) => value.toList());
    serviceIds = services.map((e) => e.id).toList();
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadFamilies();
    await loadSubFamilies(eager: eager, flow: flow);
    await loadServices(eager: eager, flow: flow);
  }

  double getDiscountPercentage(double price) {
    if (type == DiscountCodeType.fixedAmount) {
      final double percentage = discount / price * 100;
      return percentage > 100 ? 100 : percentage;
    }

    return discount;
  }

  // Base methods:--------------------------------------------------------------
  factory DiscountCode.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DiscountCode(
      id: snapshot.id,
      code: data?['code'] as String,
      type: DiscountCodeType.values.firstWhere(
        (e) => e.name == data?['type'] as String,
      ),
      discount: double.parse(data?['discount'].toString() ?? '0'),
      startDate: data?['startDate']?.toDate() as DateTime?,
      endDate: data?['endDate']?.toDate() as DateTime?,
      agencyId: data?['agencyId'] as String?,
      familyIds: List<String>.from(data?['familyIds'] ?? []),
      subFamilyIds: List<String>.from(data?['subFamilyIds'] ?? []),
      serviceIds: List<String>.from(data?['serviceIds'] ?? []),
      userId: data?['userId'] as String?,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
      deletedAt: data?['deletedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'code': code,
      'type': type.name,
      'discount': discount,
      'startDate': startDate,
      'endDate': endDate,
      'agencyId': agencyId,
      'familyIds': familyIds,
      'subFamilyIds': subFamilyIds,
      'serviceIds': serviceIds,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  @override
  DiscountCode copyWith({
    String? id,
    String? code,
    DiscountCodeType? type,
    double? discount,
    ValueGetter<DateTime?>? startDate,
    ValueGetter<DateTime?>? endDate,
    String? agencyId,
    List<String>? familyIds,
    List<String>? subFamilyIds,
    List<String>? serviceIds,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    ValueGetter<DateTime?>? deletedAt,
  }) {
    return DiscountCode(
      id: id ?? this.id,
      code: code ?? this.code,
      type: type ?? this.type,
      discount: discount ?? this.discount,
      startDate: startDate != null ? startDate() : this.startDate,
      endDate: endDate != null ? endDate() : this.endDate,
      agencyId: agencyId ?? this.agencyId,
      familyIds: familyIds ?? this.familyIds,
      subFamilyIds: subFamilyIds ?? this.subFamilyIds,
      serviceIds: serviceIds ?? this.serviceIds,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt != null ? deletedAt() : this.deletedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'code': Variable<String>(code),
      'type': Variable<String>(type.name),
      'discount': Variable<double>(discount),
      'start_date': Variable<DateTime>(startDate),
      'end_date': Variable<DateTime>(endDate),
      'agency_id': Variable<String>(stringUtils.valueIfNotEmpty(agencyId)),
      'user_id': Variable<String>(stringUtils.valueIfNotEmpty(userId)),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
      'deleted_at': Variable<DateTime>(deletedAt)
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is DiscountCode &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.code == code &&
        other.type == type &&
        other.discount == discount &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.agencyId == agencyId &&
        other.userId == userId &&
        other.familyIds.equals(familyIds) &&
        other.subFamilyIds.equals(subFamilyIds) &&
        other.serviceIds.equals(serviceIds) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
