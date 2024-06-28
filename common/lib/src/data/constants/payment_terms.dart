// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum PaymentTerms {
  CB('payment_terms.credit_card'), // Credit card
  CETELEM('payment_terms.cetelem', isFunderStatus: true), // Cetelem
  CHQ('payment_terms.check1'), // Check 1
  CHQ2('payment_terms.check2'), // Check 2
  CHQ3('payment_terms.check3'), // Check 3
  DOMOFINANCE('payment_terms.domofinance', isFunderStatus: true), // Domofinance
  FINANCO('payment_terms.financo', isFunderStatus: true), // Financo
  FRESP('payment_terms.cash'), // Cash
  FRVIRCPT('payment_terms.bank_transfer'), // Bank transfer
  SOFINCO('payment_terms.sofinco', isFunderStatus: true), // Sofinco
  FI('payment_terms.fi', isFunderStatus: true); // Old data from Sage

  const PaymentTerms(this.labelKey, {this.isFunderStatus = false});

  final String labelKey;
  final bool isFunderStatus;

  String get label => labelKey.tr();

  static PaymentTerms fromValue(String? value) {
    if (value == null) {
      return CB;
    }
    return PaymentTerms.values
        .firstWhere((element) => element.name == value, orElse: () => CB);
  }
}
