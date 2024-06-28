import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'discount_code_service_family_drift_dao.g.dart';

@DriftAccessor(tables: [DiscountCodesServiceFamilies])
class DiscountCodeServiceFamilyDriftDao extends AbstractDriftDao<
    DiscountCodeServiceFamily,
    $DiscountCodesServiceFamiliesTable,
    AgencyDatabase> with _$DiscountCodeServiceFamilyDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  DiscountCodeServiceFamilyDriftDao(AgencyDatabase db)
      : super(db, db.discountCodesServiceFamilies);

  Future<void> deleteByDiscountCodeId(String discountCodeId) async {
    await (delete(discountCodesServiceFamilies)
          ..where((t) => t.discountCodeId.equals(discountCodeId)))
        .go();
  }

  Batch batchDeleteByDiscountCodeId(Batch batch, String discountCodeId) {
    batch.deleteWhere(discountCodesServiceFamilies,
        (t) => (t as dynamic)?.discountCodeId.equals(discountCodeId));

    return batch;
  }
}
