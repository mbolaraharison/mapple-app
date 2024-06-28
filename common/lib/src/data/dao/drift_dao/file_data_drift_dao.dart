import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'file_data_drift_dao.g.dart';

@DriftAccessor(tables: [FileDatas])
class FileDataDriftDao
    extends AbstractDriftDao<FileData, $FileDatasTable, AgencyDatabase>
    with _$FileDataDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  FileDataDriftDao(AgencyDatabase db) : super(db, db.fileDatas);

  Future<FileData?> findByUniqueName(String uniqueName) async {
    return (select(fileDatas)
          ..where((tbl) => tbl.uniqueName.equals(uniqueName))
          ..limit(1))
        .getSingleOrNull();
  }

  SimpleSelectStatement<$FileDatasTable, FileData> _queryByFamilyIdAsStream(
      String familyId) {
    return select(fileDatas)..where((tbl) => tbl.familyId.equals(familyId));
  }

  Stream<List<FileData>> findByFamilyIdAsStream(String familyId) {
    return _queryByFamilyIdAsStream(familyId).watch();
  }

  SimpleSelectStatement<$FileDatasTable, FileData>
      _querySearchByCustomerIdByType(
          String query, String customerId, FileDataType type) {
    final baseQuery = select(fileDatas)
      ..where((tbl) =>
          tbl.customerId.equals(customerId) &
          tbl.isPreview.equals(false) &
          tbl.type.equals(type.name))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
      ]);

    if (query.toSearchable().trim().isEmpty) {
      return baseQuery;
    }

    return baseQuery
      ..where(
          (tbl) => tbl.searchableDisplayName.contains(query.toSearchable()));
  }

  Future<List<FileData>> searchByCustomerIdByType(
      String query, String customerId, FileDataType type) async {
    return _querySearchByCustomerIdByType(query, customerId, type).get();
  }

  Stream<List<FileData>> searchByCustomerIdByTypeAsStream(
      String query, String customerId, FileDataType type) {
    return _querySearchByCustomerIdByType(query, customerId, type).watch();
  }

  SimpleSelectStatement<$FileDatasTable, FileData> _querySearchByCustomerId(
      String customerId) {
    return select(fileDatas)
      ..where((tbl) => tbl.customerId.equals(customerId))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)
      ]);
  }

  Future<List<FileData>> findByCustomerId(String customerId) async {
    return _querySearchByCustomerId(customerId).get();
  }

  Stream<List<FileData>> findByCustomerIdAsStream(String customerId) {
    return _querySearchByCustomerId(customerId).watch();
  }
}
