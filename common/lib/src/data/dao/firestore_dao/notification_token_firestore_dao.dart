import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class NotificationTokenFirestoreDao
    extends AbstractFirestoreDao<NotificationToken> {
  @override
  String collectionName = 'notificationTokens';

  @override
  CollectionReference<NotificationToken> get collection =>
      db.collection(collectionName).withConverter<NotificationToken>(
            fromFirestore: NotificationToken.fromFirestore,
            toFirestore: (NotificationToken c, options) => c.toFirestore(),
          );

  Future<NotificationToken?> findOneByDeviceIdAndByRepresentativeId(
      String deviceId, String representativeId) async {
    final query = await collection
        .where('deviceId', isEqualTo: deviceId)
        .where('representativeId', isEqualTo: representativeId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      return null;
    }

    return query.docs.first.data();
  }
}
