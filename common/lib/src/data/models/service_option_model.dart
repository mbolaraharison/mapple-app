import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class ServiceOption extends AbstractBaseModel
    implements Insertable<ServiceOption> {
  ServiceOption({
    required super.id,
    required this.serviceId,
    required this.agencyId,
    required this.option1Id,
    required this.option2Id,
    required this.designation,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String serviceId;
  final String? agencyId;
  final String option1Id;
  final String? option2Id;
  final String? designation;

  Service? service;
  ServiceOptionItem? option1;
  ServiceOptionItem? option2;

  // Methods:-------------------------------------------------------------------
  Future<void> loadService(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(ServiceOption)) {
      flow.add(ServiceOption);
    } else {
      return;
    }
    service = await getIt<ServiceServiceInterface>()
        .getById(serviceId, eager: eager, flow: flow);
  }

  Future<void> loadOption1({List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(ServiceOption)) {
      flow.add(ServiceOption);
    } else {
      return;
    }
    option1 =
        await getIt<ServiceOptionItemServiceInterface>().getById(option1Id);
  }

  Future<void> loadOption2({List<Type> flow = const []}) async {
    if (option2Id == null) {
      return;
    }
    // check flow
    flow = List.from(flow);
    if (!flow.contains(ServiceOption)) {
      flow.add(ServiceOption);
    } else {
      return;
    }
    option2 =
        await getIt<ServiceOptionItemServiceInterface>().getById(option2Id!);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadService(eager: eager, flow: flow);
    await loadOption1(flow: flow);
    await loadOption2(flow: flow);
  }

  // Base methods:--------------------------------------------------------------
  factory ServiceOption.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ServiceOption(
      id: snapshot.id,
      serviceId: data?['serviceId'] as String,
      agencyId: data?['agencyId'] as String?,
      option1Id: data?['option1Id'] as String,
      option2Id: data?['option2Id'] as String?,
      designation: data?['designation'] as String?,
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'serviceId': serviceId,
      'agencyId': agencyId,
      'option1Id': option1Id,
      'option2Id': option2Id,
      'designation': designation,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  ServiceOption copyWith({
    String? id,
    String? serviceId,
    String? agencyId,
    String? option1Id,
    String? option2Id,
    String? designation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceOption(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      agencyId: agencyId ?? this.agencyId,
      option1Id: option1Id ?? this.option1Id,
      option2Id: option2Id ?? this.option2Id,
      designation: designation ?? this.designation,
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
      'option1_id': Variable<String>(option1Id),
      'option2_id': Variable<String>(stringUtils.valueIfNotEmpty(option2Id)),
      'designation': Variable<String>(designation),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is ServiceOption &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.serviceId == serviceId &&
        other.agencyId == agencyId &&
        other.option1Id == option1Id &&
        other.option2Id == option2Id &&
        other.designation == designation &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
