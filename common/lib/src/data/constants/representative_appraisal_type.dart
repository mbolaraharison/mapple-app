// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum RepresentativeAppraisalType {
  FIRST_MONTH('representative_appraisal_type.firstMonth'),
  SECOND_MONTH('representative_appraisal_type.secondMonth'),
  THIRD_MONTH('representative_appraisal_type.thirdMonth'),
  SIXTH_MONTH('representative_appraisal_type.sixthMonth'),
  ANNUAL('representative_appraisal_type.annual');

  const RepresentativeAppraisalType(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static RepresentativeAppraisalType fromValue(String value) {
    return RepresentativeAppraisalType.values.firstWhere((e) => e.name == value,
        orElse: () => RepresentativeAppraisalType.ANNUAL);
  }

  static Map<RepresentativeAppraisalType, String>
      get representativeAppraisalNames => {
            RepresentativeAppraisalType.FIRST_MONTH:
                'appraisal.periodic_appraisal'.tr(namedArgs: {
              'periodicity': 'appraisal.periodicities.first'.tr()
            }),
            RepresentativeAppraisalType.SECOND_MONTH:
                'appraisal.periodic_appraisal'.tr(namedArgs: {
              'periodicity': 'appraisal.periodicities.second'.tr()
            }),
            RepresentativeAppraisalType.THIRD_MONTH:
                'appraisal.periodic_appraisal'.tr(namedArgs: {
              'periodicity': 'appraisal.periodicities.third'.tr()
            }),
            RepresentativeAppraisalType.SIXTH_MONTH:
                'appraisal.periodic_appraisal'.tr(namedArgs: {
              'periodicity': 'appraisal.periodicities.sixth'.tr()
            }),
            RepresentativeAppraisalType.ANNUAL:
                'appraisal.annual_appraisal'.tr(),
          };

  static Map<RepresentativeAppraisalType, String> get periodicities => {
        RepresentativeAppraisalType.FIRST_MONTH:
            'appraisal.periodicities.first'.tr(),
        RepresentativeAppraisalType.SECOND_MONTH:
            'appraisal.periodicities.second'.tr(),
        RepresentativeAppraisalType.THIRD_MONTH:
            'appraisal.periodicities.third'.tr(),
        RepresentativeAppraisalType.SIXTH_MONTH:
            'appraisal.periodicities.sixth'.tr()
      };

  static Map<RepresentativeAppraisalType, DateTime> get maxSeniority => {
        RepresentativeAppraisalType.FIRST_MONTH: getDateTimeLessXMonths(1),
        RepresentativeAppraisalType.SECOND_MONTH: getDateTimeLessXMonths(2),
        RepresentativeAppraisalType.THIRD_MONTH: getDateTimeLessXMonths(3),
        RepresentativeAppraisalType.SIXTH_MONTH: getDateTimeLessXMonths(6)
      };

  static DateTime getDateTimeLessXMonths(int monthNumber) {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month - monthNumber, now.day);
  }
}
