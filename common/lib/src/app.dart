import 'package:maple_common/maple_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class AppInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class App extends StatelessWidget implements AppInterface {
  App({super.key});

  final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();

  final RootNavigatorInterface _rootNavigator = getIt<RootNavigatorInterface>();

  final AppInfoInterface _appInfo = getIt<AppInfoInterface>();

  @override
  Widget build(BuildContext context) {
    // Listen to dynamic links
    _rootNavigator.listenDynamicLinks();
    context.setLocale(_appInfo.defaultLocale);

    return Observer(
      name: 'global-observer',
      builder: (context) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          title: _appInfo.appName,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: getIt<AppThemeDataInterface>().themeData,
          navigatorKey: _rootNavigator.key,
          initialRoute: _authStore.isLoggedIn
              ? _rootNavigator.mainRoute
              : _rootNavigator.loginRoute,
          onGenerateRoute: _rootNavigator.onGenerateRoute,
        );
      },
    );
  }

  void dispose() {
    _rootNavigator.disposeSubscriptions();
  }
}
