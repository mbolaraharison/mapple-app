import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class CustomerFirestoreDao extends AbstractFirestoreDao<Customer> {
  @override
  String collectionName = 'customers';

  @override
  CollectionReference<Customer> get collection =>
      db.collection(collectionName).withConverter<Customer>(
            fromFirestore: Customer.fromFirestore,
            toFirestore: (Customer c, options) => c.toFirestore(),
          );

  // Get all customers by representativeId
  Future<List<Customer>> getAllByRepresentativeId(
      String representativeId) async {
    List<Customer> customersWithRepresentative1Id = await collection
        .where('representative1Id', isEqualTo: representativeId)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());

    List<Customer> customersWithRepresentative2Id = await collection
        .where('representative2Id', isEqualTo: representativeId)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());

    // Remove duplicates
    customersWithRepresentative2Id.removeWhere((element) =>
        customersWithRepresentative1Id.any((e) => e.id == element.id));

    return customersWithRepresentative1Id + customersWithRepresentative2Id;
  }

  Future<int> getQuoteFormNumberAndIncrement(
      DocumentReference<Customer> docRef) async {
    return await db.runTransaction<int>((transaction) async {
      int quoteIncrement = 1;
      await transaction.get(docRef).then((DocumentSnapshot<Customer> snapshot) {
        int quoteFormNextIncrement = snapshot.data()!.quoteFormNextIncrement;
        transaction.update(
            docRef, {'quoteFormNextIncrement': quoteFormNextIncrement + 1});
        quoteIncrement = quoteFormNextIncrement;
      });
      return quoteIncrement;
    });
  }
}
