import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class ServiceFamily extends AbstractBaseModel
    implements Insertable<ServiceFamily> {
  ServiceFamily({
    required super.id,
    required this.label,
    required this.backgroundImage,
    required this.icon,
    required this.isEnergyRelated,
    required this.position,
    super.createdAt,
    super.updatedAt,
  });

  final String label;
  final String backgroundImage;
  final String icon;
  final bool isEnergyRelated;
  final int position;

  // Methods:--------------------------------------------------------------------
  @override
  void loadData() {}

  // Base methods:---------------------------------------------------------------
  factory ServiceFamily.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ServiceFamily(
      id: snapshot.id,
      label: data?['label'],
      backgroundImage: data?['backgroundImage'],
      icon: data?['icon'],
      isEnergyRelated: data?['isEnergyRelated'],
      position: data?['position'] ?? 999,
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'label': label,
      'backgroundImage': backgroundImage,
      'icon': icon,
      'isEnergyRelated': isEnergyRelated,
      'position': position,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  ServiceFamily copyWith({
    String? id,
    String? label,
    String? backgroundImage,
    String? icon,
    bool? isEnergyRelated,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceFamily(
      id: id ?? this.id,
      label: label ?? this.label,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      icon: icon ?? this.icon,
      isEnergyRelated: isEnergyRelated ?? this.isEnergyRelated,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Future<bool> get isActive async {
    List<ServiceSubFamily> subFamilies =
        await getIt<ServiceSubFamilyServiceInterface>().getByFamilyId(id);
    for (ServiceSubFamily subFamily in subFamilies) {
      bool isSubFamilyActive = await subFamily.isActive;
      if (isSubFamilyActive) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'label': Variable<String>(label),
      'background_image': Variable<String>(backgroundImage),
      'icon': Variable<String>(icon),
      'is_energy_related': Variable<bool>(isEnergyRelated),
      'position': Variable<int>(position),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is ServiceFamily &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.label == label &&
        other.backgroundImage == backgroundImage &&
        other.icon == icon &&
        other.isEnergyRelated == isEnergyRelated &&
        other.position == position &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
