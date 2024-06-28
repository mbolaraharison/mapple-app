import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'service_sub_family_drift_dao.g.dart';

@DriftAccessor(tables: [ServiceSubFamilies])
class ServiceSubFamilyDriftDao extends AbstractDriftDao<
    ServiceSubFamily,
    $ServiceSubFamiliesTable,
    AgencyDatabase> with _$ServiceSubFamilyDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ServiceSubFamilyDriftDao(AgencyDatabase db)
      : super(db, db.serviceSubFamilies);

  SimpleSelectStatement<$ServiceSubFamiliesTable, ServiceSubFamily>
      _queryByFamilyId(String familyId) {
    // Join with service sub families and services, count active services
    return (select(serviceSubFamilies)
      ..where((tbl) => tbl.familyId.equals(familyId))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.label, mode: OrderingMode.asc)
      ]));
  }

  Future<List<ServiceSubFamily>> findByFamilyId(String familyId) async {
    return _queryByFamilyId(familyId).get();
  }

  Stream<List<ServiceSubFamily>> findByFamilyIdAsStream(String familyId) {
    return _queryByFamilyId(familyId).watch();
  }

  Selectable<ServiceSubFamily> _queryByDiscountCodeId(String discountCodeId) {
    return db.serviceSubFamiliesByDiscountId(discountCodeId: discountCodeId);
  }

  Future<List<ServiceSubFamily>> findByDiscountCodeId(
      String discountCodeId) async {
    return _queryByDiscountCodeId(discountCodeId).get();
  }

  Stream<List<ServiceSubFamily>> findByDiscountCodeIdAsStream(
      String discountCodeId) {
    return _queryByDiscountCodeId(discountCodeId).watch();
  }
}
