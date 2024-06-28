import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'discount_code_service_drift_dao.g.dart';

@DriftAccessor(tables: [DiscountCodesServices])
class DiscountCodeServiceDriftDao extends AbstractDriftDao<
    DiscountCodeService,
    $DiscountCodesServicesTable,
    AgencyDatabase> with _$DiscountCodeServiceDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  DiscountCodeServiceDriftDao(AgencyDatabase db)
      : super(db, db.discountCodesServices);

  Future<void> deleteByDiscountCodeId(String discountCodeId) async {
    await (delete(discountCodesServices)
          ..where((t) => t.discountCodeId.equals(discountCodeId)))
        .go();
  }

  Batch batchDeleteByDiscountCodeId(Batch batch, String discountCodeId) {
    batch.deleteWhere(discountCodesServices,
        (t) => (t as dynamic)?.discountCodeId.equals(discountCodeId));

    return batch;
  }
}
