import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'discount_code_drift_dao.g.dart';

@DriftAccessor(tables: [DiscountCodes])
class DiscountCodeDriftDao
    extends AbstractDriftDao<DiscountCode, $DiscountCodesTable, AgencyDatabase>
    with _$DiscountCodeDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  DiscountCodeDriftDao(AgencyDatabase db) : super(db, db.discountCodes);

  Selectable<DiscountCode> _queryAvailable(DateTime date) {
    // remove time from date and compare dates
    return db.availableDiscountCodes(date: date.toString());
  }

  Stream<List<DiscountCode>> findAvailableAsStream(DateTime date) {
    return _queryAvailable(date).watch();
  }

  Selectable<DiscountCode> _queryByCode(String code, DateTime date) {
    return db.availableDiscountCodesByCode(code: code, date: date.toString());
  }

  Future<DiscountCode?> findByCode(String code, DateTime date) {
    return _queryByCode(code, date).getSingleOrNull();
  }
}
