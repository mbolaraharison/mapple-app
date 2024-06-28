import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class FairFirestoreDao extends AbstractFirestoreDao<Fair> {
  @override
  String collectionName = 'fairs';

  @override
  CollectionReference<Fair> get collection =>
      db.collection(collectionName).withConverter<Fair>(
            fromFirestore: Fair.fromFirestore,
            toFirestore: (Fair f, options) => f.toFirestore(),
          );

  Future<Fair?> getFirstByAgencyId(String agencyId) async {
    return await collection
        .where('agencyId', isEqualTo: agencyId)
        .limit(1)
        .get()
        .then((QuerySnapshot<Fair> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data();
      }
      return null;
    });
  }

  @override
  Future<List<Fair>> getAllByAgencyId(String agencyId) async {
    return (await collection
            .where('agencyId', isEqualTo: agencyId)
            .orderBy('openingDate')
            .get()
            .then((QuerySnapshot<Fair> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }
}
