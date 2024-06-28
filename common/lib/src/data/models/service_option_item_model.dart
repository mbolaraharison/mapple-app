import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class ServiceOptionItem extends AbstractBaseModel
    implements Insertable<ServiceOptionItem> {
  ServiceOptionItem({
    required super.id, // this is the option item code
    required this.label,
    required this.type,
    super.createdAt,
    super.updatedAt,
  });

  final String label;
  final int type;

  // Methods:--------------------------------------------------------------------
  @override
  void loadData() {}

  // Base methods:---------------------------------------------------------------
  factory ServiceOptionItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ServiceOptionItem(
      id: snapshot.id,
      label: data?['label'] as String,
      type: data?['type'] as int,
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'label': label,
      'type': type,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  ServiceOptionItem copyWith({
    String? id,
    String? label,
    int? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceOptionItem(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'label': Variable<String>(label),
      'type': Variable<int>(type),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is ServiceOptionItem &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.label == label &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
