import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class Fair extends AbstractBaseModel implements Insertable<Fair> {
  Fair({
    required super.id,
    required this.label,
    required this.openingDate,
    required this.closingDate,
    required this.city,
    required this.agencyId,
    super.createdAt,
    super.updatedAt,
  }) {
    isCurrent = false;
  }

  final String label;
  final DateTime openingDate;
  final DateTime closingDate;
  final String city;
  final String agencyId;
  // isCurrent is not stored in Firestore
  late bool isCurrent;

  // Getters:-------------------------------------------------------------------
  bool get isValid {
    // compare only dates
    final openingDate = DateTime(
      this.openingDate.year,
      this.openingDate.month,
      this.openingDate.day,
    );
    final closingDate = DateTime(
            this.closingDate.year, this.closingDate.month, this.closingDate.day)
        .add(const Duration(
            days:
                1)); // The day after the fair at 00:00 to include the last day
    // get current date
    final now = DateTime.now();

    // compare dates
    return (now.isAfter(openingDate) || now.isAtSameMomentAs(openingDate)) &&
        (now.isBefore(closingDate) || now.isAtSameMomentAs(closingDate)) &&
        city.trim().isNotEmpty;
  }

  // Setters:-------------------------------------------------------------------
  void setIsCurrent(bool isCurrent) {
    this.isCurrent = isCurrent;
  }

  // Methods:-------------------------------------------------------------------
  @override
  void loadData() {}

  // Base Methods:----------------------------------------------------------------
  factory Fair.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Fair(
      id: snapshot.id,
      label: data?['label'] as String,
      openingDate: data?['openingDate']?.toDate() as DateTime,
      closingDate: data?['closingDate']?.toDate() as DateTime,
      city: data?['city'] as String,
      agencyId: data?['agencyId'],
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'label': label,
      'openingDate': openingDate,
      'closingDate': closingDate,
      'city': city,
      'agencyId': agencyId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Fair copyWith({
    String? id,
    String? label,
    DateTime? openingDate,
    DateTime? closingDate,
    String? city,
    String? agencyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Fair(
      id: id ?? this.id,
      label: label ?? this.label,
      openingDate: openingDate ?? this.openingDate,
      closingDate: closingDate ?? this.closingDate,
      city: city ?? this.city,
      agencyId: agencyId ?? this.agencyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'label': Variable<String>(label),
      'opening_date': Variable<DateTime>(openingDate),
      'closing_date': Variable<DateTime>(closingDate),
      'agency_id': Variable<String>(agencyId),
      'is_current': Variable<bool>(isCurrent),
      'city': Variable<String>(city),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Fair &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.label == label &&
        other.openingDate == openingDate &&
        other.closingDate == closingDate &&
        other.agencyId == agencyId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
