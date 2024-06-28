import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum Deferment {
  thirtyDays('deferment.thirty_days', 1),
  sixtyDays('deferment.sixty_days', 2),
  ninetyDays('deferment.ninety_days', 3),
  oneHundredTwentyDays('deferment.one_hundred_twenty_days', 4),
  oneHundredEightyDays('deferment.one_hundred_eighty_days', 5);

  const Deferment(this.labelKey, this.value);

  final String labelKey;
  final int value;

  String get label => labelKey.tr();

  static List<SelectChoice<Deferment>> get choices => Deferment.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();

  static Deferment fromValue(int value) {
    return Deferment.values.firstWhere((element) => element.value == value,
        orElse: () => Deferment.thirtyDays);
  }
}
