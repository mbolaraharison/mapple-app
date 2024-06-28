import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class DocusignLogFirestoreDao extends AbstractFirestoreDao<DocusignLog> {
  @override
  String collectionName = 'docusignLogs';

  @override
  CollectionReference<DocusignLog> get collection =>
      db.collection(collectionName).withConverter<DocusignLog>(
            fromFirestore: DocusignLog.fromFirestore,
            toFirestore: (DocusignLog c, options) => c.toFirestore(),
          );
}
