// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum FillAppraisalScreenTabQuestion {
  processKnowledge('appraisal.edit.tab.question.process_knowledge'),
  glossaryKnowledge('appraisal.edit.tab.question.glossary_knowledge'),
  meetingQuantity('appraisal.edit.tab.question.meeting_quantity'),
  meetingQuality('appraisal.edit.tab.question.meeting_quality'),
  attitudeTowardsCustomer(
      'appraisal.edit.tab.question.attitude_towards_customer'),
  companyIntroduction('appraisal.edit.tab.question.company_introduction'),
  technicalNeedCreation('appraisal.edit.tab.question.technical_need_creation'),
  technicalPitchProficiency(
      'appraisal.edit.tab.question.technical_pitch_proficiency'),
  financialPitchProficiency(
      'appraisal.edit.tab.question.financial_pitch_proficiency'),
  attitudeAndMoodAtMeeting(
      'appraisal.edit.tab.question.attitude_and_mood_at_meeting'),
  meetingCustomization('appraisal.edit.tab.question.meeting_customization'),
  opportunityRequestQuality('appraisal.edit.tab.opportunity_request_quality'),
  teamIntegration('appraisal.edit.tab.question.team_integration'),
  staffSocialInteraction(
      'appraisal.edit.tab.question.staff_social_interaction');

  const FillAppraisalScreenTabQuestion(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static FillAppraisalScreenTabQuestion? fromValue(String value) {
    return FillAppraisalScreenTabQuestion.values
        .firstWhereOrNull((e) => e.name == value);
  }
}

enum FillAppraisalScreenTab {
  objectives('appraisal.edit.tab.objectives.title'),
  survey('appraisal.edit.tab.survey'),
  negociation('appraisal.edit.tab.negociation'),
  opportunityRequestQuality('appraisal.edit.tab.opportunity_request_quality'),
  lifeAtWork('appraisal.edit.tab.life_at_work');

  const FillAppraisalScreenTab(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static FillAppraisalScreenTab? fromValue(String value) {
    return FillAppraisalScreenTab.values
        .firstWhereOrNull((e) => e.name == value);
  }

  static Map<FillAppraisalScreenTab, List<FillAppraisalScreenTabQuestion>>
      get questionsByTab => {
            FillAppraisalScreenTab.objectives: [],
            FillAppraisalScreenTab.survey: [
              FillAppraisalScreenTabQuestion.processKnowledge,
              FillAppraisalScreenTabQuestion.glossaryKnowledge,
              FillAppraisalScreenTabQuestion.meetingQuantity,
              FillAppraisalScreenTabQuestion.meetingQuality,
              FillAppraisalScreenTabQuestion.attitudeTowardsCustomer,
            ],
            FillAppraisalScreenTab.negociation: [
              FillAppraisalScreenTabQuestion.companyIntroduction,
              FillAppraisalScreenTabQuestion.technicalNeedCreation,
              FillAppraisalScreenTabQuestion.technicalPitchProficiency,
              FillAppraisalScreenTabQuestion.financialPitchProficiency,
              FillAppraisalScreenTabQuestion.attitudeAndMoodAtMeeting,
              FillAppraisalScreenTabQuestion.meetingCustomization,
            ],
            FillAppraisalScreenTab.opportunityRequestQuality: [
              FillAppraisalScreenTabQuestion.opportunityRequestQuality,
            ],
            FillAppraisalScreenTab.lifeAtWork: [
              FillAppraisalScreenTabQuestion.teamIntegration,
              FillAppraisalScreenTabQuestion.staffSocialInteraction,
            ],
          };
}

enum FillAppraisalDirectorStep {
  appraisal('appraisal.edit.director.step.appraisal'),
  validation('appraisal.edit.director.step.validation');

  const FillAppraisalDirectorStep(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  static FillAppraisalDirectorStep? fromValue(String value) {
    return FillAppraisalDirectorStep.values
        .firstWhereOrNull((e) => e.name == value);
  }
}
