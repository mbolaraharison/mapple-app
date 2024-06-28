import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CartNavigatorInterface {
  // Constructor:---------------------------------------------------------------
  CartNavigatorInterface._(
    this.cartOrder,
    this.cartPayment,
    this.cartFinalization,
    this.cartSignature,
  );

  // Routes:--------------------------------------------------------------------
  final String cartOrder;
  final String cartPayment;
  final String cartFinalization;
  final String cartSignature;

  // Methods:-------------------------------------------------------------------
  Route<dynamic> onGenerateRoute(RouteSettings settings);
}

// Implementation:--------------------------------------------------------------
class CartNavigator implements CartNavigatorInterface {
  // Routes:--------------------------------------------------------------------
  @override
  final String cartOrder = '/cart/order';
  @override
  final String cartPayment = '/cart/payment';
  @override
  final String cartFinalization = '/cart/finalization';
  @override
  final String cartSignature = '/cart/signature';

  // Methods:-------------------------------------------------------------------
  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == cartOrder) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CartOrderWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == cartPayment) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CartPaymentWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == cartFinalization) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CartFinalizationWidgetInterface>(),
        settings: settings,
      );
    } else if (settings.name == cartSignature) {
      return CupertinoPageRoute(
        builder: (_) => getIt<CartSignatureWidgetInterface>(),
        settings: settings,
      );
    } else {
      return CupertinoPageRoute(
        builder: (_) => getIt<CartOrderWidgetInterface>(),
        settings: settings,
      );
    }
  }
}
