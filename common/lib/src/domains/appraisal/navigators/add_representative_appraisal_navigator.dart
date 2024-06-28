import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AddRepresentativeAppraisalNavigatorInterface {
  GlobalKey<NavigatorState> get key;

  String get home;
  String get selectType;

  Route<dynamic> onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class AddRepresentativeAppraisalNavigator
    implements AddRepresentativeAppraisalNavigatorInterface {
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'addRepresentativeAppraisalNavigatorKey');

  // Routes
  @override
  final String home = 'add-representative-appraisal';
  @override
  final String selectType = 'add-representative-appraisal/select-type';

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == home) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AddRepresentativeAppraisalHomeWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == selectType) {
      return CupertinoPageRoute(
        builder: (_) =>
            getIt<AddRepresentativeAppraisalSelectTypeWidgetInterface>(),
        settings: settings,
      );
    } else {
      return CupertinoPageRoute(
        builder: (_) => getIt<AddRepresentativeAppraisalHomeWidgetInterface>(),
        settings: settings,
      );
    }
  }
}
