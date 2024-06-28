import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AppraisalsScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AppraisalsScreen extends StatefulWidget
    implements AppraisalsScreenInterface {
  const AppraisalsScreen({super.key});

  @override
  State<AppraisalsScreen> createState() => _AppraisalsScreenState();
}

class _AppraisalsScreenState extends State<AppraisalsScreen> {
  // Services:------------------------------------------------------------------
  final AgencyDatabase _agencyDatabase = getIt<AgencyDatabase>();

  // Navigators:----------------------------------------------------------------
  final AppraisalsNavigatorInterface _appraisalNavigatorInterface =
      getIt<AppraisalsNavigatorInterface>();

  // Variables:-----------------------------------------------------------------
  late StreamSubscription _currentRepresentativeSubscription;

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _currentRepresentativeSubscription =
        _agencyDatabase.representativeChangeStream.listen((_) {
      _appraisalNavigatorInterface.key.currentState
          ?.popUntil((route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _appraisalNavigatorInterface.key,
      initialRoute: _appraisalNavigatorInterface.rootRoute,
      onGenerateRoute: _appraisalNavigatorInterface.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    _currentRepresentativeSubscription.cancel();
    super.dispose();
  }
}
