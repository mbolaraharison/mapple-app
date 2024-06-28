import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(ServiceFamily)
class ServiceFamilies extends Table with DefaultTable {
  TextColumn get label => text()();
  TextColumn get backgroundImage => text()();
  TextColumn get icon => text()();
  BoolColumn get isEnergyRelated =>
      boolean().withDefault(const Constant(false))();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
