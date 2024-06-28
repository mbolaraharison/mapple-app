import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class RepresentativeAppraisalFirestoreDao
    extends AbstractFirestoreDao<RepresentativeAppraisal> {
  @override
  String collectionName = 'representativeAppraisals';

  @override
  CollectionReference<RepresentativeAppraisal> get collection =>
      db.collection(collectionName).withConverter<RepresentativeAppraisal>(
            fromFirestore: RepresentativeAppraisal.fromFirestore,
            toFirestore: (RepresentativeAppraisal repAppraisal, options) =>
                repAppraisal.toFirestore(),
          );

  Stream<RepresentativeAppraisal?> getByIdAsStream(String id) {
    Stream<DocumentSnapshot<RepresentativeAppraisal>> query =
        collection.doc(id).snapshots();
    return query.map((DocumentSnapshot<RepresentativeAppraisal> snapshot) {
      if (snapshot.exists) {
        return snapshot.data();
      }
      return null;
    });
  }

  Stream<List<RepresentativeAppraisal>> getByAgencyIdAsStream(String agencyId) {
    return collection
        .where('agencyId', isEqualTo: agencyId)
        .where('deletedAt', isNull: true)
        .snapshots()
        .map((querySnapshot) {
      List<RepresentativeAppraisal> appraisals =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      appraisals.sort((a, b) => a.limitDate.compareTo(b.limitDate));
      return appraisals;
    });
  }

  Stream<List<RepresentativeAppraisal>> getByRepresentativeIdAsStream(
      String representativeId) {
    return collection
        .where('representativeId', isEqualTo: representativeId)
        .where('deletedAt', isNull: true)
        .snapshots()
        .map((QuerySnapshot<RepresentativeAppraisal> snapshot) {
      List<RepresentativeAppraisal> appraisals = snapshot.docs.map((e) {
        return e.data();
      }).toList();
      appraisals.sort((a, b) => a.limitDate.compareTo(b.limitDate));
      return appraisals;
    });
  }

  Stream<List<RepresentativeAppraisal>> getAllFullyCompletedAsStream(
      String representativeId) {
    return collection
        .where('representativeId', isEqualTo: representativeId)
        .where('deletedAt', isNull: true)
        .snapshots()
        .map((QuerySnapshot<RepresentativeAppraisal> snapshot) {
      List<RepresentativeAppraisal> appraisals = snapshot.docs
          .map((e) {
            return e.data();
          })
          .where((element) =>
              element.completedByDirectorAt != null &&
              element.completedByRepresentativeAt != null &&
              element.representativeAppraisalFormFileDataId != null)
          .toList();
      appraisals.sort((a, b) => b.limitDate.compareTo(a.limitDate));
      return appraisals;
    });
  }

  Future<List<RepresentativeAppraisal>>
      getNotCompletedByRepresentativeByRepresentativeId(
          String representativeId) async {
    return await collection
        .where('representativeId', isEqualTo: representativeId)
        .where('completedByRepresentativeAt', isNull: true)
        .where('deletedAt', isNull: true)
        .get()
        .then((QuerySnapshot<RepresentativeAppraisal> snapshot) {
      List<RepresentativeAppraisal> appraisals = snapshot.docs.map((e) {
        return e.data();
      }).toList();
      appraisals.sort((a, b) => a.limitDate.compareTo(b.limitDate));
      return appraisals;
    });
  }
}
