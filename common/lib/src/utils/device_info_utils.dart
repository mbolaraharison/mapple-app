import 'package:device_info_plus/device_info_plus.dart';

// Interface:-------------------------------------------------------------------
abstract class DeviceInfoUtilsInterface {
  Future<String?> getId();
}

// Implementation:--------------------------------------------------------------
class DeviceInfoUtils implements DeviceInfoUtilsInterface {
  @override
  Future<String?> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // This method is for iOS
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  }
}
