import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';
part 'service_drift_dao.g.dart';

@DriftAccessor(tables: [Services])
class ServiceDriftDao
    extends AbstractDriftDao<Service, $ServicesTable, AgencyDatabase>
    with _$ServiceDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ServiceDriftDao(AgencyDatabase db) : super(db, db.services);

  MultiSelectable<Service> _querySearch(String search) {
    final query = select(services).join([
      innerJoin(
        serviceSubFamilies,
        serviceSubFamilies.id.equalsExp(services.subFamilyId),
      ),
      innerJoin(
        serviceFamilies,
        serviceFamilies.id.equalsExp(serviceSubFamilies.familyId),
      ),
    ])
      ..where(services.searchableLabel.contains(search.toSearchable()) &
          services.status.equals(1))
      ..orderBy([
        OrderingTerm(expression: serviceFamilies.label, mode: OrderingMode.asc),
        OrderingTerm(
          expression: serviceSubFamilies.label,
          mode: OrderingMode.asc,
        ),
        OrderingTerm(expression: services.label, mode: OrderingMode.asc),
      ]);

    return query.map((row) => row.readTable(services));
  }

  Future<List<Service>> search(String query) async {
    return _querySearch(query).get();
  }

  Stream<List<Service>> searchAsStream(String query) {
    return _querySearch(query).watch();
  }

  @override
  Future<List<Service>> findAllByAgencyIdOrNullAgencyId(String agencyId) async {
    return (select(services)
          ..where(
              (tbl) => tbl.agencyId.equals(agencyId) | tbl.agencyId.isNull()))
        .get();
  }

  SimpleSelectStatement<$ServicesTable, Service> _queryBySubFamilyId(
      String subFamilyId) {
    // Join with service sub families and services, count active services
    return (select(services)
      ..where((tbl) => tbl.subFamilyId.equals(subFamilyId))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.label, mode: OrderingMode.asc)
      ]));
  }

  Future<List<Service>> findAllActiveByFamilyId(String familyId) async {
    return db.activeServicesByFamilyId(familyId: familyId).get();
  }

  Stream<List<Service>> findAllActiveByFamilyIdAsStream(String familyId) {
    return db.activeServicesByFamilyId(familyId: familyId).watch();
  }

  Future<List<Service>> findBySubFamilyId(String subFamilyId) async {
    return _queryBySubFamilyId(subFamilyId).get();
  }

  Stream<List<Service>> findBySubFamilyIdAsStream(String subFamilyId) {
    return _queryBySubFamilyId(subFamilyId).watch();
  }

  SimpleSelectStatement<$ServicesTable, Service> _queryAllActiveBySubFamilyId(
      String subFamilyId) {
    // Join with service sub families and services, count active services
    return (select(services)
      ..where(
          (tbl) => tbl.subFamilyId.equals(subFamilyId) & tbl.status.equals(1)));
  }

  Stream<List<Service>> findAllActiveBySubFamilyIdAsStream(String subFamilyId) {
    return _queryAllActiveBySubFamilyId(subFamilyId).watch();
  }

  Selectable<Service> _queryByDiscountCodeId(String discountCodeId) {
    return db.servicesByDiscountId(discountCodeId: discountCodeId);
  }

  Future<List<Service>> findByDiscountCodeId(String discountCodeId) async {
    return _queryByDiscountCodeId(discountCodeId).get();
  }

  Stream<List<Service>> findByDiscountCodeIdAsStream(String discountCodeId) {
    return _queryByDiscountCodeId(discountCodeId).watch();
  }
}
