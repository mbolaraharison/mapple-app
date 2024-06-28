import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Fair)
class Fairs extends Table with DefaultTable {
  TextColumn get label => text()();
  DateTimeColumn get openingDate => dateTime()();
  DateTimeColumn get closingDate => dateTime()();
  TextColumn get city => text()();
  TextColumn get agencyId => text().references(Agencies, #id)();
  BoolColumn get isCurrent => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
