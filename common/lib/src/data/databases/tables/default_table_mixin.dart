import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

mixin DefaultTable on Table {
  TextColumn get id =>
      text().clientDefault(() => getIt<UuidUtilsInterface>().generate())();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
