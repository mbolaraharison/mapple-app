import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerTabNavigatorInterface {
  // Key
  GlobalKey<NavigatorState> get key;

  // Routes
  String get rootRoute;
  String get viewRoute;
  String get viewProjectRoute;
  String get viewProjectStreetViewRoute;
  String get servicesRoute;
  String get servicesSearchRoute;
  String get mediasRoute;
  String get cartRoute;
  String get siteSheetRoute;

  // Methods
  Route<dynamic>? onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class CustomerTabNavigator implements CustomerTabNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'CustomerTabNavigatorKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String rootRoute = '/';
  @override
  final String viewRoute = '/view';
  @override
  final String viewProjectRoute = '/view-project';
  @override
  final String viewProjectStreetViewRoute = '/view-project-street-view';
  @override
  final String servicesRoute = '/services';
  @override
  final String servicesSearchRoute = '/services/search';
  @override
  final String mediasRoute = '/media';
  @override
  final String cartRoute = '/cart';
  @override
  final String siteSheetRoute = '/site-sheet';

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == rootRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerListScreenInterface>(),
        settings: settings,
      );
    } else if (settings.name == viewRoute) {
      final args = settings.arguments as CustomerViewScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerViewScreenInterface>(param1: args),
        settings: settings,
      );
    } else if (settings.name == viewProjectRoute) {
      final args = settings.arguments as CustomerViewProjectScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerViewProjectScreenInterface>(param1: args),
        settings: settings,
      );
    } else if (settings.name == viewProjectStreetViewRoute) {
      final args =
          settings.arguments as CustomerViewProjectStreetViewScreenArguments;

      return CupertinoPageRoute(
        builder: (_) =>
            getIt<CustomerViewProjectStreetViewScreenInterface>(param1: args),
        settings: settings,
      );
    } else if (settings.name == servicesRoute) {
      final args = settings.arguments as CustomerServicesScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerServicesScreenInterface>(param1: args),
        settings: settings,
      );
    } else if (settings.name == servicesSearchRoute) {
      final args = settings.arguments as CustomerServicesSearchScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerServicesSearchScreenInterface>(
          param1: args,
        ),
        settings: settings,
      );
    } else if (settings.name == mediasRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerMediaScreenInterface>(),
        settings: settings,
      );
    } else if (settings.name == cartRoute) {
      final args = settings.arguments as CustomerCartScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerCartScreenInterface>(
          param1: args,
        ),
        settings: settings,
      );
    } else if (settings.name == siteSheetRoute) {
      final args = settings.arguments as CustomerSiteSheetScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<CustomerSiteSheetScreenInterface>(param1: args),
        settings: settings,
      );
    }

    return null;
  }
}
