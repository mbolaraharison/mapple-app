import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

class Note extends AbstractBaseModel implements Insertable<Note> {
  Note({
    required super.id,
    required this.representativeId,
    required this.customerId,
    required this.agencyId,
    this.title,
    required this.note,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String representativeId;
  final String customerId;
  final String agencyId;
  String? title;
  String note;

  Representative? representative;

  // Getters:-------------------------------------------------------------------
  String get humanReadableCreatedAt {
    DateTimeUtilsInterface dateTimeUtils = getIt<DateTimeUtilsInterface>();
    return dateTimeUtils.formatToHumanReadable(createdAt);
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadRepresentative(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Note)) {
      flow.add(Note);
    } else {
      return;
    }
    representative =
        await getIt<RepresentativeServiceInterface>().getById(id, eager: eager);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadRepresentative(eager: eager, flow: flow);
  }

  // Base methods:--------------------------------------------------------------
  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Note(
      id: snapshot.id,
      representativeId: data?['representativeId'] as String,
      customerId: data?['customerId'] as String,
      agencyId: data?['agencyId'] as String,
      title: data?['title'] as String?,
      note: data?['note'] as String,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'representativeId': representativeId,
      'customerId': customerId,
      'agencyId': agencyId,
      'title': title,
      'note': note,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Note copyWith({
    String? id,
    String? representativeId,
    String? customerId,
    String? agencyId,
    String? title,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      representativeId: representativeId ?? this.representativeId,
      customerId: customerId ?? this.customerId,
      agencyId: agencyId ?? this.agencyId,
      title: title ?? this.title,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'representative_id': Variable<String>(representativeId),
      'customer_id': Variable<String>(customerId),
      'agency_id': Variable<String>(agencyId),
      'title': Variable<String>(title),
      'note': Variable<String>(note),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.representativeId == representativeId &&
        other.customerId == customerId &&
        other.agencyId == agencyId &&
        other.title == title &&
        other.note == note &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
