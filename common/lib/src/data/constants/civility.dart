import 'package:easy_localization/easy_localization.dart';
import 'package:collection/collection.dart';

enum Civility {
  mister('civility_abbreviation_mister', 1),
  madam('civility_abbreviation_madam', 2),
  society('civility_abbreviation_society', 3);

  const Civility(this.abbreviationKey, this.value);

  final String abbreviationKey;
  final int value;

  String get abbreviation => abbreviationKey.tr();

  static Civility fromValue(int value) {
    final civility =
        Civility.values.firstWhereOrNull((element) => element.value == value);

    if (civility == null) {
      return Civility.mister;
    }

    return civility;
  }
}
