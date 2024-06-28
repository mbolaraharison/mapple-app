import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'user_setting_drift_dao.g.dart';

@DriftAccessor(tables: [UserSettings])
class UserSettingDriftDao
    extends AbstractDriftDao<UserSetting, $UserSettingsTable, AgencyDatabase>
    with _$UserSettingDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  UserSettingDriftDao(AgencyDatabase db) : super(db, db.userSettings);

  SimpleSelectStatement<$UserSettingsTable, UserSetting> _queryFirstByUserId(
      String userId) {
    return select(userSettings)
      ..where((tbl) => tbl.userId.isValue(userId))
      ..limit(1);
  }

  Future<UserSetting?> getByUserId(String userId) async {
    return _queryFirstByUserId(userId).getSingleOrNull();
  }

  Stream<UserSetting?> getByUserIdAsStream(String userId) {
    return _queryFirstByUserId(userId).watchSingleOrNull();
  }
}
