import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CartTermsNavigatorInterface {
  // Key
  GlobalKey<NavigatorState> get key;

  // Routes
  String get acceptTerms;
  String get signature;

  // Methods
  Route<dynamic>? onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class CartTermsNavigator implements CartTermsNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'cartTermsNavigatorKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String acceptTerms = 'terms/accept';
  @override
  final String signature = 'terms/signature';

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == acceptTerms) {
      return CupertinoPageRoute(
        builder: (_) => getIt<TermsDialogWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == signature) {
      final args = settings.arguments as TermsSelectSignatureMethodArguments;
      return CupertinoPageRoute(
        builder: (_) =>
            getIt<TermsSelectSignatureMethodWidgetInterface>(param1: args),
        settings: settings,
      );
    } else {
      assert(false, 'Need to implement ${settings.name}');
      return null;
    }
  }
}
