// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fill_appraisal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FillAppraisalStore on _FillAppraisalStoreBase, Store {
  Computed<Map<FillAppraisalScreenTab, bool>>? _$completedTabsComputed;

  @override
  Map<FillAppraisalScreenTab, bool> get completedTabs =>
      (_$completedTabsComputed ??= Computed<Map<FillAppraisalScreenTab, bool>>(
              () => super.completedTabs,
              name: '_FillAppraisalStoreBase.completedTabs'))
          .value;
  Computed<
          Map<FillAppraisalScreenTab,
              Map<FillAppraisalScreenTabQuestion, bool>>>?
      _$completedTabsQuestionsComputed;

  @override
  Map<FillAppraisalScreenTab, Map<FillAppraisalScreenTabQuestion, bool>>
      get completedTabsQuestions =>
          (_$completedTabsQuestionsComputed ??= Computed<
                      Map<FillAppraisalScreenTab,
                          Map<FillAppraisalScreenTabQuestion, bool>>>(
                  () => super.completedTabsQuestions,
                  name: '_FillAppraisalStoreBase.completedTabsQuestions'))
              .value;
  Computed<bool>? _$isCompletedComputed;

  @override
  bool get isCompleted =>
      (_$isCompletedComputed ??= Computed<bool>(() => super.isCompleted,
              name: '_FillAppraisalStoreBase.isCompleted'))
          .value;
  Computed<double>? _$percentageComputed;

  @override
  double get percentage =>
      (_$percentageComputed ??= Computed<double>(() => super.percentage,
              name: '_FillAppraisalStoreBase.percentage'))
          .value;
  Computed<RepresentativeAppraisalQuestionResponse?>?
      _$responseByQuestionComputed;

  @override
  RepresentativeAppraisalQuestionResponse? get responseByQuestion =>
      (_$responseByQuestionComputed ??=
              Computed<RepresentativeAppraisalQuestionResponse?>(
                  () => super.responseByQuestion,
                  name: '_FillAppraisalStoreBase.responseByQuestion'))
          .value;
  Computed<bool>? _$hasChangedComputed;

  @override
  bool get hasChanged =>
      (_$hasChangedComputed ??= Computed<bool>(() => super.hasChanged,
              name: '_FillAppraisalStoreBase.hasChanged'))
          .value;
  Computed<bool>? _$canChangeTabComputed;

  @override
  bool get canChangeTab =>
      (_$canChangeTabComputed ??= Computed<bool>(() => super.canChangeTab,
              name: '_FillAppraisalStoreBase.canChangeTab'))
          .value;
  Computed<Stream<void>>? _$submitStreamComputed;

  @override
  Stream<void> get submitStream => (_$submitStreamComputed ??=
          Computed<Stream<void>>(() => super.submitStream,
              name: '_FillAppraisalStoreBase.submitStream'))
      .value;

  late final _$representativeAppraisalAtom = Atom(
      name: '_FillAppraisalStoreBase.representativeAppraisal',
      context: context);

  @override
  RepresentativeAppraisal get representativeAppraisal {
    _$representativeAppraisalAtom.reportRead();
    return super.representativeAppraisal;
  }

  @override
  set representativeAppraisal(RepresentativeAppraisal value) {
    _$representativeAppraisalAtom
        .reportWrite(value, super.representativeAppraisal, () {
      super.representativeAppraisal = value;
    });
  }

  late final _$editingRepresentativeAtom = Atom(
      name: '_FillAppraisalStoreBase.editingRepresentative', context: context);

  @override
  Representative get editingRepresentative {
    _$editingRepresentativeAtom.reportRead();
    return super.editingRepresentative;
  }

  @override
  set editingRepresentative(Representative value) {
    _$editingRepresentativeAtom.reportWrite(value, super.editingRepresentative,
        () {
      super.editingRepresentative = value;
    });
  }

  late final _$currentTabAtom =
      Atom(name: '_FillAppraisalStoreBase.currentTab', context: context);

  @override
  FillAppraisalScreenTab get currentTab {
    _$currentTabAtom.reportRead();
    return super.currentTab;
  }

  @override
  set currentTab(FillAppraisalScreenTab value) {
    _$currentTabAtom.reportWrite(value, super.currentTab, () {
      super.currentTab = value;
    });
  }

  late final _$currentTabQuestionAtom = Atom(
      name: '_FillAppraisalStoreBase.currentTabQuestion', context: context);

  @override
  FillAppraisalScreenTabQuestion? get currentTabQuestion {
    _$currentTabQuestionAtom.reportRead();
    return super.currentTabQuestion;
  }

  @override
  set currentTabQuestion(FillAppraisalScreenTabQuestion? value) {
    _$currentTabQuestionAtom.reportWrite(value, super.currentTabQuestion, () {
      super.currentTabQuestion = value;
    });
  }

  late final _$activeTabAtom =
      Atom(name: '_FillAppraisalStoreBase.activeTab', context: context);

  @override
  FillAppraisalScreenTab get activeTab {
    _$activeTabAtom.reportRead();
    return super.activeTab;
  }

  @override
  set activeTab(FillAppraisalScreenTab value) {
    _$activeTabAtom.reportWrite(value, super.activeTab, () {
      super.activeTab = value;
    });
  }

  late final _$activeTabQuestionAtom =
      Atom(name: '_FillAppraisalStoreBase.activeTabQuestion', context: context);

  @override
  FillAppraisalScreenTabQuestion? get activeTabQuestion {
    _$activeTabQuestionAtom.reportRead();
    return super.activeTabQuestion;
  }

  @override
  set activeTabQuestion(FillAppraisalScreenTabQuestion? value) {
    _$activeTabQuestionAtom.reportWrite(value, super.activeTabQuestion, () {
      super.activeTabQuestion = value;
    });
  }

  late final _$currentDirectorStepAtom = Atom(
      name: '_FillAppraisalStoreBase.currentDirectorStep', context: context);

  @override
  FillAppraisalDirectorStep get currentDirectorStep {
    _$currentDirectorStepAtom.reportRead();
    return super.currentDirectorStep;
  }

  @override
  set currentDirectorStep(FillAppraisalDirectorStep value) {
    _$currentDirectorStepAtom.reportWrite(value, super.currentDirectorStep, () {
      super.currentDirectorStep = value;
    });
  }

  late final _$activeDirectorStepAtom = Atom(
      name: '_FillAppraisalStoreBase.activeDirectorStep', context: context);

  @override
  FillAppraisalDirectorStep get activeDirectorStep {
    _$activeDirectorStepAtom.reportRead();
    return super.activeDirectorStep;
  }

  @override
  set activeDirectorStep(FillAppraisalDirectorStep value) {
    _$activeDirectorStepAtom.reportWrite(value, super.activeDirectorStep, () {
      super.activeDirectorStep = value;
    });
  }

  late final _$processKnowledgeAtom =
      Atom(name: '_FillAppraisalStoreBase.processKnowledge', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get processKnowledge {
    _$processKnowledgeAtom.reportRead();
    return super.processKnowledge;
  }

  @override
  set processKnowledge(RepresentativeAppraisalQuestionResponse? value) {
    _$processKnowledgeAtom.reportWrite(value, super.processKnowledge, () {
      super.processKnowledge = value;
    });
  }

  late final _$glossaryKnowledgeAtom =
      Atom(name: '_FillAppraisalStoreBase.glossaryKnowledge', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get glossaryKnowledge {
    _$glossaryKnowledgeAtom.reportRead();
    return super.glossaryKnowledge;
  }

  @override
  set glossaryKnowledge(RepresentativeAppraisalQuestionResponse? value) {
    _$glossaryKnowledgeAtom.reportWrite(value, super.glossaryKnowledge, () {
      super.glossaryKnowledge = value;
    });
  }

  late final _$meetingQuantityAtom =
      Atom(name: '_FillAppraisalStoreBase.meetingQuantity', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get meetingQuantity {
    _$meetingQuantityAtom.reportRead();
    return super.meetingQuantity;
  }

  @override
  set meetingQuantity(RepresentativeAppraisalQuestionResponse? value) {
    _$meetingQuantityAtom.reportWrite(value, super.meetingQuantity, () {
      super.meetingQuantity = value;
    });
  }

  late final _$meetingQualityAtom =
      Atom(name: '_FillAppraisalStoreBase.meetingQuality', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get meetingQuality {
    _$meetingQualityAtom.reportRead();
    return super.meetingQuality;
  }

  @override
  set meetingQuality(RepresentativeAppraisalQuestionResponse? value) {
    _$meetingQualityAtom.reportWrite(value, super.meetingQuality, () {
      super.meetingQuality = value;
    });
  }

  late final _$attitudeTowardsCustomerAtom = Atom(
      name: '_FillAppraisalStoreBase.attitudeTowardsCustomer',
      context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get attitudeTowardsCustomer {
    _$attitudeTowardsCustomerAtom.reportRead();
    return super.attitudeTowardsCustomer;
  }

  @override
  set attitudeTowardsCustomer(RepresentativeAppraisalQuestionResponse? value) {
    _$attitudeTowardsCustomerAtom
        .reportWrite(value, super.attitudeTowardsCustomer, () {
      super.attitudeTowardsCustomer = value;
    });
  }

  late final _$companyIntroductionAtom = Atom(
      name: '_FillAppraisalStoreBase.companyIntroduction', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get companyIntroduction {
    _$companyIntroductionAtom.reportRead();
    return super.companyIntroduction;
  }

  @override
  set companyIntroduction(RepresentativeAppraisalQuestionResponse? value) {
    _$companyIntroductionAtom.reportWrite(value, super.companyIntroduction, () {
      super.companyIntroduction = value;
    });
  }

  late final _$technicalNeedCreationAtom = Atom(
      name: '_FillAppraisalStoreBase.technicalNeedCreation', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get technicalNeedCreation {
    _$technicalNeedCreationAtom.reportRead();
    return super.technicalNeedCreation;
  }

  @override
  set technicalNeedCreation(RepresentativeAppraisalQuestionResponse? value) {
    _$technicalNeedCreationAtom.reportWrite(value, super.technicalNeedCreation,
        () {
      super.technicalNeedCreation = value;
    });
  }

  late final _$technicalPitchProficiencyAtom = Atom(
      name: '_FillAppraisalStoreBase.technicalPitchProficiency',
      context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get technicalPitchProficiency {
    _$technicalPitchProficiencyAtom.reportRead();
    return super.technicalPitchProficiency;
  }

  @override
  set technicalPitchProficiency(
      RepresentativeAppraisalQuestionResponse? value) {
    _$technicalPitchProficiencyAtom
        .reportWrite(value, super.technicalPitchProficiency, () {
      super.technicalPitchProficiency = value;
    });
  }

  late final _$financialPitchProficiencyAtom = Atom(
      name: '_FillAppraisalStoreBase.financialPitchProficiency',
      context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get financialPitchProficiency {
    _$financialPitchProficiencyAtom.reportRead();
    return super.financialPitchProficiency;
  }

  @override
  set financialPitchProficiency(
      RepresentativeAppraisalQuestionResponse? value) {
    _$financialPitchProficiencyAtom
        .reportWrite(value, super.financialPitchProficiency, () {
      super.financialPitchProficiency = value;
    });
  }

  late final _$attitudeAndMoodAtMeetingAtom = Atom(
      name: '_FillAppraisalStoreBase.attitudeAndMoodAtMeeting',
      context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get attitudeAndMoodAtMeeting {
    _$attitudeAndMoodAtMeetingAtom.reportRead();
    return super.attitudeAndMoodAtMeeting;
  }

  @override
  set attitudeAndMoodAtMeeting(RepresentativeAppraisalQuestionResponse? value) {
    _$attitudeAndMoodAtMeetingAtom
        .reportWrite(value, super.attitudeAndMoodAtMeeting, () {
      super.attitudeAndMoodAtMeeting = value;
    });
  }

  late final _$meetingCustomizationAtom = Atom(
      name: '_FillAppraisalStoreBase.meetingCustomization', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get meetingCustomization {
    _$meetingCustomizationAtom.reportRead();
    return super.meetingCustomization;
  }

  @override
  set meetingCustomization(RepresentativeAppraisalQuestionResponse? value) {
    _$meetingCustomizationAtom.reportWrite(value, super.meetingCustomization,
        () {
      super.meetingCustomization = value;
    });
  }

  late final _$teamIntegrationAtom =
      Atom(name: '_FillAppraisalStoreBase.teamIntegration', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get teamIntegration {
    _$teamIntegrationAtom.reportRead();
    return super.teamIntegration;
  }

  @override
  set teamIntegration(RepresentativeAppraisalQuestionResponse? value) {
    _$teamIntegrationAtom.reportWrite(value, super.teamIntegration, () {
      super.teamIntegration = value;
    });
  }

  late final _$staffSocialInteractionAtom = Atom(
      name: '_FillAppraisalStoreBase.staffSocialInteraction', context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get staffSocialInteraction {
    _$staffSocialInteractionAtom.reportRead();
    return super.staffSocialInteraction;
  }

  @override
  set staffSocialInteraction(RepresentativeAppraisalQuestionResponse? value) {
    _$staffSocialInteractionAtom
        .reportWrite(value, super.staffSocialInteraction, () {
      super.staffSocialInteraction = value;
    });
  }

  late final _$opportunityRequestQualityAtom = Atom(
      name: '_FillAppraisalStoreBase.opportunityRequestQuality',
      context: context);

  @override
  RepresentativeAppraisalQuestionResponse? get opportunityRequestQuality {
    _$opportunityRequestQualityAtom.reportRead();
    return super.opportunityRequestQuality;
  }

  @override
  set opportunityRequestQuality(
      RepresentativeAppraisalQuestionResponse? value) {
    _$opportunityRequestQualityAtom
        .reportWrite(value, super.opportunityRequestQuality, () {
      super.opportunityRequestQuality = value;
    });
  }

  late final _$objectiveAtom =
      Atom(name: '_FillAppraisalStoreBase.objective', context: context);

  @override
  double? get objective {
    _$objectiveAtom.reportRead();
    return super.objective;
  }

  @override
  set objective(double? value) {
    _$objectiveAtom.reportWrite(value, super.objective, () {
      super.objective = value;
    });
  }

  late final _$bookedMeetingCountAtom = Atom(
      name: '_FillAppraisalStoreBase.bookedMeetingCount', context: context);

  @override
  int? get bookedMeetingCount {
    _$bookedMeetingCountAtom.reportRead();
    return super.bookedMeetingCount;
  }

  @override
  set bookedMeetingCount(int? value) {
    _$bookedMeetingCountAtom.reportWrite(value, super.bookedMeetingCount, () {
      super.bookedMeetingCount = value;
    });
  }

  late final _$processedMeetingCountAtom = Atom(
      name: '_FillAppraisalStoreBase.processedMeetingCount', context: context);

  @override
  int? get processedMeetingCount {
    _$processedMeetingCountAtom.reportRead();
    return super.processedMeetingCount;
  }

  @override
  set processedMeetingCount(int? value) {
    _$processedMeetingCountAtom.reportWrite(value, super.processedMeetingCount,
        () {
      super.processedMeetingCount = value;
    });
  }

  late final _$meetingAloneCountAtom =
      Atom(name: '_FillAppraisalStoreBase.meetingAloneCount', context: context);

  @override
  int? get meetingAloneCount {
    _$meetingAloneCountAtom.reportRead();
    return super.meetingAloneCount;
  }

  @override
  set meetingAloneCount(int? value) {
    _$meetingAloneCountAtom.reportWrite(value, super.meetingAloneCount, () {
      super.meetingAloneCount = value;
    });
  }

  late final _$meetingAccompaniedCountAtom = Atom(
      name: '_FillAppraisalStoreBase.meetingAccompaniedCount',
      context: context);

  @override
  int? get meetingAccompaniedCount {
    _$meetingAccompaniedCountAtom.reportRead();
    return super.meetingAccompaniedCount;
  }

  @override
  set meetingAccompaniedCount(int? value) {
    _$meetingAccompaniedCountAtom
        .reportWrite(value, super.meetingAccompaniedCount, () {
      super.meetingAccompaniedCount = value;
    });
  }

  late final _$tapMeetingCountAtom =
      Atom(name: '_FillAppraisalStoreBase.tapMeetingCount', context: context);

  @override
  int? get tapMeetingCount {
    _$tapMeetingCountAtom.reportRead();
    return super.tapMeetingCount;
  }

  @override
  set tapMeetingCount(int? value) {
    _$tapMeetingCountAtom.reportWrite(value, super.tapMeetingCount, () {
      super.tapMeetingCount = value;
    });
  }

  late final _$phoneMeetingCountAtom =
      Atom(name: '_FillAppraisalStoreBase.phoneMeetingCount', context: context);

  @override
  int? get phoneMeetingCount {
    _$phoneMeetingCountAtom.reportRead();
    return super.phoneMeetingCount;
  }

  @override
  set phoneMeetingCount(int? value) {
    _$phoneMeetingCountAtom.reportWrite(value, super.phoneMeetingCount, () {
      super.phoneMeetingCount = value;
    });
  }

  late final _$gmsMeetingCountAtom =
      Atom(name: '_FillAppraisalStoreBase.gmsMeetingCount', context: context);

  @override
  int? get gmsMeetingCount {
    _$gmsMeetingCountAtom.reportRead();
    return super.gmsMeetingCount;
  }

  @override
  set gmsMeetingCount(int? value) {
    _$gmsMeetingCountAtom.reportWrite(value, super.gmsMeetingCount, () {
      super.gmsMeetingCount = value;
    });
  }

  late final _$improvementPlanAtom =
      Atom(name: '_FillAppraisalStoreBase.improvementPlan', context: context);

  @override
  String? get improvementPlan {
    _$improvementPlanAtom.reportRead();
    return super.improvementPlan;
  }

  @override
  set improvementPlan(String? value) {
    _$improvementPlanAtom.reportWrite(value, super.improvementPlan, () {
      super.improvementPlan = value;
    });
  }

  late final _$representativeAppraisalStreamSubscriptionAtom = Atom(
      name: '_FillAppraisalStoreBase.representativeAppraisalStreamSubscription',
      context: context);

  @override
  StreamSubscription<RepresentativeAppraisal?>?
      get representativeAppraisalStreamSubscription {
    _$representativeAppraisalStreamSubscriptionAtom.reportRead();
    return super.representativeAppraisalStreamSubscription;
  }

  @override
  set representativeAppraisalStreamSubscription(
      StreamSubscription<RepresentativeAppraisal?>? value) {
    _$representativeAppraisalStreamSubscriptionAtom.reportWrite(
        value, super.representativeAppraisalStreamSubscription, () {
      super.representativeAppraisalStreamSubscription = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_FillAppraisalStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$submitAsyncAction =
      AsyncAction('_FillAppraisalStoreBase.submit', context: context);

  @override
  Future<void> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  late final _$setRepresentativeAppraisalFormFileDataIdAsyncAction =
      AsyncAction(
          '_FillAppraisalStoreBase.setRepresentativeAppraisalFormFileDataId',
          context: context);

  @override
  Future<void> setRepresentativeAppraisalFormFileDataId(String? fileDataId) {
    return _$setRepresentativeAppraisalFormFileDataIdAsyncAction
        .run(() => super.setRepresentativeAppraisalFormFileDataId(fileDataId));
  }

  late final _$_FillAppraisalStoreBaseActionController =
      ActionController(name: '_FillAppraisalStoreBase', context: context);

  @override
  void _computeCurrentAndActiveTab({bool next = false}) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase._computeCurrentAndActiveTab');
    try {
      return super._computeCurrentAndActiveTab(next: next);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setData() {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase._setData');
    try {
      return super._setData();
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentTab(FillAppraisalScreenTab tab) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setCurrentTab');
    try {
      return super.setCurrentTab(tab);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentTabQuestion(
      FillAppraisalScreenTab tab, FillAppraisalScreenTabQuestion? question) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setCurrentTabQuestion');
    try {
      return super.setCurrentTabQuestion(tab, question);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActiveTab(FillAppraisalScreenTab tab) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setActiveTab');
    try {
      return super.setActiveTab(tab);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActiveTabQuestion(
      FillAppraisalScreenTab tab, FillAppraisalScreenTabQuestion? question) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setActiveTabQuestion');
    try {
      return super.setActiveTabQuestion(tab, question);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentDirectorStep(FillAppraisalDirectorStep step) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setCurrentDirectorStep');
    try {
      return super.setCurrentDirectorStep(step);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActiveDirectorStep(FillAppraisalDirectorStep step) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setActiveDirectorStep');
    try {
      return super.setActiveDirectorStep(step);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProcessKnowledge(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setProcessKnowledge');
    try {
      return super.setProcessKnowledge(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGlossaryKnowledge(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setGlossaryKnowledge');
    try {
      return super.setGlossaryKnowledge(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetingQuantity(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setMeetingQuantity');
    try {
      return super.setMeetingQuantity(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetingQuality(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setMeetingQuality');
    try {
      return super.setMeetingQuality(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAttitudeTowardsCustomer(
      RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setAttitudeTowardsCustomer');
    try {
      return super.setAttitudeTowardsCustomer(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCompanyIntroduction(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setCompanyIntroduction');
    try {
      return super.setCompanyIntroduction(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTechnicalNeedCreation(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setTechnicalNeedCreation');
    try {
      return super.setTechnicalNeedCreation(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTechnicalPitchProficiency(
      RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setTechnicalPitchProficiency');
    try {
      return super.setTechnicalPitchProficiency(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFinancialPitchProficiency(
      RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setFinancialPitchProficiency');
    try {
      return super.setFinancialPitchProficiency(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAttitudeAndMoodAtMeeting(
      RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setAttitudeAndMoodAtMeeting');
    try {
      return super.setAttitudeAndMoodAtMeeting(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetingCustomization(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setMeetingCustomization');
    try {
      return super.setMeetingCustomization(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOpportunityRequestQuality(
      RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setOpportunityRequestQuality');
    try {
      return super.setOpportunityRequestQuality(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTeamIntegration(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setTeamIntegration');
    try {
      return super.setTeamIntegration(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStaffSocialInteraction(
      RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setStaffSocialInteraction');
    try {
      return super.setStaffSocialInteraction(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setObjective(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setObjective');
    try {
      return super.setObjective(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBookedMeetingCount(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setBookedMeetingCount');
    try {
      return super.setBookedMeetingCount(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProcessedMeetingCount(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setProcessedMeetingCount');
    try {
      return super.setProcessedMeetingCount(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetingAloneCount(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setMeetingAloneCount');
    try {
      return super.setMeetingAloneCount(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetingAccompaniedCount(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setMeetingAccompaniedCount');
    try {
      return super.setMeetingAccompaniedCount(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTapMeetingCount(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setTapMeetingCount');
    try {
      return super.setTapMeetingCount(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneMeetingCount(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setPhoneMeetingCount');
    try {
      return super.setPhoneMeetingCount(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGmsMeetingCount(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setGmsMeetingCount');
    try {
      return super.setGmsMeetingCount(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImprovementPlan(String value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setImprovementPlan');
    try {
      return super.setImprovementPlan(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setResponseByQuestion(RepresentativeAppraisalQuestionResponse value) {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.setResponseByQuestion');
    try {
      return super.setResponseByQuestion(value);
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previous() {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.previous');
    try {
      return super.previous();
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void next() {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.next');
    try {
      return super.next();
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousDirectorStep() {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.previousDirectorStep');
    try {
      return super.previousDirectorStep();
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextDirectorStep() {
    final _$actionInfo = _$_FillAppraisalStoreBaseActionController.startAction(
        name: '_FillAppraisalStoreBase.nextDirectorStep');
    try {
      return super.nextDirectorStep();
    } finally {
      _$_FillAppraisalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
representativeAppraisal: ${representativeAppraisal},
editingRepresentative: ${editingRepresentative},
currentTab: ${currentTab},
currentTabQuestion: ${currentTabQuestion},
activeTab: ${activeTab},
activeTabQuestion: ${activeTabQuestion},
currentDirectorStep: ${currentDirectorStep},
activeDirectorStep: ${activeDirectorStep},
processKnowledge: ${processKnowledge},
glossaryKnowledge: ${glossaryKnowledge},
meetingQuantity: ${meetingQuantity},
meetingQuality: ${meetingQuality},
attitudeTowardsCustomer: ${attitudeTowardsCustomer},
companyIntroduction: ${companyIntroduction},
technicalNeedCreation: ${technicalNeedCreation},
technicalPitchProficiency: ${technicalPitchProficiency},
financialPitchProficiency: ${financialPitchProficiency},
attitudeAndMoodAtMeeting: ${attitudeAndMoodAtMeeting},
meetingCustomization: ${meetingCustomization},
teamIntegration: ${teamIntegration},
staffSocialInteraction: ${staffSocialInteraction},
opportunityRequestQuality: ${opportunityRequestQuality},
objective: ${objective},
bookedMeetingCount: ${bookedMeetingCount},
processedMeetingCount: ${processedMeetingCount},
meetingAloneCount: ${meetingAloneCount},
meetingAccompaniedCount: ${meetingAccompaniedCount},
tapMeetingCount: ${tapMeetingCount},
phoneMeetingCount: ${phoneMeetingCount},
gmsMeetingCount: ${gmsMeetingCount},
improvementPlan: ${improvementPlan},
representativeAppraisalStreamSubscription: ${representativeAppraisalStreamSubscription},
completedTabs: ${completedTabs},
completedTabsQuestions: ${completedTabsQuestions},
isCompleted: ${isCompleted},
percentage: ${percentage},
responseByQuestion: ${responseByQuestion},
hasChanged: ${hasChanged},
canChangeTab: ${canChangeTab},
submitStream: ${submitStream}
    ''';
  }
}
