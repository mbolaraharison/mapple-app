// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum TaxLevel {
  NOR('tax_level.nor', 20), // 20%
  RED('tax_level.red', 5.5), // 5.5%
  RED10('tax_level.red10', 10), // 10%
  EXO('tax_level.exo', 0); // 0%

  const TaxLevel(this.labelKey, this.value);

  final String labelKey;
  final double value;

  String get label => labelKey.tr();

  static List<SelectChoice<TaxLevel>> get choices => TaxLevel.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();

  static List<PickerChoice<TaxLevel>> get pickerChoices => TaxLevel.values
      .map((e) => PickerChoice(value: e, label: e.label))
      .toList();
}
