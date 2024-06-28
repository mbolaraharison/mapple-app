import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class ServiceSubFamily extends AbstractBaseModel
    implements Insertable<ServiceSubFamily> {
  ServiceSubFamily({
    required super.id,
    required this.label,
    required this.familyId,
    super.createdAt,
    super.updatedAt,
  });

  final String label;
  final String familyId;

  ServiceFamily? family;

  // Methods:-------------------------------------------------------------------
  Future<void> loadFamily({List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(ServiceSubFamily)) {
      flow.add(ServiceSubFamily);
    } else {
      return;
    }
    family = await getIt<ServiceFamilyServiceInterface>().getById(familyId);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadFamily(flow: flow);
  }

  // Base methods:--------------------------------------------------------------
  factory ServiceSubFamily.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ServiceSubFamily(
      id: snapshot.id,
      label: data?['label'],
      familyId: data?['familyId'],
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'label': label,
      'familyId': familyId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  ServiceSubFamily copyWith({
    String? id,
    String? label,
    String? familyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceSubFamily(
      id: id ?? this.id,
      label: label ?? this.label,
      familyId: familyId ?? this.familyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Future<bool> get isActive async {
    List<Service> services =
        await getIt<ServiceServiceInterface>().getBySubFamilyId(id);
    for (Service service in services) {
      if (service.isActive) {
        return true;
      }
    }
    return false;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'label': Variable<String>(label),
      'family_id': Variable<String>(familyId),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is ServiceSubFamily &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.label == label &&
        other.familyId == familyId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
