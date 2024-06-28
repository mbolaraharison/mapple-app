import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:maple_common/maple_common.dart';

class DocusignLog extends AbstractBaseModel {
  DocusignLog({
    required super.id,
    required this.envelopeId,
    required this.orderId,
    required this.recipientId,
    required this.recipientName,
    required this.action,
    required this.actionLabel,
    required this.actionDescription,
    super.createdAt,
    super.updatedAt,
  });

  final String envelopeId;
  final String orderId;
  final String recipientId;
  final String recipientName;
  final DocusignLogAction action;
  final String actionLabel;
  final String actionDescription;

  Order? order;

  // Methods:-------------------------------------------------------------------
  Future<void> loadOrder() async {
    order = await getIt<OrderServiceInterface>().getById(orderId);
  }

  @override
  Future<void> loadData() async {
    await loadOrder();
  }

  // Base Methods:----------------------------------------------------------------
  factory DocusignLog.fromFirestore(
    firestore.DocumentSnapshot<Map<String, dynamic>> snapshot,
    firestore.SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DocusignLog(
      id: snapshot.id,
      envelopeId: data?['envelopeId'] as String,
      orderId: data?['orderId'] as String,
      recipientId: data?['recipientId'] as String,
      recipientName: data?['recipientName'] as String,
      action: DocusignLogAction.fromValue(data?['action'] ?? ''),
      actionLabel: data?['action'] as String,
      actionDescription: data?['description'] as String,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'envelopeId': envelopeId,
      'orderId': orderId,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'action': action.name,
      'actionLabel': actionLabel,
      'actionDescription': actionDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  DocusignLog copyWith({
    String? id,
    String? envelopeId,
    String? orderId,
    String? recipientId,
    String? recipientName,
    DocusignLogAction? action,
    String? actionLabel,
    String? actionDescription,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DocusignLog(
      id: id ?? this.id,
      envelopeId: envelopeId ?? this.envelopeId,
      orderId: orderId ?? this.orderId,
      recipientId: recipientId ?? this.recipientId,
      recipientName: recipientName ?? this.recipientName,
      action: action ?? this.action,
      actionLabel: actionLabel ?? this.actionLabel,
      actionDescription: actionDescription ?? this.actionDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is DocusignLog &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.envelopeId == envelopeId &&
        other.orderId == orderId &&
        other.recipientId == recipientId &&
        other.recipientName == recipientName &&
        other.action == action &&
        other.actionLabel == actionLabel &&
        other.actionDescription == actionDescription &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
