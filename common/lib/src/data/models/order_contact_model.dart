import 'package:drift/drift.dart';

class OrderContact extends Insertable<OrderContact> {
  // Constructors:--------------------------------------------------------------
  OrderContact({
    required this.orderId,
    required this.contactId,
  });

  // Variables:-----------------------------------------------------------------
  String orderId;
  String contactId;

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'order_id': Variable<String>(orderId),
      'contact_id': Variable<String>(contactId),
    };
  }
}
