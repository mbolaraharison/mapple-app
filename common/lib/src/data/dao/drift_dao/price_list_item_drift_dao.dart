import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'price_list_item_drift_dao.g.dart';

@DriftAccessor(tables: [PriceListItems])
class PriceListItemDriftDao extends AbstractDriftDao<PriceListItem,
    $PriceListItemsTable, AgencyDatabase> with _$PriceListItemDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  PriceListItemDriftDao(AgencyDatabase db) : super(db, db.priceListItems);

  SimpleSelectStatement<$PriceListItemsTable, PriceListItem>
      _queryByPriceListId(String priceListId) {
    return (select(priceListItems)
      ..where((tbl) => tbl.priceListId.equals(priceListId)));
  }

  Future<List<PriceListItem>> findByPriceListId(String priceListId) async {
    return _queryByPriceListId(priceListId).get();
  }

  Stream<List<PriceListItem>> findByPriceListIdAsStream(String priceListId) {
    return _queryByPriceListId(priceListId).watch();
  }

  @override
  Future<List<PriceListItem>> findAllByAgencyIdOrNullAgencyId(
      String agencyId) async {
    return (select(priceListItems)
          ..where(
              (tbl) => tbl.agencyId.equals(agencyId) | tbl.agencyId.isNull()))
        .get();
  }
}
