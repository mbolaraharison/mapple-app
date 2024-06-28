import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SyncNavigatorInterface {
  // Constructor:---------------------------------------------------------------
  SyncNavigatorInterface._(
    this.key,
    this.syncErrorRoute,
    this.agenciesRoute,
    this.routes,
  );

  // Key:-----------------------------------------------------------------------
  final GlobalKey<NavigatorState> key;

  // Routes:--------------------------------------------------------------------
  final String syncErrorRoute;
  final String agenciesRoute;
  final List<String> routes;

  // Methods:-------------------------------------------------------------------
  Route<dynamic>? onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class SyncNavigator implements SyncNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey<NavigatorState>(debugLabel: 'syncNavigatorKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String syncErrorRoute = 'sync-error';

  @override
  final String agenciesRoute = 'agencies';

  @override
  final List<String> routes = [
    'sync-error',
    'agencies',
  ];

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == syncErrorRoute) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => getIt<SyncErrorWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == agenciesRoute) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => getIt<SelectAgencyWidgetInterface>(),
        settings: settings,
      );
    } else {
      return null;
    }
  }
}
