import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'price_list_drift_dao.g.dart';

@DriftAccessor(tables: [PriceLists])
class PriceListDriftDao
    extends AbstractDriftDao<PriceList, $PriceListsTable, AgencyDatabase>
    with _$PriceListDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  PriceListDriftDao(AgencyDatabase db) : super(db, db.priceLists);

  Future<List<PriceList>> findCurrentByAgencyIdAndServiceId(
      String agencyId, String serviceId) async {
    return (select(priceLists)
          ..where((tbl) =>
              (tbl.agencyId.isNull() | tbl.agencyId.equals(agencyId)) &
              tbl.serviceId.equals(serviceId) &
              tbl.startDate.isSmallerOrEqualValue(DateTime.now()) &
              tbl.endDate.isBiggerOrEqualValue(DateTime.now())))
        .get();
  }

  @override
  Future<List<PriceList>> findAllByAgencyIdOrNullAgencyId(
      String agencyId) async {
    return (select(priceLists)
          ..where(
              (tbl) => tbl.agencyId.equals(agencyId) | tbl.agencyId.isNull()))
        .get();
  }
}
