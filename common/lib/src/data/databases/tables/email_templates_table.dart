import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(EmailTemplate)
class EmailTemplates extends Table with DefaultTable {
  IntColumn get templateId => integer()();
  TextColumn get templateName => text()();

  @override
  Set<Column> get primaryKey => {id};
}
