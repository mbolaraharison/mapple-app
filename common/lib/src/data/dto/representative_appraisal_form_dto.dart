import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:maple_common/maple_common.dart';

@immutable
class RepresentativeAppraisalFormDto {
  // Constructor:---------------------------------------------------------------
  const RepresentativeAppraisalFormDto._({
    // objectives
    required this.objective,
    required this.bookedMeetingCount,
    required this.processedMeetingCount,
    required this.meetingAloneCount,
    required this.meetingAccompaniedCount,
    required this.tapMeetingCount,
    required this.phoneMeetingCount,
    required this.gmsMeetingCount,
    required this.processKnowledge,
    required this.glossaryKnowledge,
    required this.meetingQuantity,
    required this.meetingQuality,
    required this.attitudeTowardsCustomer,
    required this.companyIntroduction,
    required this.technicalNeedCreation,
    required this.technicalPitchProficiency,
    required this.financialPitchProficiency,
    required this.attitudeAndMoodAtMeeting,
    required this.meetingCustomization,
    required this.teamIntegration,
    required this.staffSocialInteraction,
    required this.opportunityRequestQuality,
    // director
    required this.directorName,
    required this.processKnowledgeByDirector,
    required this.glossaryKnowledgeByDirector,
    required this.meetingQuantityByDirector,
    required this.meetingQualityByDirector,
    required this.attitudeTowardsCustomerByDirector,
    required this.companyIntroductionByDirector,
    required this.technicalNeedCreationByDirector,
    required this.technicalPitchProficiencyByDirector,
    required this.financialPitchProficiencyByDirector,
    required this.attitudeAndMoodAtMeetingByDirector,
    required this.meetingCustomizationByDirector,
    required this.teamIntegrationByDirector,
    required this.staffSocialInteractionByDirector,
    required this.opportunityRequestQualityByDirector,
    required this.improvementPlan,
    // meta
    required this.date,
    required this.type,
    required this.demiDiskSvg,
    required this.completedByRepresentativeAt,
    required this.completedByDirectorAt,
    // representative
    required this.representativeId,
    required this.agencyId,
    required this.agencyLabel,
    required this.representativeName,
    // svg
    required this.appraisalNotMetSvg,
    required this.appraisalInProgressSvg,
    required this.appraisalAchievedSvg,
    required this.appraisalProficientSvg,
  });

  // Variables:-----------------------------------------------------------------
  // objectives
  final String objective;
  final String bookedMeetingCount;
  final String processedMeetingCount;
  final String meetingAloneCount;
  final String meetingAccompaniedCount;
  final String tapMeetingCount;
  final String phoneMeetingCount;
  final String gmsMeetingCount;
  final RepresentativeAppraisalQuestionResponse? processKnowledge;
  final RepresentativeAppraisalQuestionResponse? glossaryKnowledge;
  final RepresentativeAppraisalQuestionResponse? meetingQuantity;
  final RepresentativeAppraisalQuestionResponse? meetingQuality;
  final RepresentativeAppraisalQuestionResponse? attitudeTowardsCustomer;
  final RepresentativeAppraisalQuestionResponse? companyIntroduction;
  final RepresentativeAppraisalQuestionResponse? technicalNeedCreation;
  final RepresentativeAppraisalQuestionResponse? technicalPitchProficiency;
  final RepresentativeAppraisalQuestionResponse? financialPitchProficiency;
  final RepresentativeAppraisalQuestionResponse? attitudeAndMoodAtMeeting;
  final RepresentativeAppraisalQuestionResponse? meetingCustomization;
  final RepresentativeAppraisalQuestionResponse? teamIntegration;
  final RepresentativeAppraisalQuestionResponse? staffSocialInteraction;
  final RepresentativeAppraisalQuestionResponse? opportunityRequestQuality;
  // director
  final String directorName;
  final RepresentativeAppraisalQuestionResponse? processKnowledgeByDirector;
  final RepresentativeAppraisalQuestionResponse? glossaryKnowledgeByDirector;
  final RepresentativeAppraisalQuestionResponse? meetingQuantityByDirector;
  final RepresentativeAppraisalQuestionResponse? meetingQualityByDirector;
  final RepresentativeAppraisalQuestionResponse?
      attitudeTowardsCustomerByDirector;
  final RepresentativeAppraisalQuestionResponse? companyIntroductionByDirector;
  final RepresentativeAppraisalQuestionResponse?
      technicalNeedCreationByDirector;
  final RepresentativeAppraisalQuestionResponse?
      technicalPitchProficiencyByDirector;
  final RepresentativeAppraisalQuestionResponse?
      financialPitchProficiencyByDirector;
  final RepresentativeAppraisalQuestionResponse?
      attitudeAndMoodAtMeetingByDirector;
  final RepresentativeAppraisalQuestionResponse? meetingCustomizationByDirector;
  final RepresentativeAppraisalQuestionResponse? teamIntegrationByDirector;
  final RepresentativeAppraisalQuestionResponse?
      staffSocialInteractionByDirector;
  final RepresentativeAppraisalQuestionResponse?
      opportunityRequestQualityByDirector;
  final String improvementPlan;
  final String date;
  final RepresentativeAppraisalType type;
  final String demiDiskSvg;
  final String completedByRepresentativeAt;
  final String completedByDirectorAt;
  final String representativeId;
  final String agencyId;
  final String agencyLabel;
  final String representativeName;
  final String appraisalNotMetSvg;
  final String appraisalInProgressSvg;
  final String appraisalAchievedSvg;
  final String appraisalProficientSvg;

