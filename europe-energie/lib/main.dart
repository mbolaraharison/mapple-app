import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'firebase_options.dart';
import 'di/service_locator.dart';

Future<void> main() async {
  return MapleCommon.init(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    preServiceLocatorSetupCallback: setupLocator,
  );
}
