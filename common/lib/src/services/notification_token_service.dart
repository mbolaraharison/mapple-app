import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class NotificationTokenServiceInterface {
  Future<void> createOrUpdate(NotificationToken notificationToken);
}

// Implementation:--------------------------------------------------------------
class NotificationTokenService implements NotificationTokenServiceInterface {
  NotificationTokenFirestoreDao notificatioTokenDao =
      getIt<NotificationTokenFirestoreDao>();

  @override
  Future<void> createOrUpdate(NotificationToken notificationToken) async {
    final existing =
        await notificatioTokenDao.findOneByDeviceIdAndByRepresentativeId(
            notificationToken.deviceId, notificationToken.representativeId);
    if (existing == null) {
      await notificatioTokenDao.create(notificationToken);
    } else {
      if (existing.token != notificationToken.token) {
        existing.token = notificationToken.token;
        await notificatioTokenDao.update(existing);
      }
    }
  }
}
