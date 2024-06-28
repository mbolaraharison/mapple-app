// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/src/domains/ui/types/select_choice.dart';

enum Origin {
  COCLI('origin.customer_contact'), // Customer Contact
  COCOM('origin.canvassing'), // Canvassing
  FOIGA('origin.fair_gallery'), // Fair Gallery
  LEAD('origin.lead'); // Lead

  const Origin(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static List<SelectChoice<Origin>> get choices =>
      Origin.values.map((e) => SelectChoice(value: e, label: e.label)).toList();
}
