import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RootNavigatorInterface {
  // Constructor:---------------------------------------------------------------
  RootNavigatorInterface._(
    this.key,
    this.loginRoute,
    this.mainRoute,
    this.resetPasswordRoute,
    this.routes,
    this.initialLinkIsHandled,
  );

  // Key:-----------------------------------------------------------------------
  final GlobalKey<NavigatorState> key;

  // Routes:--------------------------------------------------------------------
  final String loginRoute;
  final String mainRoute;
  final String resetPasswordRoute;
  final List<String> routes;

  // Other:---------------------------------------------------------------------
  StreamSubscription? linkSubscription;

  final bool initialLinkIsHandled;

  // Methods:-------------------------------------------------------------------
  Route<dynamic>? onGenerateRoute(RouteSettings settings);

  void listenDynamicLinks();

  void handleDynamicLink(PendingDynamicLinkData? data);

  void disposeSubscriptions();

  Future<void> handleInitialLink();
}

// Implementation:--------------------------------------------------------------
class RootNavigator implements RootNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String loginRoute = 'login';

  @override
  final String mainRoute = 'main';

  @override
  final String resetPasswordRoute = 'reset-password';

  @override
  late final List<String> routes = [
    loginRoute,
    mainRoute,
    resetPasswordRoute,
  ];

  // Other:---------------------------------------------------------------------
  @override
  StreamSubscription? linkSubscription;

  @override
  bool initialLinkIsHandled = false;

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == loginRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<LoginScreenInterface>(),
        settings: settings,
      );
    } else if (settings.name == resetPasswordRoute) {
      final args = settings.arguments as ResetPasswordScreenArguments;
      return CupertinoPageRoute(
        builder: (_) => getIt<ResetPasswordScreenInterface>(param1: args),
        settings: settings,
      );
    } else if (settings.name == mainRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<MainScreenInterface>(),
        settings: settings,
      );
    } else {
      assert(false, 'Need to implement ${settings.name}');
      return null;
    }
  }

  @override
  void listenDynamicLinks() {
    linkSubscription =
        FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData);
    });

    linkSubscription?.onError((error) {
      FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
      if (kDebugMode) {
        print('Dynamic link error: $error');
      }
    });
  }

  @override
  void handleDynamicLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;

    if (deepLink == null) {
      return;
    }

    if (deepLink.queryParameters['mode'] != null &&
        deepLink.queryParameters['mode'] == 'resetPassword') {
      final code = deepLink.queryParameters['oobCode'];
      if (code == null) {
        return;
      }
      key.currentState?.pushNamed(
        resetPasswordRoute,
        arguments: ResetPasswordScreenArguments(code: code),
      );
      return;
    }
  }

  @override
  void disposeSubscriptions() {
    linkSubscription?.cancel();
  }

  @override
  Future<void> handleInitialLink() async {
    if (initialLinkIsHandled) {
      return;
    }
    // Use AppLinks to get the initial link because FirebaseDynamicLinks not working on iOS
    final appLinks = AppLinks();
    final Uri? uri = await appLinks.getInitialAppLink();
    if (uri != null) {
      initialLinkIsHandled = true;
      try {
        final PendingDynamicLinkData? data =
            await FirebaseDynamicLinks.instance.getDynamicLink(uri);
        handleDynamicLink(data);
      } catch (e) {
        FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
        if (kDebugMode) {
          print('Dynamic link error: $e');
        }
      }
    }
  }
}
