import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class ServiceSubFamilyFirestoreDao
    extends AbstractFirestoreDao<ServiceSubFamily> {
  @override
  String collectionName = 'serviceSubFamilies';

  @override
  CollectionReference<ServiceSubFamily> get collection =>
      db.collection(collectionName).withConverter<ServiceSubFamily>(
            fromFirestore: ServiceSubFamily.fromFirestore,
            toFirestore: (ServiceSubFamily sf, options) => sf.toFirestore(),
          );

  Future<List<ServiceSubFamily>> getAllByFamilyId(String familyId) async {
    return (await collection
            .where('familyId', isEqualTo: familyId)
            .get()
            .then((QuerySnapshot<ServiceSubFamily> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }
}
