import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class IntegrityJobModel extends AbstractBaseModel {
  IntegrityJobModel({
    required super.id,
    required this.agencyId,
    required this.causes,
    required this.isRunning,
    required this.duration,
    required this.syncedAt,
    this.status = 'pending',
  });

  // Variables:-----------------------------------------------------------------
  final String agencyId;
  final List<Map<String, String>>? causes;
  final bool isRunning;
  final double duration;
  final DateTime syncedAt;
  final String status;

  // Getters:-------------------------------------------------------------------
  bool get isPending => status == 'pending';

  bool get isFailed => status == 'failed';

  bool get isSuccess => status == 'success';

  // Methods:-------------------------------------------------------------------
  @override
  void loadData() {}

  // Base Methods:--------------------------------------------------------------
  factory IntegrityJobModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return IntegrityJobModel(
      id: snapshot.id,
      agencyId: data?['agencyId'] ?? '',
      causes: null,
      isRunning: data?['isRunning'] ?? false,
      duration: data?['duration'] ?? 0,
      syncedAt: data?['syncedAt']?.toDate() as DateTime,
      status: data?['status'] ?? 'pending',
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'agencyId': agencyId,
      'causes': causes,
      'isRunning': isRunning,
      'duration': duration,
      'syncedAt': syncedAt,
      'status': status,
    };
  }

  @override
  IntegrityJobModel copyWith({
    String? id,
    String? agencyId,
    List<Map<String, String>>? causes,
    bool? isRunning,
    double? duration,
    DateTime? syncedAt,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IntegrityJobModel(
      id: id ?? this.id,
      agencyId: agencyId ?? this.agencyId,
      causes: causes ?? this.causes,
      isRunning: isRunning ?? this.isRunning,
      duration: duration ?? this.duration,
      syncedAt: syncedAt ?? this.syncedAt,
      status: status ?? this.status,
    );
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is IntegrityJobModel &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.agencyId == agencyId &&
        other.causes?.foldIndexed(
                true,
                (index, previousValue, element) =>
                    previousValue &&
                    element.keys
                        .toList()
                        .equals(causes?[index].keys.toList() ?? []) &&
                    element.values
                        .toList()
                        .equals(causes?[index].values.toList() ?? [])) ==
            true &&
        other.isRunning == isRunning &&
        other.duration == duration &&
        other.syncedAt == syncedAt &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
