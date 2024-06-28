import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(FileData)
class FileDatas extends Table with DefaultTable {
  TextColumn get agencyId => text().nullable().references(Agencies, #id)();
  TextColumn get uniqueName => text()();
  TextColumn get displayName => text()();
  BoolColumn get existsInStorage =>
      boolean().withDefault(const Constant(false))();
  TextColumn get syncStatus => textEnum<SyncStatus>()();
  TextColumn get mode => textEnum<FileDataMode>()();
  TextColumn get familyId =>
      text().nullable().references(FileDataFamilies, #id)();
  TextColumn get customerId => text().nullable().references(Customers, #id)();
  TextColumn get type => textEnum<FileDataType>()();
  RealColumn get size => real().withDefault(const Constant(0))();
  TextColumn get mimeType => text().nullable()();
  TextColumn get downloadUrl => text().nullable()();
  TextColumn get previewFileDataId => text().nullable()();
  BoolColumn get isPreview => boolean().withDefault(const Constant(false))();
  TextColumn get orderId => text().nullable().references(Orders, #id)();
  TextColumn get searchableDisplayName => text()();

  @override
  Set<Column> get primaryKey => {id};
}
