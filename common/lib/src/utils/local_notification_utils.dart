import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Interface:-------------------------------------------------------------------
abstract class LocalNotificationUtilsInterface {
  Future<void> init();
  Future<void> showNotificationIos(String title, String value);
}

// Implementation:--------------------------------------------------------------
class LocalNotificationUtils implements LocalNotificationUtilsInterface {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> init() async {
    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // This method is for iOS
  @override
  Future<void> showNotificationIos(String title, String value) async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    int notificationId = 1;

    const NotificationDetails notificationDetails = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
        notificationId, title, value, notificationDetails,
        payload: 'Not present');
  }
}
