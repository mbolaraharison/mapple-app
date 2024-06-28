import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class FileDataFamily extends AbstractBaseModel
    implements Insertable<FileDataFamily> {
  // Constructor:---------------------------------------------------------------
  FileDataFamily({
    required super.id,
    required this.label,
    required this.backgroundImage,
    required this.icon,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String label;
  final String backgroundImage;
  final String icon;

  // Methods:-------------------------------------------------------------------
  @override
  void loadData() {}

  // Base methods:--------------------------------------------------------------
  factory FileDataFamily.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return FileDataFamily(
      id: snapshot.id,
      label: data?['label'],
      backgroundImage: data?['backgroundImage'],
      icon: data?['icon'],
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'label': label,
      'backgroundImage': backgroundImage,
      'icon': icon,
    };
  }

  @override
  FileDataFamily copyWith({
    String? id,
    String? label,
    String? backgroundImage,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FileDataFamily(
      id: id ?? this.id,
      label: label ?? this.label,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'label': Variable<String>(label),
      'background_image': Variable<String>(backgroundImage),
      'icon': Variable<String>(icon),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is FileDataFamily &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.label == label &&
        other.backgroundImage == backgroundImage &&
        other.icon == icon &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
