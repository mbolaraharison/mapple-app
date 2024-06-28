import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class HomeServicesScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class HomeServicesScreen extends StatelessWidget
    implements HomeServicesScreenInterface {
  // Constructor:---------------------------------------------------------------
  HomeServicesScreen({super.key});

  // Navigators:----------------------------------------------------------------
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getIt<ServicesFloatingButtonsWidgetInterface>(
          param1: ServicesFloatingButtonsProps(
        onSearchButtonPressed: () => Navigator.of(context).pushNamed(
          _customerTabNavigator.servicesSearchRoute,
        ),
      )),
      body: getIt<ServicesBrowserWidgetInterface>(
        param1: ServicesBrowserProps(),
      ),
    );
  }
}
