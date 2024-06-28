import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:maple_common/maple_common.dart';

class OrderFirestoreDao extends AbstractFirestoreDao<Order> {
  @override
  String collectionName = 'orders';

  @override
  CollectionReference<Order> get collection =>
      db.collection(collectionName).withConverter<Order>(
            fromFirestore: Order.fromFirestore,
            toFirestore: (Order o, options) => o.toFirestore(),
          );

  // Get all orders by representativeId
  Future<List<Order>> getAllByRepresentativeId(String representativeId) async {
    List<Order> ordersWithRepresentative1Id = await collection
        .where('representative1Id', isEqualTo: representativeId)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());

    List<Order> ordersWithRepresentative2Id = await collection
        .where('representative2Id', isEqualTo: representativeId)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());

    List<Order> ordersWithRepresentative3Id = await collection
        .where('representative3Id', isEqualTo: representativeId)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());

    // Remove duplicates
    ordersWithRepresentative2Id.removeWhere((element) =>
        ordersWithRepresentative1Id.any((e) => e.id == element.id));
    ordersWithRepresentative3Id.removeWhere((element) =>
        ordersWithRepresentative1Id.any((e) => e.id == element.id) ||
        ordersWithRepresentative2Id.any((e) => e.id == element.id));

    return ordersWithRepresentative1Id +
        ordersWithRepresentative2Id +
        ordersWithRepresentative3Id;
  }

  Future<Order> getCurrentByProjectId(String projectId) async {
    return await collection
        .where('projectId', isEqualTo: projectId)
        .where('status', isNotEqualTo: 'closed')
        .limit(1)
        .get()
        .then((QuerySnapshot<Order> snapshot) {
      return snapshot.docs[0].data();
    });
  }
}
