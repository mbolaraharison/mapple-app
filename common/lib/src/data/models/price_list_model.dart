import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class PriceList extends AbstractBaseModel implements Insertable<PriceList> {
  PriceList({
    required super.id,
    required this.serviceId,
    required this.agencyId,
    required this.priceListType,
    required this.priority,
    required this.startDate,
    required this.endDate,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String serviceId;
  final String? agencyId;
  final PriceListType priceListType;
  final int priority;
  final DateTime startDate;
  final DateTime endDate;

  Service? service;
  List<PriceListItem> items = [];

  // Getters:-------------------------------------------------------------------
  bool get isExpired {
    final now = DateTime.now();

    return now.isBefore(startDate) || now.isAfter(endDate);
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadService(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(PriceList)) {
      flow.add(PriceList);
    } else {
      return;
    }
    service = await getIt<ServiceServiceInterface>()
        .getById(serviceId, eager: eager, flow: flow);
  }

  Future<void> loadItems(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(PriceList)) {
      flow.add(PriceList);
    } else {
      return;
    }
    items = await getIt<PriceListItemServiceInterface>()
        .getByPriceListId(id, eager: eager, flow: flow);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadService(eager: eager, flow: flow);
    await loadItems(eager: eager, flow: flow);
  }

  // Base methods:--------------------------------------------------------------
  factory PriceList.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PriceList(
      id: snapshot.id,
      serviceId: data?['serviceId'],
      agencyId: data?['agencyId'],
      priceListType: PriceListType.values
          .firstWhere((e) => e.name == data?['priceListType']),
      priority: data?['priority'],
      startDate: data?['startDate'].toDate(),
      endDate: data?['endDate'].toDate(),
      createdAt: data?['createdAt'].toDate(),
      updatedAt: data?['updatedAt'].toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'serviceId': serviceId,
      'agencyId': agencyId,
      'priceListType': priceListType.name,
      'priority': priority,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  PriceList copyWith({
    String? id,
    String? serviceId,
    String? agencyId,
    PriceListType? priceListType,
    int? priority,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PriceList(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      agencyId: agencyId ?? this.agencyId,
      priceListType: priceListType ?? this.priceListType,
      priority: priority ?? this.priority,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'service_id': Variable<String>(serviceId),
      'agency_id': Variable<String>(stringUtils.valueIfNotEmpty(agencyId)),
      'price_list_type': Variable<String>(priceListType.name),
      'priority': Variable<int>(priority),
      'start_date': Variable<DateTime>(startDate),
      'end_date': Variable<DateTime>(endDate),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is PriceList &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.serviceId == serviceId &&
        other.agencyId == agencyId &&
        other.priceListType == priceListType &&
        other.priority == priority &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
