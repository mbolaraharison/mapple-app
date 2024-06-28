import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class SiteSheetFirestoreDao extends AbstractFirestoreDao<SiteSheet> {
  late final UuidUtilsInterface uuidUtils = getIt<UuidUtilsInterface>();

  @override
  String collectionName = 'siteSheets';

  @override
  CollectionReference<SiteSheet> get collection =>
      db.collection(collectionName).withConverter<SiteSheet>(
            fromFirestore: SiteSheet.fromFirestore,
            toFirestore: (SiteSheet ss, options) => ss.toFirestore(),
          );

  Future<SiteSheet> getOrCreateByOrderId(String orderId) async {
    SiteSheet? siteSheet = await collection
        .where('orderId', isEqualTo: orderId)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).firstOrNull);

    if (siteSheet == null) {
      siteSheet = SiteSheet(id: uuidUtils.generate(), orderId: orderId);
      await collection.doc(siteSheet.id).set(siteSheet);
    }

    return siteSheet;
  }

  Future<int> getNextVersion(SiteSheet siteSheet) async {
    final docRef = collection.doc(siteSheet.id);
    return await db.runTransaction<int>((transaction) {
      return transaction.get(docRef).then((doc) {
        final currentVersion = doc.get('version') ?? 0;
        final nextVersion = currentVersion + 1;
        transaction.update(docRef, {'version': nextVersion});
        return nextVersion;
      });
    });
  }
}
