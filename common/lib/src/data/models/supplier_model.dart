import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class Supplier extends AbstractBaseModel implements Insertable<Supplier> {
  Supplier({
    required super.id,
    this.sageId,
    required this.isActive,
    this.name,
    this.siret,
    this.address,
    required this.postalCode,
    required this.city,
    this.rgeCertificateNumber,
    this.startDate,
    this.endDate,
    this.rgeQualification,
    required this.agencyId,
    super.createdAt,
    super.updatedAt,
  });

  String? sageId;
  final bool isActive;
  String? name;
  String? siret;
  String? address;
  final String postalCode;
  final String city;
  String? rgeCertificateNumber;
  DateTime? startDate;
  DateTime? endDate;
  String? rgeQualification;
  final String agencyId;

  // Methods:-------------------------------------------------------------------
  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {}

  // Base Methods:----------------------------------------------------------------
  factory Supplier.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Supplier(
      id: snapshot.id,
      sageId: data?['sageId'] as String,
      isActive: data?['isActive'] as bool,
      name: data?['name'] as String,
      siret: data?['siret'] as String,
      address: data?['address'] as String,
      postalCode: data?['postalCode'] as String,
      city: data?['city'] as String,
      rgeCertificateNumber: data?['rgeCertificateNumber'] as String,
      startDate: data?['startDate']?.toDate() as DateTime?,
      endDate: data?['endDate']?.toDate() as DateTime?,
      rgeQualification: data?['rgeQualification'] as String,
      agencyId: data?['agencyId'],
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'sageId': sageId,
      'isActive': isActive,
      'name': name,
      'siret': siret,
      'address': address,
      'postalCode': postalCode,
      'city': city,
      'rgeCertificateNumber': rgeCertificateNumber,
      'startDate': startDate,
      'endDate': endDate,
      'rgeQualification': rgeQualification,
      'agencyId': agencyId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Supplier copyWith({
    String? id,
    String? sageId,
    bool? isActive,
    String? name,
    String? siret,
    String? address,
    String? postalCode,
    String? city,
    String? rgeCertificateNumber,
    DateTime? startDate,
    DateTime? endDate,
    String? rgeQualification,
    String? agencyId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Supplier(
      id: id ?? this.id,
      sageId: sageId ?? this.sageId,
      isActive: isActive ?? this.isActive,
      name: name ?? this.name,
      siret: siret ?? this.siret,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      rgeCertificateNumber: rgeCertificateNumber ?? this.rgeCertificateNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rgeQualification: rgeQualification ?? this.rgeQualification,
      agencyId: agencyId ?? this.agencyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'sage_id': Variable<String>(sageId),
      'is_active': Variable<bool>(isActive),
      'name': Variable<String>(name),
      'siret': Variable<String>(siret),
      'address': Variable<String>(address),
      'postal_code': Variable<String>(postalCode),
      'city': Variable<String>(city),
      'rge_certificate_number': Variable<String>(rgeCertificateNumber),
      'start_date': Variable<DateTime>(startDate),
      'end_date': Variable<DateTime>(endDate),
      'rge_qualification': Variable<String>(rgeQualification),
      'agency_id': Variable<String>(agencyId),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Supplier &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.sageId == sageId &&
        other.isActive == isActive &&
        other.name == name &&
        other.siret == siret &&
        other.address == address &&
        other.postalCode == postalCode &&
        other.city == city &&
        other.rgeCertificateNumber == rgeCertificateNumber &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.rgeQualification == rgeQualification &&
        other.agencyId == agencyId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
