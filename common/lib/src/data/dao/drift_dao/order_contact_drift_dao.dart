import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'order_contact_drift_dao.g.dart';

@DriftAccessor(tables: [OrdersContacts])
class OrderContactDriftDao
    extends AbstractDriftDao<OrderContact, $OrdersContactsTable, AgencyDatabase>
    with _$OrderContactDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  OrderContactDriftDao(AgencyDatabase db) : super(db, db.ordersContacts);

  Batch batchReplaceAllByOrderId(
      Batch batch, String orderId, List<OrderContact> orderContactsList) {
    batch.deleteWhere(
        ordersContacts, (t) => (t as dynamic).orderId.equals(orderId));
    batch.insertAllOnConflictUpdate(db.ordersContacts, orderContactsList);
    return batch;
  }

  Batch batchDeleteByOrderId(Batch batch, String orderId) {
    batch.deleteWhere(
        ordersContacts, (t) => (t as dynamic).orderId.equals(orderId));
    return batch;
  }

  Future<void> deleteByOrderIdAndContactId(
      String orderId, String contactId) async {
    await (delete(ordersContacts)
          ..where((t) => (t as dynamic).orderId.equals(orderId))
          ..where((t) => (t as dynamic).contactId.equals(contactId)))
        .go();
  }

  Future<List<OrderContact>> findByContactId(String contactId) async {
    return (select(ordersContacts)
          ..where((t) => (t as dynamic).contactId.equals(contactId)))
        .get();
  }

  Stream<List<OrderContact>> findByOrderIdAsStream(String orderId) {
    return (select(ordersContacts)
          ..where((t) => (t as dynamic).orderId.equals(orderId)))
        .watch();
  }
}
