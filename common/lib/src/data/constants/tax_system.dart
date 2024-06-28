// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/domains/ui/types/select_choice.dart';

enum TaxSystem {
  CEE('tax_systems.cee'), // CEE
  CPI('tax_systems.cpi'), // CPI
  DOM('tax_systems.dom_tom'), // DOM-TOM
  EXP('tax_systems.export'), // EXPORT
  FRA('tax_systems.france'), // FRANCE
  SPT('tax_systems.tax_suspension'); // TAX SUSPENSION

  const TaxSystem(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static List<SelectChoice<TaxSystem>> get choices => TaxSystem.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}
