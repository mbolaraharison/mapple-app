import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:visibility_detector/visibility_detector.dart';

// Interface:-------------------------------------------------------------------
abstract class FillAppraisalScreenInterface implements Widget {
  FillAppraisalScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class FillAppraisalScreen extends StatefulWidget
    implements FillAppraisalScreenInterface {
  // Constructor:---------------------------------------------------------------
  const FillAppraisalScreen({super.key, required this.arguments});

  // Properties:----------------------------------------------------------------
  @override
  final FillAppraisalScreenArguments arguments;

  @override
  State<FillAppraisalScreen> createState() => _FillAppraisalScreenState();
}

class _FillAppraisalScreenState extends State<FillAppraisalScreen>
    with TickerProviderStateMixin {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _bookedMeetingCountController =
      TextEditingController();
  final TextEditingController _processedMeetingCountController =
      TextEditingController();
  final TextEditingController _meetingAloneCountController =
      TextEditingController();
  final TextEditingController _meetingAccompaniedCountController =
      TextEditingController();
  final TextEditingController _tapMeetingCountController =
      TextEditingController();
  final TextEditingController _phoneMeetingCountController =
      TextEditingController();
  final TextEditingController _gmsMeetingCountController =
      TextEditingController();
  final TextEditingController _improvementPlanController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey scrollKey = GlobalKey();
  late final Map<FillAppraisalScreenTab, Map<String, dynamic>> tabKeys;
  late final Map<FillAppraisalScreenTabQuestion, Map<String, dynamic>>
      tabQuestionKeys;
  bool rebuild = false;

  // Services:------------------------------------------------------------------
  final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();
  late final RepresentativeAppraisalFormGeneratorInterface
      _representativeAppraisalFormGenerator =
      getIt<RepresentativeAppraisalFormGeneratorInterface>();
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Stores:--------------------------------------------------------------------
  late final FillAppraisalStoreInterface _store =
      getIt<FillAppraisalStoreInterface>(
          param1: FillAppraisalStoreParams(
              representativeAppraisal: widget.arguments.representativeAppraisal,
              editingRepresentative: widget.arguments.editingRepresentative));

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Navigator:-----------------------------------------------------------------
  final AppraisalsNavigatorInterface _navigator =
      getIt<AppraisalsNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _objectiveController.text =
        _store.representativeAppraisal.objective?.toString() ?? '';
    _bookedMeetingCountController.text =
        _store.representativeAppraisal.bookedMeetingCount?.toString() ?? '';
    _processedMeetingCountController.text =
        _store.representativeAppraisal.processedMeetingCount?.toString() ?? '';
    _meetingAloneCountController.text =
        _store.representativeAppraisal.meetingAloneCount?.toString() ?? '';
    _meetingAccompaniedCountController.text =
        _store.representativeAppraisal.meetingAccompaniedCount?.toString() ??
            '';
    _tapMeetingCountController.text =
        _store.representativeAppraisal.tapMeetingCount?.toString() ?? '';
    _phoneMeetingCountController.text =
        _store.representativeAppraisal.phoneMeetingCount?.toString() ?? '';
    _gmsMeetingCountController.text =
        _store.representativeAppraisal.gmsMeetingCount?.toString() ?? '';
    _improvementPlanController.text =
        _store.representativeAppraisal.improvementPlan ?? '';
    if (_store.editingRepresentative.isDirector == false) {
      _store.submitStream.listen((event) {
        _navigator.key.currentState!.pop();
      });
    }
    tabKeys = FillAppraisalScreenTab.values.fold({}, (previousValue, element) {
      previousValue.addAll({
        element: {
          'key': GlobalKey(),
          'isVisible': false,
        }
      });
      return previousValue;
    });
    tabQuestionKeys = FillAppraisalScreenTabQuestion.values.fold({},
        (previousValue, element) {
      if (element != FillAppraisalScreenTabQuestion.opportunityRequestQuality) {
        previousValue.addAll({
          element: {
            'key': GlobalKey(),
            'isVisible': false,
          }
        });
      }
      return previousValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return getIt<MainLayoutWidgetInterface>(
          param1: MainLayoutProps(
            padding: const EdgeInsets.only(top: 17, left: 0, right: 0),
            headerPadding: const EdgeInsets.symmetric(horizontal: 35),
            headerWithBackButton: true,
            backgroundColor: CupertinoColors.extraLightBackgroundGray,
            headerTitle: widget.arguments.isOwnAppraisal == false
                ? _store.representativeAppraisal.representative!.fullName
                : 'appraisal.edit.own_appraisal'.tr(),
            child: _buildContent(context),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final availableWidth =
        (MediaQuery.of(context).size.width - SidebarWidgetInterface.width);
    return StreamBuilder<Representative?>(
      stream: _representativeService.getCurrentAsStream(),
      builder: (_, AsyncSnapshot<Representative?> snapshot) {
        if (snapshot.hasData == false) {
          return const SizedBox();
        }
        Representative representative = snapshot.data!;
        return Expanded(
          child: Column(
            children: [
              Observer(
                builder: (_) => getIt<NavigationBannerWidgetInterface>(
                  param1: NavigationBannerProps(
                    height: 60,
                    availableWidth: availableWidth,
                    progressBarPercentage: _store.percentage,
                    children: representative.isDirector == false
                        ? _buildAppraisalNavigationSteps()
                        : _buildAppraisalDirectorNavigationSteps(),
                  ),
                ),
              ),
              Observer(builder: (_) {
                return _store.activeDirectorStep ==
                        FillAppraisalDirectorStep.validation
                    ? _buildValidation(representative)
                    : Expanded(
                        child: Row(
                          children: [
                            _buildSidebar(representative),
                            Container(
                              width: 1,
                              margin:
                                  const EdgeInsets.only(top: 25, bottom: 25),
                              color: CupertinoColors.opaqueSeparator,
                            ),
                            _store.activeTab ==
                                    FillAppraisalScreenTab.objectives
                                ? _buildObjectivesContent(representative)
                                : _buildTabContent(representative),
                          ],
                        ),
                      );
              }),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildAppraisalNavigationSteps() {
    return [
      _buildStep(FillAppraisalScreenTab.objectives),
      _buildStep(
        FillAppraisalScreenTab.survey,
        flex: 3,
      ),
      _buildStep(
        FillAppraisalScreenTab.negociation,
        flex: 3,
      ),
      _buildStep(
        FillAppraisalScreenTab.opportunityRequestQuality,
        label: 'appraisal.edit.tab.opportunity_request_quality_short'.tr(),
      ),
      _buildStep(
        FillAppraisalScreenTab.lifeAtWork,
        flex: 3,
      ),
    ];
  }

  Widget _buildStep(FillAppraisalScreenTab tab, {int? flex, String? label}) {
    final bool isActive = _store.activeTab.index == tab.index;
    final bool isDone = _store.currentTab.index > tab.index;
    final bool isCurrent = _store.currentTab.index == tab.index;

    return getIt<NavigationBannerItemWidgetInterface>(
      param1: NavigationBannerItemProps(
        index: tab.index,
        label: label ?? tab.label,
        flex: flex ?? 2,
        numberBgColor: isActive || isDone
            ? _appThemeData.cartBannerTextColor
            : (isCurrent ? CupertinoColors.activeOrange : null),
        numberBorderColor: isActive || isDone
            ? _appThemeData.cartBannerTextColor
            : (isCurrent
                ? CupertinoColors.activeOrange
                : CupertinoColors.white),
        numberTextColor: !isDone && !isActive
            ? _appThemeData.cartBannerTextColor
            : _appThemeData.cartBannerColor,
        labelTextColor:
            isDone ? _appThemeData.cartBannerTextColor : CupertinoColors.white,
        labelFontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        checked: !isActive && isDone,
        availableWidth:
            (MediaQuery.of(context).size.width - SidebarWidgetInterface.width),
        progressBarPercentage: _store.percentage,
        onPressed: tab.index <= _store.currentTab.index &&
                _store.activeTab != tab
            ? () {
                _store.submit();
                if (tab == FillAppraisalScreenTab.objectives) {
                  _store.setActiveTab(tab);
                  scrollToTab(_store.activeTab);
                } else {
                  _store.setActiveTabQuestion(tab,
                      _store.completedTabsQuestions[tab]!.entries.first.key);
                  if (_store.activeTabQuestion != null &&
                      tabQuestionKeys[_store.activeTabQuestion!] != null) {
                    scrollToTabQuestion(_store.activeTabQuestion!);
                  } else {
                    scrollToTab(_store.activeTab);
                  }
                }
              }
            : null,
      ),
    );
  }

  List<Widget> _buildAppraisalDirectorNavigationSteps() {
    return [
      _buildDirectorStep(FillAppraisalDirectorStep.appraisal),
      _buildDirectorStep(FillAppraisalDirectorStep.validation),
    ];
  }

  Widget _buildDirectorStep(FillAppraisalDirectorStep step,
      {int? flex, String? label}) {
    final bool isActive = _store.activeDirectorStep.index == step.index;
    final bool isDone = _store.currentDirectorStep.index > step.index;
    final bool isCurrent = _store.currentDirectorStep.index == step.index;

    return getIt<NavigationBannerItemWidgetInterface>(
      param1: NavigationBannerItemProps(
        index: step.index,
        label: label ?? step.label,
        flex: flex ?? 2,
        numberBgColor: isActive || isDone
            ? _appThemeData.cartBannerTextColor
            : (isCurrent ? CupertinoColors.activeOrange : null),
        numberBorderColor: isActive || isDone
            ? _appThemeData.cartBannerTextColor
            : (isCurrent
                ? CupertinoColors.activeOrange
                : CupertinoColors.white),
        numberTextColor: !isDone && !isActive
            ? _appThemeData.cartBannerTextColor
            : _appThemeData.cartBannerColor,
        labelTextColor:
            isDone ? _appThemeData.cartBannerTextColor : CupertinoColors.white,
        labelFontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        checked: !isActive && isDone,
        availableWidth:
            (MediaQuery.of(context).size.width - SidebarWidgetInterface.width),
        progressBarPercentage: _store.percentage,
        onPressed: step.index <= _store.currentDirectorStep.index &&
                _store.activeDirectorStep != step
            ? () {
                _store.submit();
                _store.setActiveDirectorStep(step);
              }
            : null,
      ),
    );
  }

  Widget _buildSidebar(Representative representative) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                key: scrollKey,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    ...FillAppraisalScreenTab.values.map((tab) {
                      return Observer(builder: (_) {
                        final isCompleted = _store.completedTabs[tab] ?? false;

                        List<FillAppraisalScreenTabQuestion> questionsByTab =
                            FillAppraisalScreenTab.questionsByTab[tab] ?? [];

                        // check if the tab is a question
                        bool isQuestion = false;
                        if (questionsByTab.length == 1 &&
                            questionsByTab.first.name == tab.name) {
                          isQuestion = true;
                        }

                        if (questionsByTab.isNotEmpty && isQuestion == false) {
                          return Column(
                            children: [
                              tab.index > 0
                                  ? const SizedBox(height: 15)
                                  : const SizedBox(),
                              _buildTab(tab,
                                  isCompleted: isCompleted, clickable: false),
                              const SizedBox(height: 15),
                              ...questionsByTab.map((question) {
                                return _buildTabQuestion(tab, question,
                                    isCompleted: isCompleted);
                              }),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            tab.index > 0
                                ? const SizedBox(height: 15)
                                : const SizedBox(),
                            _buildTab(tab, isCompleted: isCompleted),
                          ],
                        );
                      });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObjectivesContent(Representative representative) {
    return Observer(
      builder: (context) {
        return Expanded(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'appraisal.edit.tab.objectives.general'
                                    .tr()
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                                ],
                                label: 'appraisal.edit.tab.objectives.objective'
                                    .tr(),
                                textAlign: TextAlign.right,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                controller: _objectiveController,
                                withDebounce: true,
                                debounceKey: 'objective',
                                onChanged: _store.setObjective,
                                suffix: Text(
                                  '€',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: representative.isDirector == true
                                        ? CupertinoColors.systemGrey
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            getIt<SeparatorWidgetInterface>(),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                label:
                                    'appraisal.edit.tab.objectives.booked_meeting_count'
                                        .tr(),
                                textAlign: TextAlign.right,
                                controller: _bookedMeetingCountController,
                                withDebounce: true,
                                debounceKey: 'bookedMeetingCount',
                                onChanged: _store.setBookedMeetingCount,
                              ),
                            ),
                            getIt<SeparatorWidgetInterface>(),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                label:
                                    'appraisal.edit.tab.objectives.processed_meeting_booked_count'
                                        .tr(),
                                textAlign: TextAlign.right,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                controller: _processedMeetingCountController,
                                withDebounce: true,
                                debounceKey: 'processedMeetingCount',
                                onChanged: _store.setProcessedMeetingCount,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '"${'appraisal.edit.tab.objectives.if_yes'.tr().toUpperCase()}"',
                                style: const TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                label:
                                    'appraisal.edit.tab.objectives.alone'.tr(),
                                textAlign: TextAlign.right,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                controller: _meetingAloneCountController,
                                withDebounce: true,
                                debounceKey: 'meetingAloneCount',
                                onChanged: _store.setMeetingAloneCount,
                              ),
                            ),
                            getIt<SeparatorWidgetInterface>(),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                label:
                                    'appraisal.edit.tab.objectives.accompanied'
                                        .tr(),
                                textAlign: TextAlign.right,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                controller: _meetingAccompaniedCountController,
                                withDebounce: true,
                                debounceKey: 'meetingAccompaniedCount',
                                onChanged: _store.setMeetingAccompaniedCount,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'appraisal.edit.tab.objectives.meeting_origin'
                                    .tr()
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                label: 'appraisal.edit.tab.objectives.tap'.tr(),
                                textAlign: TextAlign.right,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                controller: _tapMeetingCountController,
                                withDebounce: true,
                                debounceKey: 'tapMeetingCount',
                                onChanged: _store.setTapMeetingCount,
                              ),
                            ),
                            getIt<SeparatorWidgetInterface>(),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                label:
                                    'appraisal.edit.tab.objectives.phone'.tr(),
                                textAlign: TextAlign.right,
                                controller: _phoneMeetingCountController,
                                withDebounce: true,
                                debounceKey: 'phoneMeetingCount',
                                onChanged: _store.setPhoneMeetingCount,
                              ),
                            ),
                            getIt<SeparatorWidgetInterface>(),
                            getIt<TextInputWidgetInterface>(
                              param1: TextInputProps(
                                disable: representative.isDirector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                label: 'appraisal.edit.tab.objectives.gms'.tr(),
                                textAlign: TextAlign.right,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                controller: _gmsMeetingCountController,
                                withDebounce: true,
                                debounceKey: 'gmsMeetingCount',
                                onChanged: _store.setGmsMeetingCount,
                              ),
                            ),
                            const SizedBox(height: 30),
                            _buildPreviousAndNextButtons(representative),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabContent(Representative representative) {
    // question responses list
    List<Map<String, dynamic>> questionResponses = [
      {
        'response': RepresentativeAppraisalQuestionResponse.NOT_MET,
        'icon': MapleCommonAssets.appraisalNotMet,
        'iconActive': MapleCommonAssets.appraisalNotMetActive,
      },
      {
        'response': RepresentativeAppraisalQuestionResponse.IN_PROGRESS,
        'icon': MapleCommonAssets.appraisalInProgress,
        'iconActive': MapleCommonAssets.appraisalInProgressActive,
      },
      {
        'response': RepresentativeAppraisalQuestionResponse.ACHIEVED,
        'icon': MapleCommonAssets.appraisalAchieved,
        'iconActive': MapleCommonAssets.appraisalAchievedActive,
      },
      {
        'response': RepresentativeAppraisalQuestionResponse.PROFICIENT,
        'icon': MapleCommonAssets.appraisalProficient,
        'iconActive': MapleCommonAssets.appraisalProficientActive,
      },
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CupertinoColors.white,
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _store.activeTab.label.toUpperCase(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 126, 145, 171),
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AutoSizeText(
                      _store.activeTabQuestion?.label ?? '',
                      minFontSize: 25,
                      style: TextStyle(
                        color: _appThemeData.defaultTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 60),
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: questionResponses.length,
                        itemBuilder: (context, index) {
                          return _buildAppraisalQuestionResponseCard(
                              questionResponses[index]);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: _buildPreviousAndNextButtons(representative),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousAndNextButtons(Representative representative) {
    late Widget child;
    if (_store.activeTab.index == 0) {
      child = Row(children: [
        const Spacer(
          flex: 3,
        ),
        Expanded(
          flex: 7,
          child: _buildNextButton(),
        ),
        const Spacer(
          flex: 3,
        ),
      ]);
    } else if (_store.activeTab.index ==
            FillAppraisalScreenTab.values.length - 1 &&
        _store.activeTabQuestion ==
            FillAppraisalScreenTabQuestion.values.last) {
      child = Row(children: [
        Expanded(
          flex: 10,
          child: _buildPreviousButton(),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: _buildNextButton(
            label: 'submit'.tr(),
            onPressed: representative.isDirector == true
                ? () => _store.nextDirectorStep()
                : () {
                    _store.submit();
                    // redirect to previous page
                    _navigator.key.currentState!.pop();
                  },
          ),
        ),
      ]);
    } else {
      child = Row(children: [
        Expanded(
          flex: 10,
          child: _buildPreviousButton(),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: _buildNextButton(),
        ),
      ]);
    }
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }

  Widget _buildPreviousButton() {
    return CupertinoButton(
      onPressed: () {
        _store.previous();
        if (_store.activeTabQuestion != null &&
            tabQuestionKeys[_store.activeTabQuestion!] != null) {
          scrollToTabQuestion(_store.activeTabQuestion!);
        } else {
          scrollToTab(_store.activeTab);
        }
      },
      padding: const EdgeInsets.all(0),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: _appThemeData.appraisalPreviousButtonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AutoSizeText(
              'previous'.tr(),
              minFontSize: 18,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
    );
  }

  Widget _buildNextButton({String? label, void Function()? onPressed}) {
    return CupertinoButton(
      onPressed: _store.canChangeTab == true
          ? onPressed ??
              () {
                _store.next();
                if (_store.activeTabQuestion != null &&
                    tabQuestionKeys[_store.activeTabQuestion!] != null) {
                  scrollToTabQuestion(_store.activeTabQuestion!);
                } else {
                  scrollToTab(_store.activeTab);
                }
              }
          : null,
      padding: const EdgeInsets.all(0),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: _store.canChangeTab == true
                ? _appThemeData.appraisalNextButtonColor
                : CupertinoColors.inactiveGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AutoSizeText(
              label ?? 'next'.tr(),
              minFontSize: 18,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
    );
  }

  Widget _buildAppraisalQuestionResponseCard(Map<String, dynamic> response) {
    return Observer(
      builder: (_) => CupertinoButton(
        onPressed: () {
          _store.setResponseByQuestion(response['response']);
        },
        padding: const EdgeInsets.all(0),
        child: _store.responseByQuestion == response['response']
            ? SvgPicture.asset(response['iconActive'])
            : SvgPicture.asset(response['icon']),
      ),
    );
  }

  Widget _buildTab(FillAppraisalScreenTab tab,
      {bool isCompleted = false, bool clickable = true}) {
    bool isReady = _store.currentTab.index >= tab.index;
    return VisibilityDetector(
      key: tabKeys[tab]!['key'],
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: isReady == false ||
                clickable == false ||
                _store.activeTab == tab
            ? null
            : () {
                _store.submit();
                if (tab == FillAppraisalScreenTab.objectives) {
                  _store.setActiveTab(tab);
                } else {
                  _store.setActiveTabQuestion(tab,
                      _store.completedTabsQuestions[tab]!.entries.first.key);
                }
              },
        color: isReady == true && clickable == true && _store.activeTab == tab
            ? _appThemeData.appraisalActiveTabColor
            : null,
        child: Container(
          decoration: BoxDecoration(
            color:
                isReady == true && clickable == true && _store.activeTab == tab
                    ? _appThemeData.appraisalActiveTabColor
                    : null,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(left: 8, top: 13, bottom: 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  tab.label,
                  style: TextStyle(
                    color: isReady == true
                        ? (clickable == true && _store.activeTab == tab
                            ? CupertinoColors.white
                            : _appThemeData.defaultTextColor)
                        : CupertinoColors.inactiveGray,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onVisibilityChanged: (info) {
        // check if widget is mounted
        if (mounted == true) {
          setState(() {
            tabKeys[tab]!['isVisible'] = info.visibleFraction > 0.8;
          });
        }
      },
    );
  }

  Widget _buildTabQuestion(
      FillAppraisalScreenTab tab, FillAppraisalScreenTabQuestion tabQuestion,
      {bool isCompleted = false}) {
    bool isReady = _store.currentTab.index >= tab.index &&
        _store.currentTabQuestion != null &&
        _store.currentTabQuestion!.index >= tabQuestion.index;
    return VisibilityDetector(
      key: tabQuestionKeys[tabQuestion]!['key'],
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: isReady == false || _store.activeTabQuestion == tabQuestion
            ? null
            : () {
                _store.submit();
                _store.setActiveTabQuestion(tab, tabQuestion);
              },
        child: Container(
          decoration: BoxDecoration(
            color: isReady == true && _store.activeTabQuestion == tabQuestion
                ? _appThemeData.appraisalActiveTabColor
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(left: 8, top: 13, bottom: 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  tabQuestion.label,
                  style: TextStyle(
                    color: isReady == true
                        ? (_store.activeTabQuestion == tabQuestion
                            ? CupertinoColors.white
                            : _appThemeData.defaultTextColor)
                        : CupertinoColors.inactiveGray,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onVisibilityChanged: (info) {
        // check if widget is mounted
        if (mounted == true) {
          setState(() {
            tabQuestionKeys[tabQuestion]!['isVisible'] =
                info.visibleFraction > 0.8;
          });
        }
      },
    );
  }

  Widget _buildValidation(Representative representative) {
    return Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Column(
                      children: [
                        _store.representativeAppraisal.completingDirector !=
                                null
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 350,
                                    child: AutoSizeText(
                                      _store.representativeAppraisal
                                          .completingDirector!.fullName,
                                      minFontSize: 18,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    _store.representativeAppraisal
                                                .completedByDirectorAt !=
                                            null
                                        ? CupertinoIcons
                                            .check_mark_circled_solid
                                        : CupertinoIcons.clear_circled_solid,
                                    color: _store.representativeAppraisal
                                                .completedByDirectorAt !=
                                            null
                                        ? CupertinoColors.activeGreen
                                        : CupertinoColors.destructiveRed,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        _store.representativeAppraisal.completingDirector !=
                                null
                            ? const SizedBox(
                                height: 5,
                              )
                            : const SizedBox(),
                        Row(
                          children: [
                            SizedBox(
                              width: 350,
                              child: AutoSizeText(
                                _store.representativeAppraisal.representative!
                                    .fullName,
                                minFontSize: 18,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              _store.representativeAppraisal
                                          .completedByRepresentativeAt !=
                                      null
                                  ? CupertinoIcons.check_mark_circled_solid
                                  : CupertinoIcons.clear_circled_solid,
                              color: _store.representativeAppraisal
                                          .completedByRepresentativeAt !=
                                      null
                                  ? CupertinoColors.activeGreen
                                  : CupertinoColors.destructiveRed,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    CupertinoButton(
                      color: _appThemeData.buttonColor,
                      onPressed: _onViewPressed,
                      child: AutoSizeText(
                        'appraisal.edit.director.visualize'.tr(),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                AutoSizeText(
                  'appraisal.edit.director.improvement_plan'.tr(),
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                CupertinoTextField(
                  controller: _improvementPlanController,
                  maxLines: 6,
                  readOnly: _store.representativeAppraisal
                          .completedByRepresentativeAt ==
                      null,
                  onChanged: _store.setImprovementPlan,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Observer(builder: (_) {
                    return CupertinoButton(
                      color: _appThemeData.buttonColor,
                      onPressed: representative.isDirector == true &&
                              _store.representativeAppraisal
                                      .completedByDirectorAt !=
                                  null &&
                              _store.representativeAppraisal
                                      .completedByRepresentativeAt !=
                                  null
                          ? _showGenerateConfirmationDialog
                          : null,
                      child: AutoSizeText(
                        'appraisal.edit.generate.title'.tr(),
                      ),
                    );
                  }),
                ),
              ],
            )),
        const Spacer(flex: 1),
      ],
    );
  }

  // General methods:-----------------------------------------------------------
  void scrollToTab(FillAppraisalScreenTab tab) {
    GlobalKey currentKey = tabKeys[tab]!['key'];
    if (currentKey.currentContext == null ||
        tabKeys[tab]!['isVisible'] == true) {
      return;
    }
    Scrollable.ensureVisible(
      currentKey.currentContext!,
      alignment: 0.5,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToTabQuestion(FillAppraisalScreenTabQuestion tabQuestion) {
    GlobalKey currentKey = tabQuestionKeys[tabQuestion]!['key'];
    if (currentKey.currentContext == null ||
        tabQuestionKeys[tabQuestion]!['isVisible'] == true) {
      return;
    }
    Scrollable.ensureVisible(
      currentKey.currentContext!,
      alignment: 0.5,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _showGenerateConfirmationDialog() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('appraisal.edit.generate.confirmation.title'.tr()),
          content: Text('appraisal.edit.generate.confirmation.content'.tr()),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                _onGeneratePressed();
                Navigator.of(context).pop();
              },
              child: Text('ok'.tr()),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'.tr()),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onViewPressed() async {
    await _store.submit();
    return _generateAppraisalForm(false);
  }

  Future<void> _onGeneratePressed() async {
    await _store.submit();
    if (_store.representativeAppraisal.representativeAppraisalFormFileDataId !=
        null) {
      // delete the file
      await _store.representativeAppraisal
          .loadRepresentativeAppraisalFormFileData();
      FileData? fileData =
          _store.representativeAppraisal.representativeAppraisalFormFileData;
      if (fileData == null) {
        String fileDataId = _uuidUtils.generate();
        await _generateAppraisalForm(
          true,
          fileDataId: fileDataId,
        );
        // attach fileData to representativeAppraisal
        await _store.setRepresentativeAppraisalFormFileDataId(fileDataId);
      } else {
        // set fileDataId to null
        await _store.setRepresentativeAppraisalFormFileDataId(null);
        // delete old file
        String fileDataId = _uuidUtils.generate();
        await _fileDataService.removeFromFileSystem(fileData.uniqueName);
        // generate new file
        await _generateAppraisalForm(true, fileDataId: fileDataId);
        // attach fileData to representativeAppraisal
        await _store.setRepresentativeAppraisalFormFileDataId(fileDataId);
      }
    } else {
      String fileDataId = _uuidUtils.generate();
      await _generateAppraisalForm(
        true,
        fileDataId: fileDataId,
      );
      // attach fileData to representativeAppraisal
      await _store.setRepresentativeAppraisalFormFileDataId(fileDataId);
    }
    // redirect to previous page
    _navigator.key.currentState!.pop();
  }

  Future<void> _generateAppraisalForm(bool withSave,
      {String? fileDataId}) async {
    _loaderUtils.startLoading(context);
    try {
      await _representativeAppraisalFormGenerator.generate(
        representativeAppraisal: _store.representativeAppraisal,
        openFile: true,
        withSave: withSave,
        fileDataId: fileDataId,
      );
      if (!mounted) return;
      await _loaderUtils.stopLoading(context);
    } catch (e) {
      if (!mounted) return;
      await _loaderUtils.stopLoading(context);
      rethrow;
    }
  }

  // Dispose methods:--------------------------------------------------------------------
  @override
  void dispose() {
    _objectiveController.dispose();
    _bookedMeetingCountController.dispose();
    _processedMeetingCountController.dispose();
    _meetingAloneCountController.dispose();
    _meetingAccompaniedCountController.dispose();
    _tapMeetingCountController.dispose();
    _phoneMeetingCountController.dispose();
    _gmsMeetingCountController.dispose();
    _improvementPlanController.dispose();
    _scrollController.dispose();
    _store.dispose();
    super.dispose();
  }
}
