import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AppraisalsNavigatorInterface {
  // Key
  GlobalKey<NavigatorState> get key;

  // Routes
  String get rootRoute;
  String get representativeAppraisalsRoute;
  String get fillAppraisalRoute;
  String get agenciesRoute;
  String get agencyRoute;

  // Methods
  Route<dynamic>? onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class AppraisalsNavigator implements AppraisalsNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'AppraisalNavigatorKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String rootRoute = '/';
  @override
  final String representativeAppraisalsRoute = '/representative-appraisals';
  @override
  final String fillAppraisalRoute = '/fill-appraisal';
  @override
  final String agenciesRoute = '/appraisal-agencies';
  @override
  final String agencyRoute = '/appraisal-agency';

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == rootRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<MainAppraisalsScreenInterface>(),
        settings: settings,
      );
    } else if (settings.name == representativeAppraisalsRoute) {
      RepresentativeAppraisalsScreenArguments args =
          settings.arguments as RepresentativeAppraisalsScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<RepresentativeAppraisalsScreenInterface>(
          param1: args,
        ),
        settings: settings,
      );
    } else if (settings.name == fillAppraisalRoute) {
      FillAppraisalScreenArguments args =
          settings.arguments as FillAppraisalScreenArguments;

      return CupertinoPageRoute(
        builder: (_) => getIt<FillAppraisalScreenInterface>(
          param1: args,
        ),
        settings: settings,
      );
    } else if (settings.name == agenciesRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<DirectorAppraisalAgenciesScreenInterface>(),
        settings: settings,
      );
    } else if (settings.name == agencyRoute) {
      final args = settings.arguments as DirectorAppraisalAgencyScreenArguments;

      return CupertinoPageRoute(
        builder: (_) =>
            getIt<DirectorAppraisalAgencyScreenInterface>(param1: args),
        settings: settings,
      );
    }

    return null;
  }
}
