import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Interface:-------------------------------------------------------------------
abstract class NumberFormatterUtilsInterface {
  NumberFormatterUtilsInterface._(this.filteringDecimalOnly);

  final FilteringTextInputFormatter filteringDecimalOnly;

  String formatToCurrency(double number, {bool withSymbol = true});

  double parseToDouble(dynamic value);

  double? parseToDoubleOrNull(dynamic value);

  String formatToDoubleWith2Decimals(double number);

  String formatToDoubleWithNDecimals(double number, int n);

  String formatToInteger(num number);

  String formatToDouble(double number);

  String formatWithoutTrailingZeros(num number);
}

// Implementation:--------------------------------------------------------------
class NumberFormatterUtils implements NumberFormatterUtilsInterface {
  @override
  final filteringDecimalOnly = FilteringTextInputFormatter.allow(
    RegExp(r'^\d+(\.|,)?\d{0,2}'),
  );

  @override
  String formatToCurrency(double number, {bool withSymbol = true}) {
    if (withSymbol) {
      return NumberFormat.simpleCurrency(locale: 'fr_FR').format(number);
    }
    return NumberFormat.currency(locale: 'fr_FR', symbol: '').format(number);
  }

  @override
  double parseToDouble(dynamic value) {
    return double.parse(value.toString().replaceAll(',', '.'));
  }

  @override
  double? parseToDoubleOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    return double.tryParse(value.toString().replaceAll(',', '.'));
  }

  @override
  String formatToDoubleWith2Decimals(double number) {
    return NumberFormat('0.00').format(number);
  }

  @override
  String formatToDoubleWithNDecimals(double number, int n) {
    if (n < 0) {
      throw Exception('n must be positive');
    }
    if (n == 0) {
      return NumberFormat('0').format(number);
    } else {
      var formatString = '0.';
      for (var i = 0; i < n; i++) {
        formatString += '0';
      }
      return NumberFormat(formatString).format(number);
    }
  }

  @override
  String formatToInteger(num number) {
    return NumberFormat('0').format(number);
  }

  @override
  String formatToDouble(double number) {
    return number.toString().replaceAll('.', ',');
  }

  @override
  String formatWithoutTrailingZeros(num number) {
    String numberString = number.toString();
    return numberString
        .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")
        .replaceAll('.', ',');
  }
}
