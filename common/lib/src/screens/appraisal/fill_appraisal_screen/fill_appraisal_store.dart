import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'fill_appraisal_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class FillAppraisalStoreInterface {
  // Constructor
  FillAppraisalStoreInterface._(
    this.representativeAppraisal,
    this.editingRepresentative,
    this.currentTab,
    this.activeTab,
    this.currentDirectorStep,
    this.activeDirectorStep,
    this.submitStreamController,
  );

  // Variables
  RepresentativeAppraisal representativeAppraisal;
  Representative editingRepresentative;
  FillAppraisalScreenTab currentTab;
  FillAppraisalScreenTabQuestion? currentTabQuestion;
  FillAppraisalScreenTab activeTab;
  FillAppraisalScreenTabQuestion? activeTabQuestion;

  // director steps
  FillAppraisalDirectorStep currentDirectorStep;
  FillAppraisalDirectorStep activeDirectorStep;

  // Objectives
  double? objective;
  int? bookedMeetingCount;
  int? processedMeetingCount;
  int? meetingAloneCount;
  int? meetingAccompaniedCount;
  int? tapMeetingCount;
  int? phoneMeetingCount;
  int? gmsMeetingCount;

  StreamSubscription<RepresentativeAppraisal?>?
      representativeAppraisalStreamSubscription;

  // General questions
  RepresentativeAppraisalQuestionResponse? processKnowledge;
  RepresentativeAppraisalQuestionResponse? glossaryKnowledge;
  RepresentativeAppraisalQuestionResponse? meetingQuantity;
  RepresentativeAppraisalQuestionResponse? meetingQuality;
  RepresentativeAppraisalQuestionResponse? attitudeTowardsCustomer;
  RepresentativeAppraisalQuestionResponse? companyIntroduction;
  RepresentativeAppraisalQuestionResponse? technicalNeedCreation;
  RepresentativeAppraisalQuestionResponse? technicalPitchProficiency;
  RepresentativeAppraisalQuestionResponse? financialPitchProficiency;
  RepresentativeAppraisalQuestionResponse? attitudeAndMoodAtMeeting;
  RepresentativeAppraisalQuestionResponse? meetingCustomization;
  RepresentativeAppraisalQuestionResponse? teamIntegration;
  RepresentativeAppraisalQuestionResponse? staffSocialInteraction;
  RepresentativeAppraisalQuestionResponse? opportunityRequestQuality;
  String? improvementPlan;

  // Computed
  Map<FillAppraisalScreenTab, bool> get completedTabs;
  Map<FillAppraisalScreenTab, Map<FillAppraisalScreenTabQuestion, bool>>
      get completedTabsQuestions;
  bool get isCompleted;
  double get percentage;
  RepresentativeAppraisalQuestionResponse? get responseByQuestion;
  bool get hasChanged;
  bool get canChangeTab;

  // Methods
  Future<void> init();
  void dispose();
  void setCurrentTab(FillAppraisalScreenTab tab);
  void setCurrentTabQuestion(
      FillAppraisalScreenTab tab, FillAppraisalScreenTabQuestion? question);
  void setActiveTab(FillAppraisalScreenTab tab);
  void setActiveTabQuestion(
      FillAppraisalScreenTab tab, FillAppraisalScreenTabQuestion? question);

  // director steps methods
  void setCurrentDirectorStep(FillAppraisalDirectorStep step);
  void setActiveDirectorStep(FillAppraisalDirectorStep step);

  void setProcessKnowledge(RepresentativeAppraisalQuestionResponse value);
  void setGlossaryKnowledge(RepresentativeAppraisalQuestionResponse value);
  void setMeetingQuantity(RepresentativeAppraisalQuestionResponse value);
  void setMeetingQuality(RepresentativeAppraisalQuestionResponse value);
  void setAttitudeTowardsCustomer(
      RepresentativeAppraisalQuestionResponse value);
  void setCompanyIntroduction(RepresentativeAppraisalQuestionResponse value);
  void setTechnicalNeedCreation(RepresentativeAppraisalQuestionResponse value);
  void setTechnicalPitchProficiency(
      RepresentativeAppraisalQuestionResponse value);
  void setFinancialPitchProficiency(
      RepresentativeAppraisalQuestionResponse value);
  void setAttitudeAndMoodAtMeeting(
      RepresentativeAppraisalQuestionResponse value);
  void setMeetingCustomization(RepresentativeAppraisalQuestionResponse value);
  void setTeamIntegration(RepresentativeAppraisalQuestionResponse value);
  void setStaffSocialInteraction(RepresentativeAppraisalQuestionResponse value);
  void setOpportunityRequestQuality(
      RepresentativeAppraisalQuestionResponse value);
  void setObjective(String value);
  void setBookedMeetingCount(String value);
  void setProcessedMeetingCount(String value);
  void setMeetingAloneCount(String value);
  void setMeetingAccompaniedCount(String value);
  void setTapMeetingCount(String value);
  void setPhoneMeetingCount(String value);
  void setGmsMeetingCount(String value);
  void setImprovementPlan(String value);
  void setResponseByQuestion(RepresentativeAppraisalQuestionResponse value);
  void previous();
  void next();
  void previousDirectorStep();
  void nextDirectorStep();
  Future<void> submit();
  Future<void> setRepresentativeAppraisalFormFileDataId(String? fileDataId);

  // stream
  StreamController<void> submitStreamController;
  Stream<void> get submitStream;
}

