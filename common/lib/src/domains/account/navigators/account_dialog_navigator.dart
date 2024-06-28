import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountDialogNavigatorInterface {
  GlobalKey<NavigatorState> get key;

  String get accountHome;
  String get accountInfos;
  String get accountInfosResetPassword;
  String get accountSelectAgency;
  String get accountSelectFair;
  String get accountAbout;

  Route<dynamic> onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class AccountDialogNavigator implements AccountDialogNavigatorInterface {
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'accountDialogNavigatorKey');

  // Routes
  @override
  final String accountHome = 'account';
  @override
  final String accountInfos = 'account/infos';
  @override
  final String accountInfosResetPassword = 'account/infos/reset-password';
  @override
  final String accountSelectAgency = 'account/select-agency';
  @override
  final String accountSelectFair = 'account/select-fair';
  @override
  final String accountAbout = 'account/about';

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == accountHome) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AccountHomeWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == accountInfos) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AccountInfosWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == accountInfosResetPassword) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AccountResetPasswordWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == accountSelectAgency) {
      return CupertinoPageRoute(
        builder: (_) => getIt<SelectAgencyWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == accountSelectFair) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AccountSelectFairWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == accountAbout) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AccountAboutWidgetInterface>(),
        settings: settings,
      );
    } else {
      return CupertinoPageRoute(
        builder: (_) => getIt<AccountHomeWidgetInterface>(),
        settings: settings,
      );
    }
  }
}
