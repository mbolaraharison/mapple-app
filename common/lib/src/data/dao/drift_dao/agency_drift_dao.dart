import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'agency_drift_dao.g.dart';

@DriftAccessor(tables: [Agencies])
class AgencyDriftDao
    extends AbstractDriftDao<Agency, $AgenciesTable, AgencyDatabase>
    with _$AgencyDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  AgencyDriftDao(AgencyDatabase db) : super(db, db.agencies);
}
