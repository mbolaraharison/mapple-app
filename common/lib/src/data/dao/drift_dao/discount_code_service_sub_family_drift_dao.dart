import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'discount_code_service_sub_family_drift_dao.g.dart';

@DriftAccessor(tables: [DiscountCodesServiceSubFamilies])
class DiscountCodeServiceSubFamilyDriftDao extends AbstractDriftDao<
    DiscountCodeServiceSubFamily,
    $DiscountCodesServiceSubFamiliesTable,
    AgencyDatabase> with _$DiscountCodeServiceSubFamilyDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  DiscountCodeServiceSubFamilyDriftDao(AgencyDatabase db)
      : super(db, db.discountCodesServiceSubFamilies);

  Future<void> deleteByDiscountCodeId(String discountCodeId) async {
    await (delete(discountCodesServiceSubFamilies)
          ..where((t) => t.discountCodeId.equals(discountCodeId)))
        .go();
  }

  Batch batchDeleteByDiscountCodeId(Batch batch, String discountCodeId) {
    batch.deleteWhere(discountCodesServiceSubFamilies,
        (t) => (t as dynamic)?.discountCodeId.equals(discountCodeId));

    return batch;
  }
}
