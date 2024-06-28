import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CreateProjectNavigatorInterface {
  // Key
  GlobalKey<NavigatorState> get key;

  // Routes
  String get selectTypeRoute;
  String get createCustomerRoute;
  String get howFindUsRoute;
  String get contactsRoute;
  String get addEditContactRoute;
  String get addressRoute;
  String get duplicatesRoute;

  // Methods
  Route<dynamic>? onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class CreateProjectNavigator implements CreateProjectNavigatorInterface {
  // Key
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'createProjectNavigatorKey');

  // Routes
  @override
  final String selectTypeRoute = 'project/create/select_type';
  @override
  final String createCustomerRoute = 'project/create/customer';
  @override
  final String howFindUsRoute = 'project/create/how_find_us';
  @override
  final String contactsRoute = 'project/create/contacts';
  @override
  final String addEditContactRoute = 'project/create/contacts/add-edit';
  @override
  final String addressRoute = 'project/create/address';
  @override
  final String duplicatesRoute = 'project/create/customer/duplicates';

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == selectTypeRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<SelectTypeWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == createCustomerRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CreateCustomerWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == howFindUsRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<HowFindUsWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == contactsRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<ContactsListWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == addEditContactRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<AddEditContactWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == addressRoute) {
      final args = settings.arguments as SelectAddressArguments;
      return CupertinoPageRoute(
        builder: (_) => getIt<AddressWidgetInterface>(
          param1: AddressProps(store: args.store),
        ),
        settings: settings,
      );
    } else if (settings.name == duplicatesRoute) {
      return CupertinoPageRoute(
        builder: (_) => getIt<ConfirmDuplicateWidgetInterface>(),
        settings: settings,
      );
    } else {
      assert(false, 'Need to implement ${settings.name}');
      return null;
    }
  }
}
