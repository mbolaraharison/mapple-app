import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Agency)
class Agencies extends Table with DefaultTable {
  TextColumn get sageId => text()();
  TextColumn get address1 => text()();
  TextColumn get address2 => text()();
  TextColumn get city => text()();
  TextColumn get email => text()();
  TextColumn get naf => text()();
  TextColumn get phone => text()();
  TextColumn get postalCode => text()();
  TextColumn get siret => text()();
  TextColumn get label => text()();
  TextColumn get docusignAccountId => text().nullable()();
  IntColumn get orderFormNextIncrement => integer()();
  BoolColumn get canAccessRepresentativeAppraisalModule =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
