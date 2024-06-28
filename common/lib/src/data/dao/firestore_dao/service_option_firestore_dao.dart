import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class ServiceOptionFirestoreDao extends AbstractFirestoreDao<ServiceOption> {
  @override
  String collectionName = 'serviceOptions';

  @override
  CollectionReference<ServiceOption> get collection =>
      db.collection(collectionName).withConverter<ServiceOption>(
            fromFirestore: ServiceOption.fromFirestore,
            toFirestore: (ServiceOption o, options) => o.toFirestore(),
          );

  Future<List<ServiceOption>> getAllByServiceId(String serviceId) async {
    return (await collection
            .where('serviceId', isEqualTo: serviceId)
            .get()
            .then((QuerySnapshot<ServiceOption> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }
}
