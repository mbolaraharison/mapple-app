import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum DiscountTypeChoice {
  commercialAdvantage(
      'cart.discounts_dialog.type_choices.commercial_advantage'),
  discountCode('cart.discounts_dialog.type_choices.discount_code');

  const DiscountTypeChoice(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static List<PickerChoice<DiscountTypeChoice>> get choices =>
      DiscountTypeChoice.values
          .map((e) => PickerChoice(value: e, label: e.label))
          .toList();
}
