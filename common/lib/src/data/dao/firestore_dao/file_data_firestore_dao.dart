import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:maple_common/maple_common.dart';

class FileDataFirestoreDao extends AbstractFirestoreDao<FileData>
    with PrivateDirectoryMixin {
  // Variables:-----------------------------------------------------------------
  @override
  String collectionName = 'fileData';

  // Getters:-------------------------------------------------------------------
  @override
  CollectionReference<FileData> get collection =>
      db.collection(collectionName).withConverter<FileData>(
            fromFirestore: FileData.fromFirestore,
            toFirestore: (FileData c, options) => c.toFirestore(),
          );

  // Methods:-------------------------------------------------------------------
  Future<void> uploadFile(String filename, File file) async {
    await FirebaseStorage.instance.ref().child(filename).putFile(file);
  }

  Future<void> downloadFile(FileData fileData) async {
    await downloadFileByUniqueName(fileData.uniqueName);
  }

  Future<void> downloadFileByUniqueName(String uniqueName) async {
    try {
      Directory directory = await privateDirectory;
      File file = File('${directory.path}/$uniqueName');
      Reference fileReference =
          FirebaseStorage.instance.ref().child(uniqueName);
      await fileReference.writeToFile(file);
    } on FirebaseException catch (e) {
      log('error downloading a file : ${e.message}');
    }
  }

  Future<FileData?> findByUniqueName(String uniqueName) async {
    QuerySnapshot<FileData> querySnapshot =
        await collection.where('uniqueName', isEqualTo: uniqueName).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    }
    return null;
  }

  Future<List<FileData>> findByFamilyId(String familyId) async {
    return (await collection
            .where('familyId', isEqualTo: familyId)
            .get()
            .then((QuerySnapshot<FileData> result) {
      return result.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }

  Future<void> deleteById(String id) async {
    await collection.doc(id).delete();
  }
}
