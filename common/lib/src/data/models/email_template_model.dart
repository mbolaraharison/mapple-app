import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class EmailTemplate extends AbstractBaseModel
    implements Insertable<EmailTemplate> {
  EmailTemplate({
    required super.id,
    super.createdAt,
    required this.templateId,
    required this.templateName,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final int templateId;
  final String templateName;

  static const Map<String, String> emailTemplates = {
    'APPRAISAL_RECALL_TO_REPRESENTATIVE': 'appraisal-recall-to-representative',
    'ORDER_FORM_TO_AGENCY': 'order-form-to-agency',
    'ORDER_QUOTE_TO_CONTACTS': 'order-quote-to-contacts',
    'REVIEW_REQUEST_TO_CUSTOMER': 'review-request-to-customer',
  };

  // Methods:-------------------------------------------------------------------
  @override
  void loadData() {}

  // Base methods:--------------------------------------------------------------
  factory EmailTemplate.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EmailTemplate(
      id: snapshot.id,
      templateId: data?['templateId'] as int,
      templateName: data?['templateName'] as String,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'templateId': templateId,
      'templateName': templateName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  EmailTemplate copyWith({
    String? id,
    int? templateId,
    String? templateName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmailTemplate(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      templateName: templateName ?? this.templateName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'template_id': Variable<int>(templateId),
      'template_name': Variable<String>(templateName),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is EmailTemplate &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.templateId == templateId &&
        other.templateName == templateName &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
