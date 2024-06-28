import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'service_family_drift_dao.g.dart';

@DriftAccessor(tables: [ServiceFamilies])
class ServiceFamilyDriftDao extends AbstractDriftDao<ServiceFamily,
    $ServiceFamiliesTable, AgencyDatabase> with _$ServiceFamilyDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ServiceFamilyDriftDao(AgencyDatabase db) : super(db, db.serviceFamilies);

  Selectable<ServiceFamily> _queryByDiscountCodeId(String discountCodeId) {
    return db.serviceFamiliesByDiscountId(discountCodeId: discountCodeId);
  }

  Future<List<ServiceFamily>> findByDiscountCodeId(String discountCodeId) {
    return _queryByDiscountCodeId(discountCodeId).get();
  }

  Stream<List<ServiceFamily>> findByDiscountCodeIdAsStream(
      String discountCodeId) {
    return _queryByDiscountCodeId(discountCodeId).watch();
  }

  Selectable<ServiceFamily> _queryActiveAndOrderByPosition() {
    // Join with service sub families and services, count active services
    return db.activeServiceFamilies();
  }

  Future<List<ServiceFamily>> findAllActiveAndOrderByPosition() async {
    return _queryActiveAndOrderByPosition().get();
  }

  Stream<List<ServiceFamily>> findAllActiveAndOrderByPositionAsStream() {
    return _queryActiveAndOrderByPosition().watch();
  }
}
