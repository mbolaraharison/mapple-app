import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class HomeTabNavigatorInterface {
  // Key
  GlobalKey<NavigatorState> get key;

  // Routes
  String get rootRoute;
  String get servicesRoute;
  String get servicesSearchRoute;

  // Methods
  Route<dynamic>? onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class HomeTabNavigator implements HomeTabNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'HomeTabNavigatorKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String rootRoute = '/';
  @override
  final String servicesRoute = '/services';
  @override
  final String servicesSearchRoute = '/services/search';

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == rootRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<HomeScreenInterface>(),
        settings: settings,
      );
    } else if (settings.name == servicesRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<HomeServicesScreenInterface>(),
        settings: settings,
      );
    } else if (settings.name == servicesSearchRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<HomeServicesSearchScreenInterface>(),
        settings: settings,
      );
    }

    return null;
  }
}
