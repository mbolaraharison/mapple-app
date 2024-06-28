import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class EditCustomerDialogNavigatorInterface {
  // Key
  GlobalKey<NavigatorState> get key;

  // Routes
  String get editInfos;
  String get selectType;
  String get selectOrigin;

  // Methods
  Route<dynamic> onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class EditCustomerDialogNavigator
    implements EditCustomerDialogNavigatorInterface {
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'editCustomerDialogKey');

  // Routes
  @override
  final String editInfos = 'edit-infos';
  @override
  final String selectType = 'select-type';
  @override
  final String selectOrigin = 'select-origin';

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == editInfos) {
      return CupertinoPageRoute(
        builder: (_) => getIt<EditCustomerInfosWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == selectType) {
      return CupertinoPageRoute(
        builder: (_) => getIt<EditCustomerSelectTypeWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == selectOrigin) {
      return CupertinoPageRoute(
        builder: (_) => getIt<EditCustomerSelectOriginWidgetInterface>(),
        settings: settings,
      );
    } else {
      return CupertinoPageRoute(
        builder: (_) => getIt<EditCustomerInfosWidgetInterface>(),
        settings: settings,
      );
    }
  }
}
