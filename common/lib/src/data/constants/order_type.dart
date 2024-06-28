// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum OrderType {
  FOI('order_type.fair'),
  VAD('order_type.vad'),
  MAG('order_type.mag');

  const OrderType(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();
}
