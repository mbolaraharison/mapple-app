import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class SupplierFirestoreDao extends AbstractFirestoreDao<Supplier> {
  @override
  String collectionName = 'suppliers';

  @override
  CollectionReference<Supplier> get collection =>
      db.collection(collectionName).withConverter<Supplier>(
            fromFirestore: Supplier.fromFirestore,
            toFirestore: (Supplier f, options) => f.toFirestore(),
          );

  @override
  Future<List<Supplier>> getAllByAgencyId(String agencyId) async {
    return (await collection
            .where('agencyId', isEqualTo: agencyId)
            .where('isActive', isEqualTo: true)
            .orderBy('name')
            .get()
            .then((QuerySnapshot<Supplier> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }
}
