import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class NotificationToken extends AbstractBaseModel {
  NotificationToken({
    required super.id,
    required this.representativeId,
    required this.deviceId,
    required this.token,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String representativeId;
  final String deviceId;
  String token;

  Representative? representative;

  // Methods:-------------------------------------------------------------------
  Future<void> loadRepresentative() async {
    representative =
        await getIt<RepresentativeServiceInterface>().getById(representativeId);
  }

  @override
  Future<void> loadData() async {
    await loadRepresentative();
  }

  // Base methods:--------------------------------------------------------------
  factory NotificationToken.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NotificationToken(
      id: snapshot.id,
      representativeId: data?['representativeId'] as String,
      deviceId: data?['deviceId'] as String,
      token: data?['token'] as String,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'representativeId': representativeId,
      'deviceId': deviceId,
      'token': token,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  NotificationToken copyWith({
    String? id,
    String? representativeId,
    String? deviceId,
    String? token,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationToken(
      id: id ?? this.id,
      representativeId: representativeId ?? this.representativeId,
      deviceId: deviceId ?? this.deviceId,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is NotificationToken &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.representativeId == representativeId &&
        other.deviceId == deviceId &&
        other.token == token &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
