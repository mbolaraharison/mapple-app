import 'package:maple_common/maple_common.dart';

enum PriceListUnit {
  fo('FOR'),
  jou('JOU'),
  m2('M2'),
  ml('ML'),
  un('UN');

  const PriceListUnit(this.labelKey);

  final String labelKey;

  static PriceListUnit? fromValue(String? value) {
    if (value == null) {
      return null;
    }
    return PriceListUnit.values
        .firstWhereOrNull((element) => element.labelKey == value);
  }

  bool get acceptsDecimals =>
      [PriceListUnit.m2, PriceListUnit.ml].contains(this);
}
