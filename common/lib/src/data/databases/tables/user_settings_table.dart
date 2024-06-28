import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(UserSetting)
class UserSettings extends Table with DefaultTable {
  TextColumn get userId => text()();
  BoolColumn get showEmailInOrderForm => boolean()();
  BoolColumn get showPhoneInOrderForm => boolean()();
  TextColumn get appVersion => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
