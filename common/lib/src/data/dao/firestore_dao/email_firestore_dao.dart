import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class EmailFirestoreDao extends AbstractFirestoreDao<Email> {
  @override
  String collectionName = 'emails';

  @override
  CollectionReference<Email> get collection =>
      db.collection(collectionName).withConverter<Email>(
            fromFirestore: Email.fromFirestore,
            toFirestore: (Email c, options) => c.toFirestore(),
          );
}
