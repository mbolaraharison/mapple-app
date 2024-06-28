import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'order_drift_dao.g.dart';

@DriftAccessor(tables: [Orders])
class OrderDriftDao
    extends AbstractDriftDao<Order, $OrdersTable, AgencyDatabase>
    with _$OrderDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  OrderDriftDao(AgencyDatabase db) : super(db, db.orders);

  SimpleSelectStatement<$OrdersTable, Order> _queryByCustomerId(
      String customerId) {
    return (select(orders)
      ..where((tbl) => tbl.customerId.equals(customerId))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)
      ]));
  }

  Future<List<Order>> findByCustomerId(String customerId) async {
    return _queryByCustomerId(customerId).get();
  }

  Stream<List<Order>> findByCustomerIdAsStream(String customerId) {
    return _queryByCustomerId(customerId).watch();
  }

  SimpleSelectStatement<$OrdersTable, Order> _queryByCustomerIdByStatus(
      String customerId, OrderStatus status) {
    return (select(orders)
      ..where((tbl) =>
          tbl.customerId.isValue(customerId) & tbl.status.isValue(status.name))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)
      ]));
  }

  Future<List<Order>> findByCustomerIdByStatus(
      String customerId, OrderStatus status) async {
    return _queryByCustomerIdByStatus(customerId, status).get();
  }
}
