import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'contact_drift_dao.g.dart';

@DriftAccessor(tables: [Contacts])
class ContactDriftDao
    extends AbstractDriftDao<Contact, $ContactsTable, AgencyDatabase>
    with _$ContactDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.

  ContactDriftDao(AgencyDatabase db) : super(db, db.contacts);

  SimpleSelectStatement<$ContactsTable, Contact> _queryByCustomerId(
      String customerId) {
    return (select(contacts)
      ..where((tbl) => tbl.customerId.equals(customerId)));
  }

  Future<List<Contact>> findByCustomerId(String customerId) async {
    return _queryByCustomerId(customerId).get();
  }

  Stream<List<Contact>> findByCustomerIdAsStream(String customerId) {
    return _queryByCustomerId(customerId).watch();
  }

  Selectable<Contact> _queryByOrderId(String orderId) {
    return db.contactsByOrderId(orderId: orderId);
  }

  Future<List<Contact>> findByOrderId(String orderId) async {
    List<Contact> contacts = await _queryByOrderId(orderId).get();
    return contacts;
  }

  Stream<List<Contact>> findByOrderIdAsStream(String orderId) {
    return _queryByOrderId(orderId).watch();
  }
}
