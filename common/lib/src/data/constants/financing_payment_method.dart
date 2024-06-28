// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum FinancingPaymentMethod {
  CETELEM,
  DOMOFINANCE,
  FINANCO,
  SOFINCO,
  FI; // Old data

  String get label => 'financing_payment_method.$name'.tr();

  static FinancingPaymentMethod? fromValue(String? value) {
    if (value == null) {
      return null;
    }
    return FinancingPaymentMethod.values
        .firstWhereOrNull((element) => element.name == value);
  }

  static List<SelectChoice> get choices {
    // Return all except FI
    return FinancingPaymentMethod.values
        .where((e) => e != FinancingPaymentMethod.FI)
        .map((e) => SelectChoice(value: e, label: e.label))
        .toList();
  }
}
