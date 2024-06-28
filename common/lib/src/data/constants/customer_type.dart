import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

// Theme:-----------------------------------------------------------------------
abstract class CustomerTypeThemeInterface {
  CustomerTypeThemeInterface._(this.icons, this.activeColors);

  final Map<CustomerType, String> icons;

  final Map<CustomerType, Color> activeColors;
}

// Enum:------------------------------------------------------------------------
enum CustomerType {
  individual('customer_type_individual'),
  professional('customer_type_professional');

  const CustomerType(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  CustomerTypeThemeInterface get _theme => getIt<CustomerTypeThemeInterface>();

  String get icon => _theme.icons[this]!;

  Color get activeColor => _theme.activeColors[this]!;

  static List<SelectChoice<CustomerType>> get choices => CustomerType.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}
