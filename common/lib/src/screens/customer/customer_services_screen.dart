import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerServicesScreenInterface implements Widget {
  CustomerServicesScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class CustomerServicesScreen extends StatelessWidget
    implements CustomerServicesScreenInterface {
  // Constructor:---------------------------------------------------------------
  CustomerServicesScreen({super.key, required this.arguments});

  @override
  final CustomerServicesScreenArguments arguments;

  // Navigators:----------------------------------------------------------------
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getIt<ServicesFloatingButtonsWidgetInterface>(
          param1: ServicesFloatingButtonsProps(
        customerOrderStore: arguments.customerOrderStore,
        onSearchButtonPressed: () => Navigator.of(context).pushNamed(
          _customerTabNavigator.servicesSearchRoute,
          arguments: CustomerServicesSearchScreenArguments(
            customerOrderStore: arguments.customerOrderStore,
          ),
        ),
        onCartButtonPressed: () => Navigator.of(context).pushNamed(
          _customerTabNavigator.cartRoute,
          arguments: CustomerCartScreenArguments(
            customerOrderStore: arguments.customerOrderStore,
          ),
        ),
      )),
      body: getIt<ServicesBrowserWidgetInterface>(
        param1: ServicesBrowserProps(
          customerOrderStore: arguments.customerOrderStore,
        ),
      ),
    );
  }
}
