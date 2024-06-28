import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class HomeTabScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class HomeTabScreen extends StatefulWidget implements HomeTabScreenInterface {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  // Navigators:----------------------------------------------------------------
  final HomeTabNavigatorInterface _homeTabNavigator =
      getIt<HomeTabNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _homeTabNavigator.key,
      initialRoute: _homeTabNavigator.rootRoute,
      onGenerateRoute: _homeTabNavigator.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
