import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AddEditProjectNavigatorInterface {
  // Constructor:---------------------------------------------------------------
  AddEditProjectNavigatorInterface._(
    this.addEditInfos,
    this.selectAddress,
    this.selectMeetingOrigin,
  );

  // Key:-----------------------------------------------------------------------
  GlobalKey<NavigatorState> get key;

  // Routes:--------------------------------------------------------------------
  final String addEditInfos;
  final String selectAddress;
  final String selectMeetingOrigin;

  // Methods:-------------------------------------------------------------------
  Route<dynamic> onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class AddEditProjectNavigator implements AddEditProjectNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'addEditProjectOrderKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String addEditInfos = 'add-edit-infos';
  @override
  final String selectAddress = 'select-address';
  @override
  final String selectMeetingOrigin = 'select-meeting-origin';

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == addEditInfos) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AddEditProjectInfosWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == selectAddress) {
      final args = settings.arguments as SelectAddressArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<AddressWidgetInterface>(
          param1: AddressProps(store: args.store),
        ),
        settings: settings,
      );
    } else if (settings.name == selectMeetingOrigin) {
      return CupertinoPageRoute(
        builder: (_) =>
            getIt<AddEditProjectSelectMeetingOriginWidgetInterface>(),
        settings: settings,
      );
    } else {
      return CupertinoPageRoute(
        builder: (_) => getIt<AddEditProjectInfosWidgetInterface>(),
        settings: settings,
      );
    }
  }
}
