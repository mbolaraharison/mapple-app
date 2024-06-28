import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class ServiceOptionItemFirestoreDao
    extends AbstractFirestoreDao<ServiceOptionItem> {
  @override
  String collectionName = 'serviceOptionItems';

  @override
  CollectionReference<ServiceOptionItem> get collection =>
      db.collection(collectionName).withConverter<ServiceOptionItem>(
            fromFirestore: ServiceOptionItem.fromFirestore,
            toFirestore: (ServiceOptionItem sf, options) => sf.toFirestore(),
          );
}
