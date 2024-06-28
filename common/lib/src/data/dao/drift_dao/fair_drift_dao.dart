import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'fair_drift_dao.g.dart';

@DriftAccessor(tables: [Fairs])
class FairDriftDao extends AbstractDriftDao<Fair, $FairsTable, AgencyDatabase>
    with _$FairDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  FairDriftDao(AgencyDatabase db) : super(db, db.fairs);

  SimpleSelectStatement<$FairsTable, Fair> _queryCurrent() {
    return select(fairs)
      ..where((t) => t.isCurrent.equals(true))
      ..limit(1);
  }

  Future<Fair?> findCurrent() async {
    return _queryCurrent().getSingleOrNull();
  }

  Stream<Fair?> findCurrentAsStream() {
    return _queryCurrent().watchSingleOrNull();
  }
}
