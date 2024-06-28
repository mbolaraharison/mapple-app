import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class Agency extends AbstractBaseModel implements Insertable<Agency> {
  Agency({
    required super.id,
    required this.sageId,
    required this.address1,
    required this.address2,
    required this.city,
    required this.email,
    required this.naf,
    required this.phone,
    required this.postalCode,
    required this.siret,
    required this.label,
    required this.docusignAccountId,
    required this.orderFormNextIncrement,
    required this.canAccessRepresentativeAppraisalModule,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String sageId;
  final String address1;
  final String address2;
  final String city;
  final String email;
  final String naf;
  final String phone;
  final String postalCode;
  final String siret;
  final String label;
  final String? docusignAccountId;
  final int orderFormNextIncrement;
  final bool canAccessRepresentativeAppraisalModule;

  // Getters:-------------------------------------------------------------------
  String get formattedPhone {
    String formattedPhone = phone;
    // check if phone does not have 0 at the beginning
    if (formattedPhone.startsWith('0')) {
      return formattedPhone.replaceFirst('0', '+33');
    }
    // add +33 if not present
    if (!formattedPhone.startsWith('+33')) {
      return '+33$formattedPhone';
    }
    return formattedPhone;
  }

  // Base methods:--------------------------------------------------------------
  factory Agency.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Agency(
      id: snapshot.id,
      sageId: data?['sageId'] as String,
      address1: data?['address1'] as String,
      address2: data?['address2'] as String,
      city: data?['city'] as String,
      email: data?['email'] as String,
      naf: data?['naf'] as String,
      phone: data?['phone'] as String,
      postalCode: data?['postalCode'] as String,
      siret: data?['siret'] as String,
      label: data?['label'] as String,
      docusignAccountId: data?['docusignAccountId'] as String?,
      orderFormNextIncrement: data?['orderFormNextIncrement'] as int,
      canAccessRepresentativeAppraisalModule:
          data?['canAccessRepresentativeAppraisalModule'] as bool? ?? false,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'address1': address1,
      'address2': address2,
      'city': city,
      'email': email,
      'naf': naf,
      'phone': phone,
      'postalCode': postalCode,
      'siret': siret,
      'label': label,
      'docusignAccountId': docusignAccountId,
      'orderFormNextIncrement': orderFormNextIncrement,
      'canAccessRepresentativeAppraisalModule':
          canAccessRepresentativeAppraisalModule,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Agency copyWith({
    String? id,
    String? sageId,
    String? address1,
    String? address2,
    String? city,
    String? email,
    String? naf,
    String? phone,
    String? postalCode,
    String? siret,
    String? label,
    String? docusignAccountId,
    int? orderFormNextIncrement,
    bool? canAccessRepresentativeAppraisalModule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Agency(
      id: id ?? this.id,
      sageId: sageId ?? this.sageId,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      email: email ?? this.email,
      naf: naf ?? this.naf,
      phone: phone ?? this.phone,
      postalCode: postalCode ?? this.postalCode,
      siret: siret ?? this.siret,
      label: label ?? this.label,
      docusignAccountId: docusignAccountId ?? this.docusignAccountId,
      orderFormNextIncrement:
          orderFormNextIncrement ?? this.orderFormNextIncrement,
      canAccessRepresentativeAppraisalModule:
          canAccessRepresentativeAppraisalModule ??
              this.canAccessRepresentativeAppraisalModule,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  void loadData() {}

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'sage_id': Variable<String>(sageId),
      'address1': Variable<String>(address1),
      'address2': Variable<String>(address2),
      'city': Variable<String>(city),
      'email': Variable<String>(email),
      'naf': Variable<String>(naf),
      'phone': Variable<String>(phone),
      'postal_code': Variable<String>(postalCode),
      'siret': Variable<String>(siret),
      'label': Variable<String>(label),
      'docusign_account_id':
          Variable<String>(stringUtils.valueIfNotEmpty(docusignAccountId)),
      'order_form_next_increment': Variable<int>(orderFormNextIncrement),
      'can_access_representative_appraisal_module':
          Variable<bool>(canAccessRepresentativeAppraisalModule),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Agency &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.sageId == sageId &&
        other.address1 == address1 &&
        other.address2 == address2 &&
        other.city == city &&
        other.email == email &&
        other.naf == naf &&
        other.phone == phone &&
        other.postalCode == postalCode &&
        other.siret == siret &&
        other.label == label &&
        other.docusignAccountId == docusignAccountId &&
        other.orderFormNextIncrement == orderFormNextIncrement &&
        other.canAccessRepresentativeAppraisalModule ==
            canAccessRepresentativeAppraisalModule &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
