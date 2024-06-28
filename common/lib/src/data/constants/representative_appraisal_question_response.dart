// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum RepresentativeAppraisalQuestionResponse {
  NOT_MET('appraisal.edit.response.not_met'),
  IN_PROGRESS('appraisal.edit.response.in_progress'),
  ACHIEVED('appraisal.edit.response.achieved'),
  PROFICIENT('appraisal.edit.response.proficient');

  const RepresentativeAppraisalQuestionResponse(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static RepresentativeAppraisalQuestionResponse? fromValue(String value) {
    return RepresentativeAppraisalQuestionResponse.values
        .firstWhereOrNull((e) => e.name == value);
  }
}
