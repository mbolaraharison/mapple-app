import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Theme:-----------------------------------------------------------------------
abstract class OrderStatusThemeInterface {
  OrderStatusThemeInterface._(this.icons, this.colors);

  final Map<OrderStatus, String> icons;

  final Map<OrderStatus, List<Color>> colors;
}

// Enum:------------------------------------------------------------------------
enum OrderStatus {
  A('order_status.pending_approval'),
  B('order_status.progress'),
  C('order_status.suspended'),
  D('order_status.cancelled'),
  E('order_status.completed'),
  Z('order_status.quote_in_progress'); // Default value: must not be sent to Sage

  const OrderStatus(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  OrderStatusThemeInterface get _theme => getIt<OrderStatusThemeInterface>();

  String get icon => _theme.icons[this]!;

  List<Color> get colors => _theme.colors[this]!;

  bool get displayedOnMap =>
      [OrderStatus.B, OrderStatus.E, OrderStatus.Z].contains(this);
}
