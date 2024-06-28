import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class UserSettingFirestoreDao extends AbstractFirestoreDao<UserSetting> {
  @override
  String collectionName = 'userSettings';

  @override
  CollectionReference<UserSetting> get collection =>
      db.collection(collectionName).withConverter<UserSetting>(
            fromFirestore: UserSetting.fromFirestore,
            toFirestore: (UserSetting us, options) => us.toFirestore(),
          );

  Future<UserSetting?> getByUserId(String userId) async {
    return await collection
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get()
        .then((QuerySnapshot<UserSetting> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data();
      }
      return null;
    });
  }
}
