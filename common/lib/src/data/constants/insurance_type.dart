import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum InsuranceType {
  death('insurance_type.death', 1),
  deathDisability('insurance_type.death_disability', 6),
  deathDisabilityIllness('insurance_type.death_disability_illness', 2),
  deathDisabilityIllnessUnemployment(
      'insurance_type.death_disability_illness_unemployment', 3),
  deathDisabilityIllnessRetirement(
      'insurance_type.death_disability_illness_retirement', 4),
  none('insurance_type.none', 5);

  const InsuranceType(this.labelKey, this.value);

  final String labelKey;
  final int value;

  String get label => labelKey.tr();

  static List<SelectChoice<InsuranceType>> get choices => InsuranceType.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();

  static InsuranceType fromValue(int value) {
    return InsuranceType.values
        .firstWhere((element) => element.value == value, orElse: () => none);
  }
}
