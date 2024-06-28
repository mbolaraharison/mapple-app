import 'package:flutter/widgets.dart';

// Interface:-------------------------------------------------------------------
abstract class DeviceUtilsInterface {
  hideKeyboard(BuildContext context);
}

// Implementation:--------------------------------------------------------------
class DeviceUtils implements DeviceUtilsInterface {
  @override
  hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
