import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerTabScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CustomerTabScreen extends StatefulWidget
    implements CustomerTabScreenInterface {
  const CustomerTabScreen({super.key});

  @override
  State<CustomerTabScreen> createState() => _CustomerTabScreenState();
}

class _CustomerTabScreenState extends State<CustomerTabScreen> {
  // Services:------------------------------------------------------------------
  final AgencyDatabase _agencyDatabase = getIt<AgencyDatabase>();

  // Navigators:----------------------------------------------------------------
  final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  // Variables:-----------------------------------------------------------------
  late StreamSubscription _currentRepresentativeSubscription;

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _currentRepresentativeSubscription =
        _agencyDatabase.representativeChangeStream.listen((_) {
      _customerTabNavigator.key.currentState
          ?.popUntil((route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _customerTabNavigator.key,
      initialRoute: _customerTabNavigator.rootRoute,
      onGenerateRoute: _customerTabNavigator.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    _currentRepresentativeSubscription.cancel();
    super.dispose();
  }
}
