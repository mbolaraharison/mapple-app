import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class AgencyFirestoreDao extends AbstractFirestoreDao<Agency> {
  @override
  String collectionName = 'agencies';

  @override
  CollectionReference<Agency> get collection =>
      db.collection(collectionName).withConverter<Agency>(
            fromFirestore: Agency.fromFirestore,
            toFirestore: (Agency a, options) => a.toFirestore(),
          );

  Future<int> getOrderFormNumberAndIncrement(
      DocumentReference<Agency> docRef) async {
    return await db.runTransaction<int>((transaction) async {
      int orderIncrement = 0;
      await transaction.get(docRef).then((DocumentSnapshot<Agency> snapshot) {
        int orderFormNextIncrement = snapshot.data()!.orderFormNextIncrement;
        transaction.update(
            docRef, {'orderFormNextIncrement': orderFormNextIncrement + 1});
        orderIncrement = orderFormNextIncrement;
      });
      return orderIncrement;
    });
  }

  Future<List<Agency>> getAllThatHaveAccessToAppraisalModuleByIds(
      List<String> ids) async {
    return await collection
        .where(FieldPath.documentId, whereIn: ids)
        .where('canAccessRepresentativeAppraisalModule', isEqualTo: true)
        .get()
        .then((QuerySnapshot<Agency> snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList(growable: false);
    });
  }
}
