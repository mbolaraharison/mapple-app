import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(OrderContact)
class OrdersContacts extends Table {
  TextColumn get orderId => text().references(Orders, #id)();
  TextColumn get contactId => text().references(Contacts, #id)();

  @override
  Set<Column> get primaryKey => {orderId, contactId};
}
