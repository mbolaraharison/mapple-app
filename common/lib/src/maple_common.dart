import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maple_common/maple_common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

class MapleCommon {
  static Future<void> init({
    String envFileName = ".env",
    required FirebaseOptions firebaseOptions,
    PreServiceLocatorSetupCallback? preServiceLocatorSetupCallback,
  }) async {
    return runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      // Load dotenv
      await dotenv.load(fileName: envFileName);

      // Initialize Firebase
      await Firebase.initializeApp(options: firebaseOptions);

      // Enable Crashlytics
      if (dotenv.env['ENABLE_CRASHLYTICS'] == 'true') {
        _initCrashlytics();
      }

      // Connect to Firebase emulators
      if (dotenv.env['USE_EMULATORS'] == 'true') {
        // ignore: avoid_print
        print('Connecting to Firebase emulators...');
        await _connectToFirebaseEmulator();
        // ignore: avoid_print
        print('Connected to Firebase emulators.');
      }

      // Set preferred orientations
      await _setPreferredOrientations();

      // Setup service locator
      await ServiceLocator.setupLocator(
        preSetupCallback: preServiceLocatorSetupCallback,
      );

      // Ask for firebase messaging permission
      _requestFirebaseMessagingPermission();

      LocalNotificationUtilsInterface localNotificationUtils =
          getIt<LocalNotificationUtilsInterface>();
      await localNotificationUtils.init();

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        await localNotificationUtils.showNotificationIos(
            message.notification?.title ?? '',
            message.notification?.body ?? '');
      });

      if (kDebugMode) {
        Directory directory = await getApplicationDocumentsDirectory();
        print('Application directory: ${directory.path}');
        Directory privateDirectory = await getLibraryDirectory();
        print('Private directory: ${privateDirectory.path}/Private');
      }

      _initAgencyDatabaseSync();

      tz.initializeTimeZones();
      await EasyLocalization.ensureInitialized();

      EasyLocalization.logger.enableBuildModes = [];

      if (kDebugMode) {
        print("MapleCommon initialized");
      }

      FirebaseStorage.instance
          .setMaxUploadRetryTime(const Duration(seconds: 5));
      runApp(
        EasyLocalization(
          supportedLocales: [
            getIt<AppInfoInterface>().defaultLocale,
            const Locale('fr')
          ],
          path: 'packages/maple_common/src/lang',
          fallbackLocale: const Locale('fr'),
          useFallbackTranslations: true,
          child: DefaultTextStyle(
            style: TextStyle(
              color: getIt<AppThemeDataInterface>().defaultTextColor,
            ),
            child: getIt<AppInterface>(),
          ),
        ),
      );
    }, (error, stack) {
      if (kDebugMode) {
        print(stack);
        print(error);
      }
    });
  }

  static void _initCrashlytics() {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> _requestFirebaseMessagingPermission() async {
    // This method is for iOS
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }

  static Future<void> _connectToFirebaseEmulator() async {
    FirebaseFirestore.instance.settings = const Settings(
      host: 'localhost:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }

  static Future<void> _setPreferredOrientations() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  static void _initAgencyDatabaseSync() async {
    await getIt.isReady<AgencyDatabase>();
    final agencyDatabase = getIt<AgencyDatabase>();
    agencyDatabase.initSync();
  }
}
