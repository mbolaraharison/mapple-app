import 'package:maple_common/maple_common.dart';

abstract class AbstractIsSoftDeletable extends AbstractBaseModel {
  DateTime? deletedAt;

  AbstractIsSoftDeletable({
    required super.id,
    super.createdAt,
    super.updatedAt,
    this.deletedAt,
  });

  void delete() {
    deletedAt = DateTime.now();
  }
}
