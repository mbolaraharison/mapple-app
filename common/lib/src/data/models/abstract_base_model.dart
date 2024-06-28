abstract class AbstractBaseModel {
  AbstractBaseModel({
    required this.id,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;

  final DateTime createdAt;

  DateTime updatedAt;

  Map<String, dynamic> toFirestore();

  void loadData();

  AbstractBaseModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  bool identicalTo(AbstractBaseModel other);
}
