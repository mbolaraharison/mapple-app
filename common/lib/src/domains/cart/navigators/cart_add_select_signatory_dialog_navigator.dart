import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CartAddSelectSignatoryDialogNavigatorInterface {
  // Key
  GlobalKey<NavigatorState> get key;

  // Routes
  String get selectSignatory;

  String get createOrEditContact;

  // Methods
  Route<dynamic> onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class CartAddSelectSignatoryDialogNavigator
    implements CartAddSelectSignatoryDialogNavigatorInterface {
  // Key:-----------------------------------------------------------------------
  @override
  final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'cartAddSelectSignatoryNavigatorKey');

  // Routes:--------------------------------------------------------------------
  @override
  final String selectSignatory = 'add-signatory';
  @override
  final String createOrEditContact = 'create-or-edit-contact';

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == selectSignatory) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CartSelectSignatoryWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == createOrEditContact) {
      final args = settings.arguments as CartCreateOrEditContactArguments;

      return CupertinoPageRoute(
        builder: (_) =>
            getIt<CartCreateOrEditContactWidgetInterface>(param1: args),
        settings: settings,
      );
    } else {
      return CupertinoPageRoute(
        builder: (_) => getIt<CartSelectSignatoryWidgetInterface>(),
        settings: settings,
      );
    }
  }
}
