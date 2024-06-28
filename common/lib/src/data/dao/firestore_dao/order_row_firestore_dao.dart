import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class OrderRowFirestoreDao extends AbstractFirestoreDao<OrderRow> {
  @override
  String collectionName = 'orderRows';

  @override
  CollectionReference<OrderRow> get collection =>
      db.collection(collectionName).withConverter<OrderRow>(
            fromFirestore: OrderRow.fromFirestore,
            toFirestore: (OrderRow c, options) => c.toFirestore(),
          );

  Future<List<OrderRow>> getAllByOrderId(String orderId) async {
    return (await collection
            .where('orderId', isEqualTo: orderId)
            .get()
            .then((QuerySnapshot<OrderRow> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }
}
