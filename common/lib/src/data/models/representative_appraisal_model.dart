import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

class RepresentativeAppraisal extends AbstractIsSoftDeletable
    implements Insertable<RepresentativeAppraisal> {
  RepresentativeAppraisal({
    required super.id,
    required this.representativeId,
    required this.completingDirectorId,
    required this.agencyId,
    required this.completedByDirectorAt,
    required this.completedByRepresentativeAt,
    required this.type,
    required this.limitDate,
    this.processKnowledge,
    this.glossaryKnowledge,
    this.meetingQuantity,
    this.meetingQuality,
    this.attitudeTowardsCustomer,
    this.companyIntroduction,
    this.technicalNeedCreation,
    this.technicalPitchProficiency,
    this.financialPitchProficiency,
    this.attitudeAndMoodAtMeeting,
    this.meetingCustomization,
    this.teamIntegration,
    this.staffSocialInteraction,
    this.opportunityRequestQuality,
    this.objective,
    this.bookedMeetingCount,
    this.processedMeetingCount,
    this.meetingAloneCount,
    this.meetingAccompaniedCount,
    this.tapMeetingCount,
    this.phoneMeetingCount,
    this.gmsMeetingCount,
    // director
    this.processKnowledgeByDirector,
    this.glossaryKnowledgeByDirector,
    this.meetingQuantityByDirector,
    this.meetingQualityByDirector,
    this.attitudeTowardsCustomerByDirector,
    this.companyIntroductionByDirector,
    this.technicalNeedCreationByDirector,
    this.technicalPitchProficiencyByDirector,
    this.financialPitchProficiencyByDirector,
    this.attitudeAndMoodAtMeetingByDirector,
    this.meetingCustomizationByDirector,
    this.teamIntegrationByDirector,
    this.staffSocialInteractionByDirector,
    this.opportunityRequestQualityByDirector,
    this.representativeAppraisalFormFileDataId,
    this.improvementPlan,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String representativeId;
  final String? completingDirectorId;
  final String agencyId;
  final DateTime? completedByDirectorAt;
  final DateTime? completedByRepresentativeAt;
  final RepresentativeAppraisalType type;
  final DateTime limitDate;
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
  final double? objective;
  final int? bookedMeetingCount;
  final int? processedMeetingCount;
  final int? meetingAloneCount;
  final int? meetingAccompaniedCount;
  final int? tapMeetingCount;
  final int? phoneMeetingCount;
  final int? gmsMeetingCount;
  // director
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
  final String? representativeAppraisalFormFileDataId;
  final String? improvementPlan;

  Representative? representative;
  Representative? completingDirector;
  Agency? agency;
  FileData? representativeAppraisalFormFileData;

  // Getters:-------------------------------------------------------------------
  int get limitYear => limitDate.year;

  // Methods:-------------------------------------------------------------------
  Future<void> loadRepresentative() async {
    representative =
        await getIt<RepresentativeServiceInterface>().getById(representativeId);
    //If representative is null (not in loaded agency), get information from Firestore
    representative ??= await getIt<RepresentativeServiceInterface>()
        .getByIdFromFirestore(representativeId);
  }

  Future<void> loadCompletingDirector() async {
    if (completingDirectorId == null) {
      return;
    }
    completingDirector = await getIt<RepresentativeServiceInterface>()
        .getById(completingDirectorId!);
    //If director is null (not in loaded agency), get information from Firestore
    completingDirector ??= await getIt<RepresentativeServiceInterface>()
        .getByIdFromFirestore(completingDirectorId!);
  }

  Future<void> loadAgency() async {
    agency =
        await getIt<AgencyServiceInterface>().getByIdFromFirestore(agencyId);
  }

  Future<void> loadRepresentativeAppraisalFormFileData() async {
    if (representativeAppraisalFormFileDataId == null) {
      return;
    }
    representativeAppraisalFormFileData =
        await getIt<FileDataServiceInterface>()
            .getById(representativeAppraisalFormFileDataId!, isRemote: true);
  }

  @override
  Future<void> loadData() async {
    await loadRepresentative();
    await loadCompletingDirector();
    await loadAgency();
    await loadRepresentativeAppraisalFormFileData();
  }

  // Base methods:--------------------------------------------------------------
  factory RepresentativeAppraisal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RepresentativeAppraisal(
      id: snapshot.id,
      representativeId: data?['representativeId'] as String,
      completingDirectorId: data?['completingDirectorId'] as String?,
      agencyId: data?['agencyId'] as String,
      completedByDirectorAt:
          data?['completedByDirectorAt']?.toDate() as DateTime?,
      completedByRepresentativeAt:
          data?['completedByRepresentativeAt']?.toDate() as DateTime?,
      type: RepresentativeAppraisalType.fromValue(data?['type']),
      limitDate: data?['limitDate'].toDate() as DateTime,
      processKnowledge: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['processKnowledge'] ?? ''),
      glossaryKnowledge: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['glossaryKnowledge'] ?? ''),
      meetingQuantity: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['meetingQuantity'] ?? ''),
      meetingQuality: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['meetingQuality'] ?? ''),
      attitudeTowardsCustomer:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['attitudeTowardsCustomer'] ?? ''),
      companyIntroduction: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['companyIntroduction'] ?? ''),
      technicalNeedCreation: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['technicalNeedCreation'] ?? ''),
      technicalPitchProficiency:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['technicalPitchProficiency'] ?? ''),
      financialPitchProficiency:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['financialPitchProficiency'] ?? ''),
      attitudeAndMoodAtMeeting:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['attitudeAndMoodAtMeeting'] ?? ''),
      meetingCustomization: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['meetingCustomization'] ?? ''),
      teamIntegration: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['teamIntegration'] ?? ''),
      staffSocialInteraction: RepresentativeAppraisalQuestionResponse.fromValue(
          data?['staffSocialInteraction'] ?? ''),
      opportunityRequestQuality:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['opportunityRequestQuality'] ?? ''),
      objective: getIt<NumberFormatterUtilsInterface>()
          .parseToDoubleOrNull(data?['objective']),
      bookedMeetingCount: data?['bookedMeetingCount'] as int?,
      processedMeetingCount: data?['processedMeetingCount'] as int?,
      meetingAloneCount: data?['meetingAloneCount'] as int?,
      meetingAccompaniedCount: data?['meetingAccompaniedCount'] as int?,
      tapMeetingCount: data?['tapMeetingCount'] as int?,
      phoneMeetingCount: data?['phoneMeetingCount'] as int?,
      gmsMeetingCount: data?['gmsMeetingCount'] as int?,
      // director
      processKnowledgeByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['processKnowledgeByDirector'] ?? ''),
      glossaryKnowledgeByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['glossaryKnowledgeByDirector'] ?? ''),
      meetingQuantityByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['meetingQuantityByDirector'] ?? ''),
      meetingQualityByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['meetingQualityByDirector'] ?? ''),
      attitudeTowardsCustomerByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['attitudeTowardsCustomerByDirector'] ?? ''),
      companyIntroductionByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['companyIntroductionByDirector'] ?? ''),
      technicalNeedCreationByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['technicalNeedCreationByDirector'] ?? ''),
      technicalPitchProficiencyByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['technicalPitchProficiencyByDirector'] ?? ''),
      financialPitchProficiencyByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['financialPitchProficiencyByDirector'] ?? ''),
      attitudeAndMoodAtMeetingByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['attitudeAndMoodAtMeetingByDirector'] ?? ''),
      meetingCustomizationByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['meetingCustomizationByDirector'] ?? ''),
      teamIntegrationByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['teamIntegrationByDirector'] ?? ''),
      staffSocialInteractionByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['staffSocialInteractionByDirector'] ?? ''),
      opportunityRequestQualityByDirector:
          RepresentativeAppraisalQuestionResponse.fromValue(
              data?['opportunityRequestQualityByDirector'] ?? ''),
      representativeAppraisalFormFileDataId:
          data?['representativeAppraisalFormFileDataId'] as String?,
      improvementPlan: data?['improvementPlan'] as String?,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
      deletedAt: data?['deletedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    final data = {
      'representativeId': representativeId,
      'completingDirectorId': completingDirectorId,
      'agencyId': agencyId,
      'completedByDirectorAt': completedByDirectorAt,
      'completedByRepresentativeAt': completedByRepresentativeAt,
      'type': type.name,
      'limitDate': limitDate,
      'processKnowledge': processKnowledge?.name,
      'glossaryKnowledge': glossaryKnowledge?.name,
      'meetingQuantity': meetingQuantity?.name,
      'meetingQuality': meetingQuality?.name,
      'attitudeTowardsCustomer': attitudeTowardsCustomer?.name,
      'companyIntroduction': companyIntroduction?.name,
      'technicalNeedCreation': technicalNeedCreation?.name,
      'technicalPitchProficiency': technicalPitchProficiency?.name,
      'financialPitchProficiency': financialPitchProficiency?.name,
      'attitudeAndMoodAtMeeting': attitudeAndMoodAtMeeting?.name,
      'meetingCustomization': meetingCustomization?.name,
      'teamIntegration': teamIntegration?.name,
      'staffSocialInteraction': staffSocialInteraction?.name,
      'opportunityRequestQuality': opportunityRequestQuality?.name,
      'objective': objective,
      'bookedMeetingCount': bookedMeetingCount,
      'processedMeetingCount': processedMeetingCount,
      'meetingAloneCount': meetingAloneCount,
      'meetingAccompaniedCount': meetingAccompaniedCount,
      'tapMeetingCount': tapMeetingCount,
      'phoneMeetingCount': phoneMeetingCount,
      'gmsMeetingCount': gmsMeetingCount,
      // director
      'processKnowledgeByDirector': processKnowledgeByDirector?.name,
      'glossaryKnowledgeByDirector': glossaryKnowledgeByDirector?.name,
      'meetingQuantityByDirector': meetingQuantityByDirector?.name,
      'meetingQualityByDirector': meetingQualityByDirector?.name,
      'attitudeTowardsCustomerByDirector':
          attitudeTowardsCustomerByDirector?.name,
      'companyIntroductionByDirector': companyIntroductionByDirector?.name,
      'technicalNeedCreationByDirector': technicalNeedCreationByDirector?.name,
      'technicalPitchProficiencyByDirector':
          technicalPitchProficiencyByDirector?.name,
      'financialPitchProficiencyByDirector':
          financialPitchProficiencyByDirector?.name,
      'attitudeAndMoodAtMeetingByDirector':
          attitudeAndMoodAtMeetingByDirector?.name,
      'meetingCustomizationByDirector': meetingCustomizationByDirector?.name,
      'teamIntegrationByDirector': teamIntegrationByDirector?.name,
      'staffSocialInteractionByDirector':
          staffSocialInteractionByDirector?.name,
      'opportunityRequestQualityByDirector':
          opportunityRequestQualityByDirector?.name,
      'representativeAppraisalFormFileDataId':
          representativeAppraisalFormFileDataId,
      'improvementPlan': improvementPlan,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };

    return data;
  }

  @override
  RepresentativeAppraisal copyWith({
    String? id,
    String? representativeId,
    String? completingDirectorId,
    String? agencyId,
    DateTime? completedByDirectorAt,
    DateTime? completedByRepresentativeAt,
    RepresentativeAppraisalType? type,
    DateTime? limitDate,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>? processKnowledge,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>? glossaryKnowledge,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>? meetingQuantity,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>? meetingQuality,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        attitudeTowardsCustomer,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>? companyIntroduction,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        technicalNeedCreation,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        technicalPitchProficiency,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        financialPitchProficiency,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        attitudeAndMoodAtMeeting,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>? meetingCustomization,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>? teamIntegration,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        staffSocialInteraction,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        opportunityRequestQuality,
    ValueGetter<double?>? objective,
    ValueGetter<int?>? bookedMeetingCount,
    ValueGetter<int?>? processedMeetingCount,
    ValueGetter<int?>? meetingAloneCount,
    ValueGetter<int?>? meetingAccompaniedCount,
    ValueGetter<int?>? tapMeetingCount,
    ValueGetter<int?>? phoneMeetingCount,
    ValueGetter<int?>? gmsMeetingCount,
    // director
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        processKnowledgeByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        glossaryKnowledgeByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        meetingQuantityByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        meetingQualityByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        attitudeTowardsCustomerByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        companyIntroductionByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        technicalNeedCreationByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        technicalPitchProficiencyByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        financialPitchProficiencyByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        attitudeAndMoodAtMeetingByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        meetingCustomizationByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        teamIntegrationByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        staffSocialInteractionByDirector,
    ValueGetter<RepresentativeAppraisalQuestionResponse?>?
        opportunityRequestQualityByDirector,
    ValueGetter<String?>? representativeAppraisalFormFileDataId,
    ValueGetter<String?>? improvementPlan,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    RepresentativeAppraisal representativeAppraisal = RepresentativeAppraisal(
      id: id ?? this.id,
      representativeId: representativeId ?? this.representativeId,
      completingDirectorId: completingDirectorId ?? this.completingDirectorId,
      agencyId: agencyId ?? this.agencyId,
      completedByDirectorAt:
          completedByDirectorAt ?? this.completedByDirectorAt,
      completedByRepresentativeAt:
          completedByRepresentativeAt ?? this.completedByRepresentativeAt,
      type: type ?? this.type,
      limitDate: limitDate ?? this.limitDate,
      processKnowledge:
          processKnowledge != null ? processKnowledge() : this.processKnowledge,
      glossaryKnowledge: glossaryKnowledge != null
          ? glossaryKnowledge()
          : this.glossaryKnowledge,
      meetingQuantity:
          meetingQuantity != null ? meetingQuantity() : this.meetingQuantity,
      meetingQuality:
          meetingQuality != null ? meetingQuality() : this.meetingQuality,
      attitudeTowardsCustomer: attitudeTowardsCustomer != null
          ? attitudeTowardsCustomer()
          : this.attitudeTowardsCustomer,
      companyIntroduction: companyIntroduction != null
          ? companyIntroduction()
          : this.companyIntroduction,
      technicalNeedCreation: technicalNeedCreation != null
          ? technicalNeedCreation()
          : this.technicalNeedCreation,
      technicalPitchProficiency: technicalPitchProficiency != null
          ? technicalPitchProficiency()
          : this.technicalPitchProficiency,
      financialPitchProficiency: financialPitchProficiency != null
          ? financialPitchProficiency()
          : this.financialPitchProficiency,
      attitudeAndMoodAtMeeting: attitudeAndMoodAtMeeting != null
          ? attitudeAndMoodAtMeeting()
          : this.attitudeAndMoodAtMeeting,
      meetingCustomization: meetingCustomization != null
          ? meetingCustomization()
          : this.meetingCustomization,
      teamIntegration:
          teamIntegration != null ? teamIntegration() : this.teamIntegration,
      staffSocialInteraction: staffSocialInteraction != null
          ? staffSocialInteraction()
          : this.staffSocialInteraction,
      opportunityRequestQuality: opportunityRequestQuality != null
          ? opportunityRequestQuality()
          : this.opportunityRequestQuality,
      objective: objective != null ? objective() : this.objective,
      bookedMeetingCount: bookedMeetingCount != null
          ? bookedMeetingCount()
          : this.bookedMeetingCount,
      processedMeetingCount: processedMeetingCount != null
          ? processedMeetingCount()
          : this.processedMeetingCount,
      meetingAloneCount: meetingAloneCount != null
          ? meetingAloneCount()
          : this.meetingAloneCount,
      meetingAccompaniedCount: meetingAccompaniedCount != null
          ? meetingAccompaniedCount()
          : this.meetingAccompaniedCount,
      tapMeetingCount:
          tapMeetingCount != null ? tapMeetingCount() : this.tapMeetingCount,
      phoneMeetingCount: phoneMeetingCount != null
          ? phoneMeetingCount()
          : this.phoneMeetingCount,
      gmsMeetingCount:
          gmsMeetingCount != null ? gmsMeetingCount() : this.gmsMeetingCount,
      // director
      processKnowledgeByDirector: processKnowledgeByDirector != null
          ? processKnowledgeByDirector()
          : this.processKnowledgeByDirector,
      glossaryKnowledgeByDirector: glossaryKnowledgeByDirector != null
          ? glossaryKnowledgeByDirector()
          : this.glossaryKnowledgeByDirector,
      meetingQuantityByDirector: meetingQuantityByDirector != null
          ? meetingQuantityByDirector()
          : this.meetingQuantityByDirector,
      meetingQualityByDirector: meetingQualityByDirector != null
          ? meetingQualityByDirector()
          : this.meetingQualityByDirector,
      attitudeTowardsCustomerByDirector:
          attitudeTowardsCustomerByDirector != null
              ? attitudeTowardsCustomerByDirector()
              : this.attitudeTowardsCustomerByDirector,
      companyIntroductionByDirector: companyIntroductionByDirector != null
          ? companyIntroductionByDirector()
          : this.companyIntroductionByDirector,
      technicalNeedCreationByDirector: technicalNeedCreationByDirector != null
          ? technicalNeedCreationByDirector()
          : this.technicalNeedCreationByDirector,
      technicalPitchProficiencyByDirector:
          technicalPitchProficiencyByDirector != null
              ? technicalPitchProficiencyByDirector()
              : this.technicalPitchProficiencyByDirector,
      financialPitchProficiencyByDirector:
          financialPitchProficiencyByDirector != null
              ? financialPitchProficiencyByDirector()
              : this.financialPitchProficiencyByDirector,
      attitudeAndMoodAtMeetingByDirector:
          attitudeAndMoodAtMeetingByDirector != null
              ? attitudeAndMoodAtMeetingByDirector()
              : this.attitudeAndMoodAtMeetingByDirector,
      meetingCustomizationByDirector: meetingCustomizationByDirector != null
          ? meetingCustomizationByDirector()
          : this.meetingCustomizationByDirector,
      teamIntegrationByDirector: teamIntegrationByDirector != null
          ? teamIntegrationByDirector()
          : this.teamIntegrationByDirector,
      staffSocialInteractionByDirector: staffSocialInteractionByDirector != null
          ? staffSocialInteractionByDirector()
          : this.staffSocialInteractionByDirector,
      opportunityRequestQualityByDirector:
          opportunityRequestQualityByDirector != null
              ? opportunityRequestQualityByDirector()
              : this.opportunityRequestQualityByDirector,
      representativeAppraisalFormFileDataId:
          representativeAppraisalFormFileDataId != null
              ? representativeAppraisalFormFileDataId()
              : this.representativeAppraisalFormFileDataId,
      improvementPlan:
          improvementPlan != null ? improvementPlan() : this.improvementPlan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
    representativeAppraisal.representative = representative;
    return representativeAppraisal;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {};
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is RepresentativeAppraisal &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.representativeId == representativeId &&
        other.completingDirectorId == completingDirectorId &&
        other.agencyId == agencyId &&
        other.completedByDirectorAt == completedByDirectorAt &&
        other.completedByRepresentativeAt == completedByRepresentativeAt &&
        other.type == type &&
        other.limitDate == limitDate &&
        other.processKnowledge == processKnowledge &&
        other.glossaryKnowledge == glossaryKnowledge &&
        other.meetingQuantity == meetingQuantity &&
        other.meetingQuality == meetingQuality &&
        other.attitudeTowardsCustomer == attitudeTowardsCustomer &&
        other.companyIntroduction == companyIntroduction &&
        other.technicalNeedCreation == technicalNeedCreation &&
        other.technicalPitchProficiency == technicalPitchProficiency &&
        other.financialPitchProficiency == financialPitchProficiency &&
        other.attitudeAndMoodAtMeeting == attitudeAndMoodAtMeeting &&
        other.meetingCustomization == meetingCustomization &&
        other.teamIntegration == teamIntegration &&
        other.staffSocialInteraction == staffSocialInteraction &&
        other.opportunityRequestQuality == opportunityRequestQuality &&
        other.objective == objective &&
        other.bookedMeetingCount == bookedMeetingCount &&
        other.processedMeetingCount == processedMeetingCount &&
        other.meetingAloneCount == meetingAloneCount &&
        other.meetingAccompaniedCount == meetingAccompaniedCount &&
        other.tapMeetingCount == tapMeetingCount &&
        other.phoneMeetingCount == phoneMeetingCount &&
        other.gmsMeetingCount == gmsMeetingCount &&
        other.processKnowledgeByDirector == processKnowledgeByDirector &&
        other.glossaryKnowledgeByDirector == glossaryKnowledgeByDirector &&
        other.meetingQuantityByDirector == meetingQuantityByDirector &&
        other.meetingQualityByDirector == meetingQualityByDirector &&
        other.attitudeTowardsCustomerByDirector ==
            attitudeTowardsCustomerByDirector &&
        other.companyIntroductionByDirector == companyIntroductionByDirector &&
        other.technicalNeedCreationByDirector ==
            technicalNeedCreationByDirector &&
        other.technicalPitchProficiencyByDirector ==
            technicalPitchProficiencyByDirector &&
        other.financialPitchProficiencyByDirector ==
            financialPitchProficiencyByDirector &&
        other.attitudeAndMoodAtMeetingByDirector ==
            attitudeAndMoodAtMeetingByDirector &&
        other.meetingCustomizationByDirector ==
            meetingCustomizationByDirector &&
        other.teamIntegrationByDirector == teamIntegrationByDirector &&
        other.staffSocialInteractionByDirector ==
            staffSocialInteractionByDirector &&
        other.opportunityRequestQualityByDirector ==
            opportunityRequestQualityByDirector &&
        other.representativeAppraisalFormFileDataId ==
            representativeAppraisalFormFileDataId &&
        other.improvementPlan == improvementPlan &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
