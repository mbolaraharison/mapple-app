import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class ServiceFamilyFirestoreDao extends AbstractFirestoreDao<ServiceFamily> {
  @override
  String collectionName = 'serviceFamilies';

  @override
  CollectionReference<ServiceFamily> get collection =>
      db.collection(collectionName).withConverter<ServiceFamily>(
            fromFirestore: ServiceFamily.fromFirestore,
            toFirestore: (ServiceFamily f, options) => f.toFirestore(),
          );
}
