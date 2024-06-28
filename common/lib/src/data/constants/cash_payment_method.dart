// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum CashPaymentMethod {
  CB, // Credit card
  CHQ, // Check 1
  CHQ2, // Check 2
  CHQ3, // Check 3
  FRESP, // Cash
  FRVIRCPT; // Bank transfer

  String get label => 'cash_payment_method.$name'.tr();

  static CashPaymentMethod? fromValue(String? value) {
    if (value == null) {
      return null;
    }
    return CashPaymentMethod.values
        .firstWhereOrNull((element) => element.name == value);
  }

  static List<SelectChoice> get choices => CashPaymentMethod.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}