  // Factory:-------------------------------------------------------------------
  static Future<RepresentativeAppraisalFormDto> create({
    required RepresentativeAppraisal representativeAppraisal,
  }) async {
    // Dependencies
    NumberFormatterUtilsInterface numberFormatterUtils =
        getIt<NumberFormatterUtilsInterface>();
    String dateTimeString = DateFormat('dd-MM-yyyy').format(
      representativeAppraisal.limitDate,
    );
    String completedByRepresentativeAt =
        representativeAppraisal.completedByRepresentativeAt != null
            ? DateFormat('dd MMMM yyyy').format(
                representativeAppraisal.completedByRepresentativeAt!,
              )
            : '';
    String completedByDirectorAt =
        representativeAppraisal.completedByDirectorAt != null
            ? DateFormat('dd MMMM yyyy').format(
                representativeAppraisal.completedByDirectorAt!,
              )
            : '';

    // load representative
    await representativeAppraisal.loadData();

    // load svg
    String demiDiskSvg =
        await rootBundle.loadString(MapleCommonAssets.demiDisk);
    String appraisalNotMetCoreSvg =
        await rootBundle.loadString(MapleCommonAssets.appraisalNotMetCore);
    String appraisalInProgressCoreSvg =
        await rootBundle.loadString(MapleCommonAssets.appraisalInProgressCore);
    String appraisalAchievedCoreSvg =
        await rootBundle.loadString(MapleCommonAssets.appraisalAchievedCore);
    String appraisalProficientCoreSvg =
        await rootBundle.loadString(MapleCommonAssets.appraisalProficientCore);

    return RepresentativeAppraisalFormDto._(
      // objectives
      objective: representativeAppraisal.objective != null
          ? numberFormatterUtils.formatToCurrency(
              representativeAppraisal.objective!,
              withSymbol: true,
            )
          : '',
      bookedMeetingCount: representativeAppraisal.bookedMeetingCount != null
          ? numberFormatterUtils.formatToInteger(
              representativeAppraisal.bookedMeetingCount!,
            )
          : '',
      processedMeetingCount:
          representativeAppraisal.processedMeetingCount != null
              ? numberFormatterUtils.formatToInteger(
                  representativeAppraisal.processedMeetingCount!,
                )
              : '',
      meetingAloneCount: representativeAppraisal.meetingAloneCount != null
          ? numberFormatterUtils.formatToInteger(
              representativeAppraisal.meetingAloneCount!,
            )
          : '',
      meetingAccompaniedCount:
          representativeAppraisal.meetingAccompaniedCount != null
              ? numberFormatterUtils.formatToInteger(
                  representativeAppraisal.meetingAccompaniedCount!,
                )
              : '',
      tapMeetingCount: representativeAppraisal.tapMeetingCount != null
          ? numberFormatterUtils.formatToInteger(
              representativeAppraisal.tapMeetingCount!,
            )
          : '',
      phoneMeetingCount: representativeAppraisal.phoneMeetingCount != null
          ? numberFormatterUtils.formatToInteger(
              representativeAppraisal.phoneMeetingCount!,
            )
          : '',
      gmsMeetingCount: representativeAppraisal.gmsMeetingCount != null
          ? numberFormatterUtils.formatToInteger(
              representativeAppraisal.gmsMeetingCount!,
            )
          : '',
      processKnowledge: representativeAppraisal.processKnowledge,
      glossaryKnowledge: representativeAppraisal.glossaryKnowledge,
      meetingQuantity: representativeAppraisal.meetingQuantity,
      meetingQuality: representativeAppraisal.meetingQuality,
      attitudeTowardsCustomer: representativeAppraisal.attitudeTowardsCustomer,
      companyIntroduction: representativeAppraisal.companyIntroduction,
      technicalNeedCreation: representativeAppraisal.technicalNeedCreation,
      technicalPitchProficiency:
          representativeAppraisal.technicalPitchProficiency,
      financialPitchProficiency:
          representativeAppraisal.financialPitchProficiency,
      attitudeAndMoodAtMeeting:
          representativeAppraisal.attitudeAndMoodAtMeeting,
      meetingCustomization: representativeAppraisal.meetingCustomization,
      teamIntegration: representativeAppraisal.teamIntegration,
      staffSocialInteraction: representativeAppraisal.staffSocialInteraction,
      opportunityRequestQuality:
          representativeAppraisal.opportunityRequestQuality,
      // director
      directorName: representativeAppraisal.completingDirector?.fullName ?? '',
      processKnowledgeByDirector:
          representativeAppraisal.processKnowledgeByDirector,
      glossaryKnowledgeByDirector:
          representativeAppraisal.glossaryKnowledgeByDirector,
      meetingQuantityByDirector:
          representativeAppraisal.meetingQuantityByDirector,
      meetingQualityByDirector:
          representativeAppraisal.meetingQualityByDirector,
      attitudeTowardsCustomerByDirector:
          representativeAppraisal.attitudeTowardsCustomerByDirector,
      companyIntroductionByDirector:
          representativeAppraisal.companyIntroductionByDirector,
      technicalNeedCreationByDirector:
          representativeAppraisal.technicalNeedCreationByDirector,
      technicalPitchProficiencyByDirector:
          representativeAppraisal.technicalPitchProficiencyByDirector,
      financialPitchProficiencyByDirector:
          representativeAppraisal.financialPitchProficiencyByDirector,
      attitudeAndMoodAtMeetingByDirector:
          representativeAppraisal.attitudeAndMoodAtMeetingByDirector,
      meetingCustomizationByDirector:
          representativeAppraisal.meetingCustomizationByDirector,
      teamIntegrationByDirector:
          representativeAppraisal.teamIntegrationByDirector,
      staffSocialInteractionByDirector:
          representativeAppraisal.staffSocialInteractionByDirector,
      opportunityRequestQualityByDirector:
          representativeAppraisal.opportunityRequestQualityByDirector,
      improvementPlan: representativeAppraisal.improvementPlan ?? '',
      // meta
      date: dateTimeString,
      type: representativeAppraisal.type,
      demiDiskSvg: demiDiskSvg,
      completedByRepresentativeAt: completedByRepresentativeAt,
      completedByDirectorAt: completedByDirectorAt,
      // representative
      representativeId: representativeAppraisal.representativeId,
      agencyId: representativeAppraisal.agencyId,
      agencyLabel: representativeAppraisal.agency?.label ?? '',
      representativeName: representativeAppraisal.representative!.fullName,
      // svg
      appraisalNotMetSvg: appraisalNotMetCoreSvg,
      appraisalInProgressSvg: appraisalInProgressCoreSvg,
      appraisalAchievedSvg: appraisalAchievedCoreSvg,
      appraisalProficientSvg: appraisalProficientCoreSvg,
    );
  }
}
