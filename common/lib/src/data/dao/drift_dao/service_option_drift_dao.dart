import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'service_option_drift_dao.g.dart';

@DriftAccessor(tables: [ServiceOptions])
class ServiceOptionDriftDao extends AbstractDriftDao<ServiceOption,
    $ServiceOptionsTable, AgencyDatabase> with _$ServiceOptionDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ServiceOptionDriftDao(AgencyDatabase db) : super(db, db.serviceOptions);

  SimpleSelectStatement<$ServiceOptionsTable, ServiceOption> _queryByServiceId(
      String serviceId) {
    return (select(serviceOptions)
      ..where((tbl) => tbl.serviceId.equals(serviceId)));
  }

  Future<List<ServiceOption>> findByServiceId(String serviceId) async {
    return _queryByServiceId(serviceId).get();
  }

  Stream<List<ServiceOption>> findByServiceIdAsStream(String serviceId) {
    return _queryByServiceId(serviceId).watch();
  }

  @override
  Future<List<ServiceOption>> findAllByAgencyIdOrNullAgencyId(
      String agencyId) async {
    return (select(serviceOptions)
          ..where(
              (tbl) => tbl.agencyId.equals(agencyId) | tbl.agencyId.isNull()))
        .get();
  }
}
