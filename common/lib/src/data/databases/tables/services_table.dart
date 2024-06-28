import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Service)
class Services extends Table with DefaultTable {
  TextColumn get label => text()();
  TextColumn get designation => text().nullable()();
  TextColumn get category => textEnum<ServiceCategory>()();
  TextColumn get defaultVat => textEnum<TaxLevel>()();
  TextColumn get unit => text()();
  IntColumn get status => integer()();
  TextColumn get subFamilyId => text().references(ServiceSubFamilies, #id)();
  TextColumn get agencyId => text().nullable().references(Agencies, #id)();
  TextColumn get sageId => text()();
  BoolColumn get isCleaning => boolean().withDefault(const Constant(false))();
  TextColumn get sheetFileDataId =>
      text().nullable().references(FileDatas, #id)();
  TextColumn get searchableLabel => text()();

  @override
  Set<Column> get primaryKey => {id};
}
