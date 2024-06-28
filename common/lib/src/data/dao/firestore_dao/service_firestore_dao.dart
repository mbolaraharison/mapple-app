import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class ServiceFirestoreDao extends AbstractFirestoreDao<Service> {
  @override
  String collectionName = 'services';

  @override
  CollectionReference<Service> get collection =>
      db.collection(collectionName).withConverter<Service>(
            fromFirestore: Service.fromFirestore,
            toFirestore: (Service s, options) => s.toFirestore(),
          );

  @override
  Future<List<Service>> getAllByAgencyIdOrNullAgencyId(String agencyId) async {
    final List<Service> services = await collection
        .where('agencyId', isNull: true)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());

    final List<Service> servicesWithAgencyId = await collection
        .where('agencyId', isEqualTo: agencyId)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());

    // Remove duplicates
    services.removeWhere((element) => servicesWithAgencyId.any((e) =>
        e.label == element.label && e.subFamilyId == element.subFamilyId));

    return services + servicesWithAgencyId;
  }
}