// Params:----------------------------------------------------------------------
class FillAppraisalStoreParams {
  const FillAppraisalStoreParams(
      {required this.representativeAppraisal,
      required this.editingRepresentative});

  final RepresentativeAppraisal representativeAppraisal;
  final Representative editingRepresentative;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class FillAppraisalStore = _FillAppraisalStoreBase with _$FillAppraisalStore;

abstract class _FillAppraisalStoreBase
    with Store
    implements FillAppraisalStoreInterface {
  // Constructor:---------------------------------------------------------------
  _FillAppraisalStoreBase({required FillAppraisalStoreParams params})
      : representativeAppraisal = params.representativeAppraisal,
        editingRepresentative = params.editingRepresentative {
    init();
  }

  // Dependencies:--------------------------------------------------------------
  late final RepresentativeAppraisalServiceInterface
      _representativeAppraisalService =
      getIt<RepresentativeAppraisalServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  RepresentativeAppraisal representativeAppraisal;

  @override
  @observable
  Representative editingRepresentative;

  @override
  @observable
  FillAppraisalScreenTab currentTab = FillAppraisalScreenTab.objectives;

  @override
  @observable
  FillAppraisalScreenTabQuestion? currentTabQuestion;

  @override
  @observable
  FillAppraisalScreenTab activeTab = FillAppraisalScreenTab.objectives;

  @override
  @observable
  FillAppraisalScreenTabQuestion? activeTabQuestion;

  // director steps
  @override
  @observable
  FillAppraisalDirectorStep currentDirectorStep =
      FillAppraisalDirectorStep.appraisal;

  @override
  @observable
  FillAppraisalDirectorStep activeDirectorStep =
      FillAppraisalDirectorStep.appraisal;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? processKnowledge;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? glossaryKnowledge;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? meetingQuantity;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? meetingQuality;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? attitudeTowardsCustomer;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? companyIntroduction;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? technicalNeedCreation;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? technicalPitchProficiency;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? financialPitchProficiency;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? attitudeAndMoodAtMeeting;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? meetingCustomization;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? teamIntegration;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? staffSocialInteraction;

  @override
  @observable
  RepresentativeAppraisalQuestionResponse? opportunityRequestQuality;

  @override
  @observable
  double? objective;

  @override
  @observable
  int? bookedMeetingCount;

  @override
  @observable
  int? processedMeetingCount;

  @override
  @observable
  int? meetingAloneCount;

  @override
  @observable
  int? meetingAccompaniedCount;

  @override
  @observable
  int? tapMeetingCount;

  @override
  @observable
  int? phoneMeetingCount;

  @override
  @observable
  int? gmsMeetingCount;

  @override
  @observable
  String? improvementPlan;

  @override
  @observable
  StreamSubscription<RepresentativeAppraisal?>?
      representativeAppraisalStreamSubscription;

  @override
  StreamController<void> submitStreamController = StreamController<void>();

  // Computed:------------------------------------------------------------------
  @override
  @computed
  Map<FillAppraisalScreenTab, bool> get completedTabs => {
        FillAppraisalScreenTab.objectives:
            representativeAppraisal.representative != null
                ? (editingRepresentative.isDirector == false
                    ? (objective != null &&
                        bookedMeetingCount != null &&
                        processedMeetingCount != null &&
                        meetingAloneCount != null &&
                        meetingAccompaniedCount != null &&
                        tapMeetingCount != null &&
                        phoneMeetingCount != null &&
                        gmsMeetingCount != null)
                    : true)
                : false,
        FillAppraisalScreenTab.survey: processKnowledge != null &&
            glossaryKnowledge != null &&
            meetingQuantity != null &&
            meetingQuality != null &&
            attitudeTowardsCustomer != null,
        FillAppraisalScreenTab.negociation: companyIntroduction != null &&
            technicalNeedCreation != null &&
            technicalPitchProficiency != null &&
            financialPitchProficiency != null &&
            attitudeAndMoodAtMeeting != null &&
            meetingCustomization != null,
        FillAppraisalScreenTab.opportunityRequestQuality:
            opportunityRequestQuality != null,
        FillAppraisalScreenTab.lifeAtWork:
            teamIntegration != null && staffSocialInteraction != null,
      };

  @override
  @computed
  Map<FillAppraisalScreenTab, Map<FillAppraisalScreenTabQuestion, bool>>
      get completedTabsQuestions => {
            FillAppraisalScreenTab.objectives: {},
            FillAppraisalScreenTab.survey: {
              FillAppraisalScreenTabQuestion.processKnowledge:
                  processKnowledge != null,
              FillAppraisalScreenTabQuestion.glossaryKnowledge:
                  glossaryKnowledge != null,
              FillAppraisalScreenTabQuestion.meetingQuantity:
                  meetingQuantity != null,
              FillAppraisalScreenTabQuestion.meetingQuality:
                  meetingQuality != null,
              FillAppraisalScreenTabQuestion.attitudeTowardsCustomer:
                  attitudeTowardsCustomer != null,
            },
            FillAppraisalScreenTab.negociation: {
              FillAppraisalScreenTabQuestion.companyIntroduction:
                  companyIntroduction != null,
              FillAppraisalScreenTabQuestion.technicalNeedCreation:
                  technicalNeedCreation != null,
              FillAppraisalScreenTabQuestion.technicalPitchProficiency:
                  technicalPitchProficiency != null,
              FillAppraisalScreenTabQuestion.financialPitchProficiency:
                  financialPitchProficiency != null,
              FillAppraisalScreenTabQuestion.attitudeAndMoodAtMeeting:
                  attitudeAndMoodAtMeeting != null,
              FillAppraisalScreenTabQuestion.meetingCustomization:
                  meetingCustomization != null,
            },
            FillAppraisalScreenTab.opportunityRequestQuality: {
              FillAppraisalScreenTabQuestion.opportunityRequestQuality:
                  opportunityRequestQuality != null,
            },
            FillAppraisalScreenTab.lifeAtWork: {
              FillAppraisalScreenTabQuestion.teamIntegration:
                  teamIntegration != null,
              FillAppraisalScreenTabQuestion.staffSocialInteraction:
                  staffSocialInteraction != null,
            },
          };

  @override
  @computed
  bool get isCompleted => completedTabs.values.every((element) => element);

  @override
  @computed
  double get percentage {
    if (editingRepresentative.isDirector == false) {
      return (completedTabs.values.where((element) => element).length + 1) /
          FillAppraisalScreenTab.values.length;
    } else {
      return currentDirectorStep.index +
          1 / FillAppraisalDirectorStep.values.length;
    }
  }

  @override
  @computed
  RepresentativeAppraisalQuestionResponse? get responseByQuestion {
    switch (activeTabQuestion) {
      case FillAppraisalScreenTabQuestion.processKnowledge:
        return processKnowledge;
      case FillAppraisalScreenTabQuestion.glossaryKnowledge:
        return glossaryKnowledge;
      case FillAppraisalScreenTabQuestion.meetingQuantity:
        return meetingQuantity;
      case FillAppraisalScreenTabQuestion.meetingQuality:
        return meetingQuality;
      case FillAppraisalScreenTabQuestion.attitudeTowardsCustomer:
        return attitudeTowardsCustomer;
      case FillAppraisalScreenTabQuestion.companyIntroduction:
        return companyIntroduction;
      case FillAppraisalScreenTabQuestion.technicalNeedCreation:
        return technicalNeedCreation;
      case FillAppraisalScreenTabQuestion.technicalPitchProficiency:
        return technicalPitchProficiency;
      case FillAppraisalScreenTabQuestion.financialPitchProficiency:
        return financialPitchProficiency;
      case FillAppraisalScreenTabQuestion.attitudeAndMoodAtMeeting:
        return attitudeAndMoodAtMeeting;
      case FillAppraisalScreenTabQuestion.meetingCustomization:
        return meetingCustomization;
      case FillAppraisalScreenTabQuestion.opportunityRequestQuality:
        return opportunityRequestQuality;
      case FillAppraisalScreenTabQuestion.teamIntegration:
        return teamIntegration;
      case FillAppraisalScreenTabQuestion.staffSocialInteraction:
        return staffSocialInteraction;
      default:
        return null;
    }
  }

  @override
  @computed
  bool get hasChanged {
    if (editingRepresentative.isDirector == false) {
      return representativeAppraisal.objective != objective ||
          representativeAppraisal.bookedMeetingCount != bookedMeetingCount ||
          representativeAppraisal.processedMeetingCount !=
              processedMeetingCount ||
          representativeAppraisal.meetingAloneCount != meetingAloneCount ||
          representativeAppraisal.meetingAccompaniedCount !=
              meetingAccompaniedCount ||
          representativeAppraisal.tapMeetingCount != tapMeetingCount ||
          representativeAppraisal.phoneMeetingCount != phoneMeetingCount ||
          representativeAppraisal.gmsMeetingCount != gmsMeetingCount ||
          representativeAppraisal.improvementPlan != improvementPlan ||
          representativeAppraisal.processKnowledge != processKnowledge ||
          representativeAppraisal.glossaryKnowledge != glossaryKnowledge ||
          representativeAppraisal.meetingQuantity != meetingQuantity ||
          representativeAppraisal.meetingQuality != meetingQuality ||
          representativeAppraisal.attitudeTowardsCustomer !=
              attitudeTowardsCustomer ||
          representativeAppraisal.companyIntroduction != companyIntroduction ||
          representativeAppraisal.technicalNeedCreation !=
              technicalNeedCreation ||
          representativeAppraisal.technicalPitchProficiency !=
              technicalPitchProficiency ||
          representativeAppraisal.financialPitchProficiency !=
              financialPitchProficiency ||
          representativeAppraisal.attitudeAndMoodAtMeeting !=
              attitudeAndMoodAtMeeting ||
          representativeAppraisal.meetingCustomization !=
              meetingCustomization ||
          representativeAppraisal.teamIntegration != teamIntegration ||
          representativeAppraisal.staffSocialInteraction !=
              staffSocialInteraction ||
          representativeAppraisal.opportunityRequestQuality !=
              opportunityRequestQuality;
    } else {
      return representativeAppraisal.improvementPlan != improvementPlan ||
          representativeAppraisal.processKnowledgeByDirector !=
              processKnowledge ||
          representativeAppraisal.glossaryKnowledgeByDirector !=
              glossaryKnowledge ||
          representativeAppraisal.meetingQuantityByDirector !=
              meetingQuantity ||
          representativeAppraisal.meetingQualityByDirector != meetingQuality ||
          representativeAppraisal.attitudeTowardsCustomerByDirector !=
              attitudeTowardsCustomer ||
          representativeAppraisal.companyIntroductionByDirector !=
              companyIntroduction ||
          representativeAppraisal.technicalNeedCreationByDirector !=
              technicalNeedCreation ||
          representativeAppraisal.technicalPitchProficiencyByDirector !=
              technicalPitchProficiency ||
          representativeAppraisal.financialPitchProficiencyByDirector !=
              financialPitchProficiency ||
          representativeAppraisal.attitudeAndMoodAtMeetingByDirector !=
              attitudeAndMoodAtMeeting ||
          representativeAppraisal.meetingCustomizationByDirector !=
              meetingCustomization ||
          representativeAppraisal.teamIntegrationByDirector !=
              teamIntegration ||
          representativeAppraisal.staffSocialInteractionByDirector !=
              staffSocialInteraction ||
          representativeAppraisal.opportunityRequestQualityByDirector !=
              opportunityRequestQuality;
    }
  }

  @override
  @computed
  bool get canChangeTab {
    if (activeTab == FillAppraisalScreenTab.objectives) {
      return completedTabs[FillAppraisalScreenTab.objectives]!;
    }
    return responseByQuestion != null;
  }

  @override
  @computed
  Stream<void> get submitStream => submitStreamController.stream;

  // Methods:-------------------------------------------------------------------
  @override
  @action
  Future<void> init() async {
    _setData();
    representativeAppraisalStreamSubscription?.cancel();
    representativeAppraisalStreamSubscription = _representativeAppraisalService
        .getByIdAsStream(representativeAppraisal.id, eager: true)
        .listen((event) {
      if (event != null) {
        representativeAppraisal = event;
        if (representativeAppraisal.representativeAppraisalFormFileDataId !=
            null) {
          submitStreamController.add(null);
        }
      }
    });
  }

  @action
  void _computeCurrentAndActiveTab({bool next = false}) {
    for (var entry in completedTabs.entries) {
      if (entry.key == FillAppraisalScreenTab.objectives &&
          entry.value == false) {
        if (next == false) {
          setActiveTab(entry.key);
        }
        break;
      } else if (entry.key != FillAppraisalScreenTab.objectives &&
          entry.value == false) {
        if (currentTab.index < entry.key.index) {
          MapEntry<FillAppraisalScreenTabQuestion, bool>? nonAnsweredQuestions =
              completedTabsQuestions[entry.key]!
                  .entries
                  .firstWhereOrNull((element) => element.value == false);
          if (nonAnsweredQuestions == null) {
            FillAppraisalScreenTab? nextTab = FillAppraisalScreenTab.values
                .firstWhereOrNull((element) => element.index > entry.key.index);
            if (nextTab != null) {
              setCurrentTabQuestion(
                  nextTab, completedTabsQuestions[nextTab]!.entries.first.key);
              if (next == false) {
                setActiveTabQuestion(nextTab,
                    completedTabsQuestions[nextTab]!.entries.first.key);
              }
              break;
            }
            break;
          } else {
            setCurrentTabQuestion(entry.key, nonAnsweredQuestions.key);
            if (next == false) {
              setActiveTabQuestion(entry.key, nonAnsweredQuestions.key);
            }
            break;
          }
        }
        break;
      }
    }
    // check if all tabs are completed
    if (completedTabs.values.every((element) => element)) {
      setCurrentTabQuestion(
          FillAppraisalScreenTab.lifeAtWork,
          completedTabsQuestions[FillAppraisalScreenTab.lifeAtWork]!
              .entries
              .last
              .key);
      if (next == false) {
        setActiveTab(FillAppraisalScreenTab.objectives);
      }
      if (editingRepresentative.isDirector == true) {
        setCurrentDirectorStep(FillAppraisalDirectorStep.validation);
      }
    }
  }

  @action
  void _setData() {
    objective = representativeAppraisal.objective;
    bookedMeetingCount = representativeAppraisal.bookedMeetingCount;
    processedMeetingCount = representativeAppraisal.processedMeetingCount;
    meetingAloneCount = representativeAppraisal.meetingAloneCount;
    meetingAccompaniedCount = representativeAppraisal.meetingAccompaniedCount;
    tapMeetingCount = representativeAppraisal.tapMeetingCount;
    phoneMeetingCount = representativeAppraisal.phoneMeetingCount;
    gmsMeetingCount = representativeAppraisal.gmsMeetingCount;
    improvementPlan = representativeAppraisal.improvementPlan;
    if (editingRepresentative.isDirector == false) {
      processKnowledge = representativeAppraisal.processKnowledge;
      glossaryKnowledge = representativeAppraisal.glossaryKnowledge;
      meetingQuantity = representativeAppraisal.meetingQuantity;
      meetingQuality = representativeAppraisal.meetingQuality;
      attitudeTowardsCustomer = representativeAppraisal.attitudeTowardsCustomer;
      companyIntroduction = representativeAppraisal.companyIntroduction;
      technicalNeedCreation = representativeAppraisal.technicalNeedCreation;
      technicalPitchProficiency =
          representativeAppraisal.technicalPitchProficiency;
      financialPitchProficiency =
          representativeAppraisal.financialPitchProficiency;
      attitudeAndMoodAtMeeting =
          representativeAppraisal.attitudeAndMoodAtMeeting;
      meetingCustomization = representativeAppraisal.meetingCustomization;
      teamIntegration = representativeAppraisal.teamIntegration;
      staffSocialInteraction = representativeAppraisal.staffSocialInteraction;
      opportunityRequestQuality =
          representativeAppraisal.opportunityRequestQuality;
    } else {
      // director
      processKnowledge = representativeAppraisal.processKnowledgeByDirector;
      glossaryKnowledge = representativeAppraisal.glossaryKnowledgeByDirector;
      meetingQuantity = representativeAppraisal.meetingQuantityByDirector;
      meetingQuality = representativeAppraisal.meetingQualityByDirector;
      attitudeTowardsCustomer =
          representativeAppraisal.attitudeTowardsCustomerByDirector;
      companyIntroduction =
          representativeAppraisal.companyIntroductionByDirector;
      technicalNeedCreation =
          representativeAppraisal.technicalNeedCreationByDirector;
      technicalPitchProficiency =
          representativeAppraisal.technicalPitchProficiencyByDirector;
      financialPitchProficiency =
          representativeAppraisal.financialPitchProficiencyByDirector;
      attitudeAndMoodAtMeeting =
          representativeAppraisal.attitudeAndMoodAtMeetingByDirector;
      meetingCustomization =
          representativeAppraisal.meetingCustomizationByDirector;
      teamIntegration = representativeAppraisal.teamIntegrationByDirector;
      staffSocialInteraction =
          representativeAppraisal.staffSocialInteractionByDirector;
      opportunityRequestQuality =
          representativeAppraisal.opportunityRequestQualityByDirector;
    }
    _computeCurrentAndActiveTab();
  }

  @override
  @action
  void setCurrentTab(FillAppraisalScreenTab tab) {
    currentTab = tab;
    currentTabQuestion = null;
  }

  @override
  @action
  void setCurrentTabQuestion(
      FillAppraisalScreenTab tab, FillAppraisalScreenTabQuestion? question) {
    currentTab = tab;
    currentTabQuestion = question;
  }

  @override
  @action
  void setActiveTab(FillAppraisalScreenTab tab) {
    activeTab = tab;
    activeTabQuestion = null;
  }

  @override
  @action
  void setActiveTabQuestion(
      FillAppraisalScreenTab tab, FillAppraisalScreenTabQuestion? question) {
    activeTab = tab;
    activeTabQuestion = question;
  }

  // director steps methods
  @override
  @action
  void setCurrentDirectorStep(FillAppraisalDirectorStep step) {
    currentDirectorStep = step;
  }

  @override
  @action
  void setActiveDirectorStep(FillAppraisalDirectorStep step) {
    activeDirectorStep = step;
  }

  @override
  @action
  void setProcessKnowledge(RepresentativeAppraisalQuestionResponse value) {
    processKnowledge = value;
  }

  @override
  @action
  void setGlossaryKnowledge(RepresentativeAppraisalQuestionResponse value) {
    glossaryKnowledge = value;
  }

  @override
  @action
  void setMeetingQuantity(RepresentativeAppraisalQuestionResponse value) {
    meetingQuantity = value;
  }

  @override
  @action
  void setMeetingQuality(RepresentativeAppraisalQuestionResponse value) {
    meetingQuality = value;
  }

  @override
  @action
  void setAttitudeTowardsCustomer(
      RepresentativeAppraisalQuestionResponse value) {
    attitudeTowardsCustomer = value;
  }

  @override
  @action
  void setCompanyIntroduction(RepresentativeAppraisalQuestionResponse value) {
    companyIntroduction = value;
  }

  @override
  @action
  void setTechnicalNeedCreation(RepresentativeAppraisalQuestionResponse value) {
    technicalNeedCreation = value;
  }

  @override
  @action
  void setTechnicalPitchProficiency(
      RepresentativeAppraisalQuestionResponse value) {
    technicalPitchProficiency = value;
  }

  @override
  @action
  void setFinancialPitchProficiency(
      RepresentativeAppraisalQuestionResponse value) {
    financialPitchProficiency = value;
  }

  @override
  @action
  void setAttitudeAndMoodAtMeeting(
      RepresentativeAppraisalQuestionResponse value) {
    attitudeAndMoodAtMeeting = value;
  }

  @override
  @action
  void setMeetingCustomization(RepresentativeAppraisalQuestionResponse value) {
    meetingCustomization = value;
  }

  @override
  @action
  void setOpportunityRequestQuality(
      RepresentativeAppraisalQuestionResponse value) {
    opportunityRequestQuality = value;
  }

  @override
  @action
  void setTeamIntegration(RepresentativeAppraisalQuestionResponse value) {
    teamIntegration = value;
  }

  @override
  @action
  void setStaffSocialInteraction(
      RepresentativeAppraisalQuestionResponse value) {
    staffSocialInteraction = value;
  }

  @override
  @action
  void setObjective(String value) {
    if (value.isEmpty) {
      objective = null;
      return;
    }
    objective = getIt<NumberFormatterUtilsInterface>().parseToDouble(value);
  }

  @override
  @action
  void setBookedMeetingCount(String value) {
    if (value.isEmpty) {
      bookedMeetingCount = null;
      return;
    }
    bookedMeetingCount = int.parse(value);
  }

  @override
  @action
  void setProcessedMeetingCount(String value) {
    if (value.isEmpty) {
      processedMeetingCount = null;
      return;
    }
    processedMeetingCount = int.parse(value);
  }

  @override
  @action
  void setMeetingAloneCount(String value) {
    if (value.isEmpty) {
      meetingAloneCount = null;
      return;
    }
    meetingAloneCount = int.parse(value);
  }

  @override
  @action
  void setMeetingAccompaniedCount(String value) {
    if (value.isEmpty) {
      meetingAccompaniedCount = null;
      return;
    }
    meetingAccompaniedCount = int.parse(value);
  }

  @override
  @action
  void setTapMeetingCount(String value) {
    if (value.isEmpty) {
      tapMeetingCount = null;
      return;
    }
    tapMeetingCount = int.parse(value);
  }

  @override
  @action
  void setPhoneMeetingCount(String value) {
    if (value.isEmpty) {
      phoneMeetingCount = null;
      return;
    }
    phoneMeetingCount = int.parse(value);
  }

  @override
  @action
  void setGmsMeetingCount(String value) {
    if (value.isEmpty) {
      gmsMeetingCount = null;
      return;
    }
    gmsMeetingCount = int.parse(value);
  }

  @override
  @action
  void setImprovementPlan(String value) {
    improvementPlan = value;
  }

  @override
  @action
  void setResponseByQuestion(RepresentativeAppraisalQuestionResponse value) {
    switch (activeTabQuestion) {
      case FillAppraisalScreenTabQuestion.processKnowledge:
        setProcessKnowledge(value);
        break;
      case FillAppraisalScreenTabQuestion.glossaryKnowledge:
        setGlossaryKnowledge(value);
        break;
      case FillAppraisalScreenTabQuestion.meetingQuantity:
        setMeetingQuantity(value);
        break;
      case FillAppraisalScreenTabQuestion.meetingQuality:
        setMeetingQuality(value);
        break;
      case FillAppraisalScreenTabQuestion.attitudeTowardsCustomer:
        setAttitudeTowardsCustomer(value);
        break;
      case FillAppraisalScreenTabQuestion.companyIntroduction:
        setCompanyIntroduction(value);
        break;
      case FillAppraisalScreenTabQuestion.technicalNeedCreation:
        setTechnicalNeedCreation(value);
        break;
      case FillAppraisalScreenTabQuestion.technicalPitchProficiency:
        setTechnicalPitchProficiency(value);
        break;
      case FillAppraisalScreenTabQuestion.financialPitchProficiency:
        setFinancialPitchProficiency(value);
        break;
      case FillAppraisalScreenTabQuestion.attitudeAndMoodAtMeeting:
        setAttitudeAndMoodAtMeeting(value);
        break;
      case FillAppraisalScreenTabQuestion.meetingCustomization:
        setMeetingCustomization(value);
        break;
      case FillAppraisalScreenTabQuestion.opportunityRequestQuality:
        setOpportunityRequestQuality(value);
        break;
      case FillAppraisalScreenTabQuestion.teamIntegration:
        setTeamIntegration(value);
        break;
      case FillAppraisalScreenTabQuestion.staffSocialInteraction:
        setStaffSocialInteraction(value);
        break;
      case null:
        break;
    }
  }

  @override
  @action
  void previous() {
    submit();
    if (activeTabQuestion != null &&
        FillAppraisalScreenTab.questionsByTab[activeTab]!
                .firstWhereOrNull((element) => element == activeTabQuestion) !=
            FillAppraisalScreenTab.questionsByTab[activeTab]!.first) {
      setActiveTabQuestion(activeTab,
          FillAppraisalScreenTabQuestion.values[activeTabQuestion!.index - 1]);
    } else {
      if (activeTab.index == 0) {
        return;
      }
      FillAppraisalScreenTab previousTab =
          FillAppraisalScreenTab.values[activeTab.index - 1];
      if (completedTabsQuestions[previousTab]!.entries.isNotEmpty) {
        setActiveTabQuestion(
            previousTab, completedTabsQuestions[previousTab]!.entries.last.key);
      } else {
        setActiveTab(previousTab);
      }
    }
  }

  @override
  @action
  void next() {
    submit();
    if (activeTabQuestion != null &&
        activeTabQuestion!.index ==
            FillAppraisalScreenTabQuestion.values.length - 1) {
      return;
    }
    if (activeTab == currentTab && activeTabQuestion == currentTabQuestion) {
      _computeCurrentAndActiveTab(next: true);
    }
    if (activeTabQuestion != null &&
        FillAppraisalScreenTab.questionsByTab[activeTab]!
                .firstWhereOrNull((element) => element == activeTabQuestion) !=
            FillAppraisalScreenTab.questionsByTab[activeTab]!.last) {
      if (currentTabQuestion!.index == activeTabQuestion!.index) {
        setCurrentTabQuestion(
            activeTab,
            FillAppraisalScreenTabQuestion
                .values[activeTabQuestion!.index + 1]);
      }
      setActiveTabQuestion(activeTab,
          FillAppraisalScreenTabQuestion.values[activeTabQuestion!.index + 1]);
    } else {
      if (activeTab.index == FillAppraisalScreenTab.values.length - 1) {
        return;
      }
      FillAppraisalScreenTab nextTab =
          FillAppraisalScreenTab.values[activeTab.index + 1];
      if (currentTab.index == activeTab.index) {
        setCurrentTabQuestion(
            nextTab, completedTabsQuestions[nextTab]!.entries.first.key);
      }
      setActiveTabQuestion(
          nextTab, completedTabsQuestions[nextTab]!.entries.first.key);
    }
  }

  @override
  @action
  void previousDirectorStep() {
    if (activeDirectorStep.index == 0) {
      return;
    }
    setActiveDirectorStep(
        FillAppraisalDirectorStep.values[currentDirectorStep.index - 1]);
  }

  @override
  @action
  void nextDirectorStep() {
    submit();
    if (activeDirectorStep == currentDirectorStep) {
      if (currentDirectorStep.index ==
          FillAppraisalDirectorStep.values.length - 1) {
        return;
      }
      setCurrentDirectorStep(
          FillAppraisalDirectorStep.values[currentDirectorStep.index + 1]);
    }
    setActiveDirectorStep(
        FillAppraisalDirectorStep.values[activeDirectorStep.index + 1]);
  }

  @override
  @action
  Future<void> submit() async {
    if (hasChanged == false) {
      return;
    }
    if (editingRepresentative.isDirector == false) {
      representativeAppraisal = representativeAppraisal.copyWith(
        completedByRepresentativeAt: isCompleted ? DateTime.now() : null,
        processKnowledge: () => processKnowledge,
        glossaryKnowledge: () => glossaryKnowledge,
        meetingQuantity: () => meetingQuantity,
        meetingQuality: () => meetingQuality,
        attitudeTowardsCustomer: () => attitudeTowardsCustomer,
        companyIntroduction: () => companyIntroduction,
        technicalNeedCreation: () => technicalNeedCreation,
        technicalPitchProficiency: () => technicalPitchProficiency,
        financialPitchProficiency: () => financialPitchProficiency,
        attitudeAndMoodAtMeeting: () => attitudeAndMoodAtMeeting,
        meetingCustomization: () => meetingCustomization,
        teamIntegration: () => teamIntegration,
        staffSocialInteraction: () => staffSocialInteraction,
        opportunityRequestQuality: () => opportunityRequestQuality,
        objective: () => objective,
        bookedMeetingCount: () => bookedMeetingCount,
        processedMeetingCount: () => processedMeetingCount,
        meetingAloneCount: () => meetingAloneCount,
        meetingAccompaniedCount: () => meetingAccompaniedCount,
        tapMeetingCount: () => tapMeetingCount,
        phoneMeetingCount: () => phoneMeetingCount,
        gmsMeetingCount: () => gmsMeetingCount,
        improvementPlan: () => improvementPlan,
      );
    } else {
      representativeAppraisal = representativeAppraisal.copyWith(
        completingDirectorId: editingRepresentative.id,
        completedByDirectorAt: isCompleted ? DateTime.now() : null,
        processKnowledgeByDirector: () => processKnowledge,
        glossaryKnowledgeByDirector: () => glossaryKnowledge,
        meetingQuantityByDirector: () => meetingQuantity,
        meetingQualityByDirector: () => meetingQuality,
        attitudeTowardsCustomerByDirector: () => attitudeTowardsCustomer,
        companyIntroductionByDirector: () => companyIntroduction,
        technicalNeedCreationByDirector: () => technicalNeedCreation,
        technicalPitchProficiencyByDirector: () => technicalPitchProficiency,
        financialPitchProficiencyByDirector: () => financialPitchProficiency,
        attitudeAndMoodAtMeetingByDirector: () => attitudeAndMoodAtMeeting,
        meetingCustomizationByDirector: () => meetingCustomization,
        teamIntegrationByDirector: () => teamIntegration,
        staffSocialInteractionByDirector: () => staffSocialInteraction,
        opportunityRequestQualityByDirector: () => opportunityRequestQuality,
        improvementPlan: () => improvementPlan,
      );
    }
    await _representativeAppraisalService.update(representativeAppraisal);
  }

  @override
  @action
  Future<void> setRepresentativeAppraisalFormFileDataId(
      String? fileDataId) async {
    representativeAppraisal = representativeAppraisal.copyWith(
      representativeAppraisalFormFileDataId: () => fileDataId,
    );
    await _representativeAppraisalService.update(representativeAppraisal);
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    representativeAppraisalStreamSubscription?.cancel();
    submitStreamController.close();
  }
}
