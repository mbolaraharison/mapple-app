import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Supplier)
class Suppliers extends Table with DefaultTable {
  TextColumn get sageId => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  TextColumn get name => text().nullable()();
  TextColumn get siret => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get postalCode => text()();
  TextColumn get city => text()();
  TextColumn get rgeCertificateNumber => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get rgeQualification => text().nullable()();
  TextColumn get agencyId => text().references(Agencies, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
