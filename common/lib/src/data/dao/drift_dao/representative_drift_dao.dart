import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'representative_drift_dao.g.dart';

@DriftAccessor(tables: [Representatives])
class RepresentativeDriftDao extends AbstractDriftDao<Representative,
    $RepresentativesTable, AgencyDatabase> with _$RepresentativeDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  RepresentativeDriftDao(AgencyDatabase db) : super(db, db.representatives);

  SimpleSelectStatement<$RepresentativesTable, Representative>
      _queryFirstByEmail(String email) {
    return select(representatives)
      ..where((tbl) => tbl.email.isValue(email))
      ..limit(1);
  }

  Future<Representative?> findFirstByEmail(String email) async {
    return _queryFirstByEmail(email).getSingleOrNull();
  }

  Stream<Representative?> findFirstByEmailAsStream(String email) {
    return _queryFirstByEmail(email).watchSingleOrNull();
  }

  Future<List<Representative>> getActiveAndAvailableToSell() async {
    final excludedRoles = [
      Role.technicalManager.value,
      Role.installer.value,
      Role.it.value,
      Role.unknown.value,
    ];
    final query = select(representatives)
      ..where((tbl) => tbl.isActive.equals(true))
      ..where((tbl) => tbl.profileCode.isNotIn(excludedRoles))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.firstName, mode: OrderingMode.asc),
        (tbl) => OrderingTerm(expression: tbl.lastName, mode: OrderingMode.asc),
      ]);
    return query.get();
  }
}
