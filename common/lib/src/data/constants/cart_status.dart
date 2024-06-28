import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

enum CartStatus {
  order,
  payment,
  finalization,
  signature,
  closed;

  int get step => index + 1;

  Widget get widget {
    switch (this) {
      case CartStatus.order:
        return getIt<CartOrderWidgetInterface>();
      case CartStatus.payment:
        return getIt<CartPaymentWidgetInterface>();
      case CartStatus.finalization:
        return getIt<CartFinalizationWidgetInterface>();
      case CartStatus.signature:
        return getIt<CartSignatureWidgetInterface>();
      default:
        throw Exception('CartStatus $this not implemented');
    }
  }

  static CartStatus fromStep(int step) {
    return CartStatus.values[step - 1];
  }
}
