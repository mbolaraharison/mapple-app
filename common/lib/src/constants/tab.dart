import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

enum Tab {
  home,
  customer,
  businessMonitoring,
  library,
  discountCodes,
  search,
  appraisals,
}

Map<Tab, Function> tabRedirectToRoot = {
  Tab.customer: () => getIt<CustomerTabNavigatorInterface>()
      .key
      .currentState!
      .popUntil(ModalRoute.withName(
          getIt<CustomerTabNavigatorInterface>().rootRoute)),
};
