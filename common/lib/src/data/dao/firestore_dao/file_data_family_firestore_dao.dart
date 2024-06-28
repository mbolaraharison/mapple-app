import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class FileDataFamilyFirestoreDao extends AbstractFirestoreDao<FileDataFamily> {
  @override
  String collectionName = 'fileDataFamilies';

  @override
  CollectionReference<FileDataFamily> get collection =>
      db.collection(collectionName).withConverter<FileDataFamily>(
            fromFirestore: FileDataFamily.fromFirestore,
            toFirestore: (FileDataFamily f, options) => f.toFirestore(),
          );
}
