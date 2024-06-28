import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class RepresentativeFirestoreDao extends AbstractFirestoreDao<Representative> {
  @override
  String collectionName = 'representatives';

  @override
  CollectionReference<Representative> get collection =>
      db.collection(collectionName).withConverter<Representative>(
            fromFirestore: Representative.fromFirestore,
            toFirestore: (Representative rep, options) => rep.toFirestore(),
          );

  Future<List<Representative>> getAllByIds(List<String> ids) async {
    // Load 10 by 10
    List<Representative> representativeByIds = [];
    for (int i = 0; i < ids.length; i += 10) {
      final List<Representative> representativesByOrderIds = (await collection
              .where(FieldPath.documentId,
                  whereIn:
                      ids.sublist(i, i + 10 > ids.length ? ids.length : i + 10))
              .get()
              .then((QuerySnapshot<Representative> snapshot) {
        return snapshot.docs.map((e) {
          return e.data();
        });
      }))
          .toList();

      representativeByIds.addAll(representativesByOrderIds);
    }

    return representativeByIds;
  }

  Stream<Representative?> getByIdAsStream(String id) {
    return collection
        .doc(id)
        .snapshots()
        .map((DocumentSnapshot<Representative> snapshot) {
      if (snapshot.exists) {
        return snapshot.data();
      }
      return null;
    });
  }

  Stream<Representative?> getFirstByEmailAgencyIdByRolesAsStream(
      String email, String agencyId, List<Role> roles) {
    return collection
        .where('email', isEqualTo: email)
        .where('agencyId', isEqualTo: agencyId)
        .where('profileCode', whereIn: roles.map((r) => r.value))
        .where('canAccessCRM', isEqualTo: true)
        .where('isActive', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((QuerySnapshot<Representative> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data();
      }
      return null;
    });
  }

  Future<Representative?> getFirstByEmail(String email) async {
    return await collection
        .where('email', isEqualTo: email)
        .where('canAccessCRM', isEqualTo: true)
        .where('isActive', isEqualTo: true)
        .limit(1)
        .get()
        .then((QuerySnapshot<Representative> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data();
      }
      return null;
    });
  }

  Future<Representative?> getByEmailByAgencyId(
      String email, String agencyId) async {
    return await collection
        .where('email', isEqualTo: email)
        .where('agencyId', isEqualTo: agencyId)
        .where('canAccessCRM', isEqualTo: true)
        .where('isActive', isEqualTo: true)
        .limit(1)
        .get()
        .then((QuerySnapshot<Representative> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data();
      }
      return null;
    });
  }

  Stream<List<Representative>> getSalesRepsByAgencyIdAsStream(String agencyId) {
    return collection
        .where('agencyId', isEqualTo: agencyId)
        .where('canAccessCRM', isEqualTo: true)
        .where('isActive', isEqualTo: true)
        .where('profileCode',
            whereIn: [Role.confirmedSalesRep.value, Role.juniorSalesRep.value])
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => doc.data())
            .toList(growable: false));
  }

  Query<Representative> findAllByEmail(String email, {List<Role>? roles}) {
    Query<Representative> query = collection
        .where('email', isEqualTo: email)
        .where('canAccessCRM', isEqualTo: true)
        .where('isActive', isEqualTo: true);

    if (roles != null && roles.isNotEmpty) {
      query = query.where('profileCode', whereIn: roles.map((r) => r.value));
    }

    return query;
  }

  Future<List<Representative>> getAllByEmail(String email,
      {List<Role>? roles}) async {
    Query<Representative> allByEmail = findAllByEmail(email, roles: roles);

    return await allByEmail
        .get()
        .then((QuerySnapshot<Representative> snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList(growable: false);
    });
  }

  Stream<List<Representative>> getAllByEmailAsStream(String email,
      {List<Role>? roles}) {
    Query<Representative> allByEmail = findAllByEmail(email, roles: roles);

    return allByEmail.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((doc) => doc.data()).toList(growable: false));
  }
}
