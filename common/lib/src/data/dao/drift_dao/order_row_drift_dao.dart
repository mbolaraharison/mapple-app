import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'order_row_drift_dao.g.dart';

@DriftAccessor(tables: [OrderRows])
class OrderRowDriftDao
    extends AbstractDriftDao<OrderRow, $OrderRowsTable, AgencyDatabase>
    with _$OrderRowDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  OrderRowDriftDao(AgencyDatabase db) : super(db, db.orderRows);

  SimpleSelectStatement<$OrderRowsTable, OrderRow> _queryByOrderId(
      String orderId) {
    return (select(orderRows)..where((tbl) => tbl.orderId.equals(orderId)));
  }

  Future<List<OrderRow>> findByOrderId(String orderId) async {
    return _queryByOrderId(orderId).get();
  }

  Stream<List<OrderRow>> findByOrderIdAsStream(String orderId) {
    return _queryByOrderId(orderId).watch();
  }
}
