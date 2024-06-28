import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

abstract class FirestoreDaoInterface<T extends AbstractBaseModel> {
  late final FirebaseFirestore db;

  late final String collectionName;

  CollectionReference<T> get collection;

  Future<List<T>> getAll();
}
