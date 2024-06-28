import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'file_data_family_drift_dao.g.dart';

@DriftAccessor(tables: [FileDataFamilies])
class FileDataFamilyDriftDao extends AbstractDriftDao<FileDataFamily,
    $FileDataFamiliesTable, AgencyDatabase> with _$FileDataFamilyDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  FileDataFamilyDriftDao(AgencyDatabase db) : super(db, db.fileDataFamilies);
}
