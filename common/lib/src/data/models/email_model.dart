import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class Email extends AbstractBaseModel implements Insertable<Email> {
  Email({
    required super.id,
    required this.from,
    required this.to,
    this.templateId,
    this.params,
    required this.sentAt,
    this.expiredAt,
    required this.sent,
    required this.cc,
    required this.bcc,
    required this.retry,
    this.subject,
    this.html,
    this.attachments,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String from;
  final List<String> to;
  int? templateId;
  Map<String, String>? params;
  final DateTime sentAt;
  DateTime? expiredAt;
  final bool sent;
  final List<String> cc;
  final List<String> bcc;
  final int retry;
  String? subject;
  String? html;
  List<Map<String, String>>? attachments;

  // Methods:-------------------------------------------------------------------
  @override
  void loadData() {}

  // Base methods:--------------------------------------------------------------
  factory Email.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Email(
      id: snapshot.id,
      from: data?['from'] as String,
      to: data?['from'] as List<String>,
      templateId: data?['template'] as int?,
      params: data?['params'] as Map<String, String>?,
      sentAt: data?['sentAt']?.toDate() as DateTime,
      expiredAt: data?['expiredAt']?.toDate() as DateTime?,
      sent: data?['sent'] as bool,
      cc: data?['cc'] as List<String>,
      bcc: data?['bbc'] as List<String>,
      retry: data?['retry'] as int,
      subject: data?['subject'] as String?,
      html: data?['html'] as String?,
      attachments: data?['attachments'] as List<Map<String, String>>?,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'from': from,
      'to': to,
      'templateId': templateId,
      'params': params,
      'sentAt': sentAt,
      'expiredAt': expiredAt,
      'sent': sent,
      'cc': cc,
      'bcc': bcc,
      'retry': retry,
      'subject': subject,
      'html': html,
      'attachments': attachments,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Email copyWith({
    String? id,
    String? from,
    List<String>? to,
    int? templateId,
    Map<String, String>? params,
    DateTime? sentAt,
    DateTime? expiredAt,
    bool? sent,
    List<String>? cc,
    List<String>? bcc,
    int? retry,
    String? subject,
    String? html,
    List<Map<String, String>>? attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Email(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      templateId: templateId ?? this.templateId,
      params: params ?? this.params,
      sentAt: sentAt ?? this.sentAt,
      expiredAt: expiredAt ?? this.expiredAt,
      sent: sent ?? this.sent,
      cc: cc ?? this.cc,
      bcc: bcc ?? this.bcc,
      retry: retry ?? this.retry,
      subject: subject ?? this.subject,
      html: html ?? this.html,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {};
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Email &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.from == from &&
        other.to.equals(to) &&
        other.templateId == templateId &&
        other.params?.keys.toList().equals(params?.keys.toList() ?? []) ==
            true &&
        other.params?.values.toList().equals(params?.values.toList() ?? []) ==
            true &&
        other.sentAt == sentAt &&
        other.expiredAt == expiredAt &&
        other.sent == sent &&
        other.cc.equals(cc) &&
        other.bcc.equals(bcc) &&
        other.retry == retry &&
        other.subject == subject &&
        other.html == html &&
        other.attachments?.foldIndexed(
                true,
                (index, previousValue, element) =>
                    previousValue &&
                    element.keys
                        .toList()
                        .equals(attachments?[index].keys.toList() ?? []) &&
                    element.values
                        .toList()
                        .equals(attachments?[index].values.toList() ?? [])) ==
            true &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
