import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class ContactFirestoreDao extends AbstractFirestoreDao<Contact> {
  @override
  String collectionName = 'contacts';

  @override
  CollectionReference<Contact> get collection =>
      db.collection(collectionName).withConverter<Contact>(
            fromFirestore: Contact.fromFirestore,
            toFirestore: (Contact c, options) => c.toFirestore(),
          );

  Future<List<Contact>> getAllByCustomerId(String customerId) async {
    return (await collection
            .where('customerId', isEqualTo: customerId)
            .get()
            .then((QuerySnapshot<Contact> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }
}
