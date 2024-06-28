import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class NoteFirestoreDao extends AbstractFirestoreDao<Note> {
  @override
  String collectionName = 'notes';

  @override
  CollectionReference<Note> get collection =>
      db.collection(collectionName).withConverter<Note>(
            fromFirestore: Note.fromFirestore,
            toFirestore: (Note c, options) => c.toFirestore(),
          );

  Future<List<Note>> getAllByRepresentativeIdByCustomerId(
      String representativeId, String customerId) async {
    return (await collection
            .where('representativeId', isEqualTo: representativeId)
            .where('customerId', isEqualTo: customerId)
            .get()
            .then((QuerySnapshot<Note> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }

  Future<List<Note>> getAllByRepresentativeId(String representativeId) async {
    return (await collection
            .where('representativeId', isEqualTo: representativeId)
            .get()
            .then((QuerySnapshot<Note> snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }
}
