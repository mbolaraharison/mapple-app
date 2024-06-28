import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class RepresentativeAppraisalsScreenInterface implements Widget {
  RepresentativeAppraisalsScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class RepresentativeAppraisalsScreen extends StatefulWidget
    implements RepresentativeAppraisalsScreenInterface {
  // Constructor:---------------------------------------------------------------
  const RepresentativeAppraisalsScreen({super.key, required this.arguments});

  // Properties:----------------------------------------------------------------
  @override
  final RepresentativeAppraisalsScreenArguments arguments;

  @override
  State<RepresentativeAppraisalsScreen> createState() =>
      _RepresentativeAppraisalsScreenState();
}

class _RepresentativeAppraisalsScreenState
    extends State<RepresentativeAppraisalsScreen> {
  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final RepresentativeAppraisalServiceInterface
      _representativeAppraisalService =
      getIt<RepresentativeAppraisalServiceInterface>();
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Navigator:-----------------------------------------------------------------
  final AppraisalsNavigatorInterface _navigator =
      getIt<AppraisalsNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _representativeService
          .getByIdFromFirestoreAsStream(widget.arguments.representative.id),
      builder: (_, AsyncSnapshot<Representative?> snapshot) {
        if (!snapshot.hasData) {
          return const CupertinoActivityIndicator();
        }
        Representative representative = snapshot.data!;
        return getIt<MainLayoutWidgetInterface>(
          param1: MainLayoutProps(
            padding: const EdgeInsets.only(top: 17, left: 0, right: 0),
            headerPadding: const EdgeInsets.symmetric(horizontal: 35),
            headerWithBackButton: widget.arguments.representative.id !=
                widget.arguments.editingRepresentative.id,
            backgroundColor: CupertinoColors.extraLightBackgroundGray,
            headerTitle: representative.fullName,
            headerRightChild: _buildHeaderRightChild(representative),
            child: _buildContent(representative),
          ),
        );
      },
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildHeaderRightChild(Representative representative) {
    return Row(
        children: widget.arguments.representative.id !=
                widget.arguments.editingRepresentative.id
            ? [
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () => _onPressAdjustment(context, representative),
                  child: SvgPicture.asset(
                    MapleCommonAssets.adjustment,
                    colorFilter: ColorFilter.mode(
                      _appThemeData.topBarButtonColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () => _onPressRecall(context, representative),
                  child: SvgPicture.asset(
                    MapleCommonAssets.recall,
                    colorFilter: ColorFilter.mode(
                      _appThemeData.topBarButtonColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () => _onPressAdd(context, representative),
                  child: SvgPicture.asset(
                    MapleCommonAssets.plus,
                    colorFilter: ColorFilter.mode(
                      _appThemeData.topBarButtonColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ]
            : [
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () => _onPressShowWelcomeBooklet(),
                  child: Icon(
                    CupertinoIcons.arrow_down_doc_fill,
                    color: _appThemeData.buttonColor,
                    size: 26,
                  ),
                )
              ]);
  }

  Widget _buildContent(Representative representative) {
    return Expanded(
      child: Container(
        color: CupertinoColors.white,
        width: double.infinity,
        child: Row(children: [
          Expanded(
            flex: 7,
            child: Container(
              color: CupertinoColors.extraLightBackgroundGray,
              height: double.infinity,
              child: StreamBuilder(
                stream:
                    _getByRepresentativeAndByEditingRepProfileFromFirestoreAsStream(
                        representative,
                        isEditingRepresentativeDirector:
                            widget.arguments.editingRepresentative.isDirector),
                builder: (_,
                    AsyncSnapshot<Map<String, List<RepresentativeAppraisal>>>
                        snapshot) {
                  Map<String, List<RepresentativeAppraisal>>? appraisals =
                      snapshot.data;
                  Map<String, List<RepresentativeAppraisal>>?
                      defaultAppraisals = {
                    'completed': [],
                    'toBeCompleted': [],
                  };
                  return Column(
                    children: [
                      _buildBackgroundAndDates(
                          representative, appraisals ?? defaultAppraisals),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildAppraisalLists(
                                  appraisals ?? defaultAppraisals),
                              _buildBadges(representative),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: _buildHistory(representative),
          )
        ]),
      ),
    );
  }

  Widget _buildBackgroundAndDates(Representative representative,
      Map<String, List<RepresentativeAppraisal>> appraisals) {
    RepresentativeAppraisal? nextAppraisal = appraisals['completed']!.isNotEmpty
        ? appraisals['completed']!.first
        : appraisals['toBeCompleted']!.isNotEmpty
            ? appraisals['toBeCompleted']!.first
            : null;
    return Stack(
      children: [
        SizedBox(
          height: 185,
          child: Image.asset(
            MapleCommonAssets.bgRepresentativeAppraisal,
            width: double.infinity,
            fit: BoxFit.cover,
            color: const Color.fromARGB(255, 62, 136, 255).withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Container(
          height: 185,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      representative.startDate != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  AutoSizeText(
                                    'appraisal.arrival_date'.tr(),
                                    maxFontSize: 18,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  AutoSizeText(
                                    representative.startDate != null
                                        ? DateFormat('dd MMMM yyyy')
                                            .format(representative.startDate!)
                                        : '',
                                    minFontSize: 18,
                                    style: const TextStyle(
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ])
                          : const SizedBox(
                              height: 46,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      nextAppraisal != null
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'appraisal.next_appraisal_date.title'.tr(),
                                  maxFontSize: 18,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                AutoSizeText(
                                  RepresentativeAppraisalType
                                          .representativeAppraisalNames[
                                      nextAppraisal.type]!,
                                  minFontSize: 18,
                                  style: const TextStyle(
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const VerticalDivider(
                  indent: 32,
                  endIndent: 32,
                  color: Colors.white,
                  thickness: 1,
                ),
                Expanded(
                  child: nextAppraisal != null
                      ? Row(
                          children: [
                            const Spacer(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'appraisal.next_appraisal_date.limit_date'
                                      .tr(),
                                  maxFontSize: 18,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                AutoSizeText(
                                  DateFormat('dd MMMM yyyy')
                                      .format(nextAppraisal.limitDate),
                                  minFontSize: 18,
                                  style: const TextStyle(
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                nextAppraisal.completingDirector != null
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: AutoSizeText(
                                              nextAppraisal
                                                  .completingDirector!.fullName,
                                              minFontSize: 18,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            nextAppraisal
                                                        .completedByDirectorAt !=
                                                    null
                                                ? CupertinoIcons
                                                    .check_mark_circled_solid
                                                : CupertinoIcons
                                                    .clear_circled_solid,
                                            color: nextAppraisal
                                                        .completedByDirectorAt !=
                                                    null
                                                ? CupertinoColors.activeGreen
                                                : CupertinoColors
                                                    .destructiveRed,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                nextAppraisal.completingDirector != null
                                    ? const SizedBox(
                                        height: 5,
                                      )
                                    : const SizedBox(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: AutoSizeText(
                                        representative.fullName,
                                        minFontSize: 18,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      nextAppraisal
                                                  .completedByRepresentativeAt !=
                                              null
                                          ? CupertinoIcons
                                              .check_mark_circled_solid
                                          : CupertinoIcons.clear_circled_solid,
                                      color: nextAppraisal
                                                  .completedByRepresentativeAt !=
                                              null
                                          ? CupertinoColors.activeGreen
                                          : CupertinoColors.destructiveRed,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppraisalLists(
      Map<String, List<RepresentativeAppraisal>> appraisals) {
    if (appraisals['completed']!.isEmpty &&
        appraisals['toBeCompleted']!.isEmpty) {
      return Expanded(
        child: Center(
          heightFactor: 3,
          child: AutoSizeText(
            'appraisal.no_appraisal_found'.tr(),
            maxFontSize: 15,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: CupertinoColors.inactiveGray,
            ),
          ),
        ),
      );
    }
    List<Widget> children = [];
    if (appraisals['completed']!.isNotEmpty) {
      children = _buildRepresentativeAppraisalsList(
          'appraisal.completed_appraisal'.tr(), appraisals['completed']!);
      children.add(const SizedBox(
        height: 10,
      ));
    }
    if (appraisals['toBeCompleted']!.isNotEmpty) {
      children = [
        ...children,
        ..._buildRepresentativeAppraisalsList(
            'appraisal.to_be_completed_appraisal'.tr(),
            appraisals['toBeCompleted']!),
      ];
    }
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRepresentativeAppraisalsList(
      String title, List<RepresentativeAppraisal> appraisals) {
    List<Widget> children = appraisals.map((appraisal) {
      return Column(
        children: [
          getIt<RowButtonWidgetInterface>(
            param1: RowButtonProps(
              child: AutoSizeText(
                RepresentativeAppraisalType
                    .representativeAppraisalNames[appraisal.type]!,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              margin: const EdgeInsets.only(bottom: 14),
              width: double.infinity,
              onPressed: () {
                _onPressAppraisal(appraisal);
              },
            ),
          ),
        ],
      );
    }).toList();
    return [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: AutoSizeText(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 18,
      ),
      ...children
    ];
  }

  Widget _buildBadges(Representative representative) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'appraisal.badges'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      onPressed: () => _onPressOpenBadgesFile(),
                      child: const Icon(
                        CupertinoIcons.info_circle,
                        color: CupertinoColors.destructiveRed,
                        size: 26,
                      ),
                    ),
                  ],
                ),
                representative.firstBaseBadges.isEmpty &&
                        representative.secondBaseBadges.isEmpty
                    ? Center(
                        child: AutoSizeText(
                          'appraisal.no_badge_set'.tr(),
                          maxFontSize: 15,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                      )
                    : const SizedBox(),
                // Common
                _buildBase('appraisal.common'.tr(), representative.commonBadges,
                    height: 60),
                // First base
                _buildBase('appraisal.first_base'.tr(),
                    representative.firstBaseBadges),
                // Second base
                _buildBase('appraisal.second_base'.tr(),
                    representative.secondBaseBadges),
                // Third base
                _buildBase('appraisal.third_base'.tr(),
                    representative.thirdBaseBadges),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBase(String title, List<Map<String, dynamic>> baseBadges,
      {double? width, double? height}) {
    if (baseBadges.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          title,
          maxFontSize: 15,
          style: const TextStyle(
            color: CupertinoColors.inactiveGray,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
            return CustomScrollView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (constraints.maxWidth / 95).floor(),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Map<String, dynamic> badge = baseBadges[index];
                      return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _onPressShowBadgeDescription(badge,
                              width: width, height: height),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                badge['icon']!,
                                width: width,
                                height: height,
                                colorFilter: badge['isActive'] == false
                                    ? const ColorFilter.mode(
                                        Color.fromARGB(193, 153, 153, 153),
                                        BlendMode.srcATop,
                                      )
                                    : null,
                              ),
                            ],
                          ));
                    },
                    childCount: baseBadges.length,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildHistory(Representative representative) {
    return Container(
      height: double.infinity,
      color: CupertinoColors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'appraisal.history.title'.tr(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: StreamBuilder(
                  stream: _representativeAppraisalService
                      .getAllFullyCompletedAsStream(representative.id),
                  builder: (_,
                      AsyncSnapshot<List<RepresentativeAppraisal>> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    List<RepresentativeAppraisal> appraisals = snapshot.data!;
                    if (appraisals.isEmpty) {
                      return Center(
                        child: AutoSizeText(
                          'appraisal.no_history'.tr(),
                          maxFontSize: 15,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                      );
                    }
                    List<int> years =
                        appraisals.map((e) => e.limitYear).toSet().toList();
                    List<Widget> yearItems = [];
                    for (int i = 0; i < years.length; i++) {
                      int year = years[i];
                      List<Widget> appraisalItems = [];
                      List<RepresentativeAppraisal> appraisalsPerYear =
                          appraisals
                              .where((appraisal) => appraisal.limitYear == year)
                              .toList();
                      for (int j = 0; j < appraisalsPerYear.length; j++) {
                        RepresentativeAppraisal appraisal =
                            appraisalsPerYear[j];
                        appraisalItems.add(
                          GestureDetector(
                            onTap: () {
                              _onViewCompletedAppraisalForm(appraisal);
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.doc,
                                  color: CupertinoColors.destructiveRed,
                                  size: 26,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    RepresentativeAppraisalType
                                            .representativeAppraisalNames[
                                        appraisal.type]!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        if (j != appraisalsPerYear.length - 1) {
                          appraisalItems.add(const SizedBox(
                            height: 18,
                          ));
                        }
                      }
                      yearItems.add(
                        getIt<DropDownMenuWidgetInterface>(
                          param1: DropDownMenuProps(
                            label: '$year',
                            child: Column(
                              children: appraisalItems,
                            ),
                          ),
                        ),
                      );
                      if (i != years.length - 1) {
                        yearItems.add(const SizedBox(
                          height: 10,
                        ));
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: yearItems,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  Stream<Map<String, List<RepresentativeAppraisal>>>
      _getByRepresentativeAndByEditingRepProfileFromFirestoreAsStream(
          Representative representative,
          {bool isEditingRepresentativeDirector = false}) {
    return _representativeAppraisalService
        .getByRepresentativeIdAsStream(representative.id, eager: true)
        .map((List<RepresentativeAppraisal> appraisals) {
      List<RepresentativeAppraisal> completed = [];
      List<RepresentativeAppraisal> toBeCompleted = [];
      if (isEditingRepresentativeDirector == true) {
        completed = appraisals
            .where((appraisal) =>
                appraisal.completedByDirectorAt != null &&
                (appraisal.completedByRepresentativeAt == null ||
                    appraisal.representativeAppraisalFormFileDataId == null))
            .toList();
        toBeCompleted = appraisals
            .where((appraisal) => appraisal.completedByDirectorAt == null)
            .toList();
      } else {
        completed = appraisals
            .where((appraisal) =>
                appraisal.completedByRepresentativeAt != null &&
                (appraisal.completedByDirectorAt == null ||
                    appraisal.representativeAppraisalFormFileDataId == null))
            .toList();
        toBeCompleted = appraisals
            .where((appraisal) => appraisal.completedByRepresentativeAt == null)
            .toList();
      }

      completed.sort((a, b) => a.limitDate.compareTo(b.limitDate));
      toBeCompleted.sort((a, b) => a.limitDate.compareTo(b.limitDate));
      return {
        'completed': completed,
        'toBeCompleted': toBeCompleted,
      };
    });
  }

  Future<void> _onViewCompletedAppraisalForm(
      RepresentativeAppraisal appraisal) async {
    _loaderUtils.startLoading(context);
    await appraisal.loadRepresentativeAppraisalFormFileData();
    if (appraisal.representativeAppraisalFormFileData == null) {
      if (!mounted) return;
      await _loaderUtils.stopLoading(context);
      return;
    }
    await _fileDataService.openFromFileSystemByUniqueName(
      appraisal.representativeAppraisalFormFileData!.uniqueName,
      download: true,
      withRemove: true,
    );
    if (!mounted) return;
    await _loaderUtils.stopLoading(context);
  }

  void _onPressAdjustment(BuildContext context, Representative representative) {
    showCupertinoDialog(
      context: context,
      builder: (_) =>
          getIt<ConfigureRepresentativeAppraisalDialogWidgetInterface>(
        param1: representative,
      ),
    );
  }

  Future<void> _onPressAppraisal(RepresentativeAppraisal appraisal) async {
    await appraisal.loadData();
    _navigator.key.currentState!.pushNamed(
      _navigator.fillAppraisalRoute,
      arguments: FillAppraisalScreenArguments(
        representativeAppraisal: appraisal,
        editingRepresentative: widget.arguments.editingRepresentative,
        isOwnAppraisal: widget.arguments.editingRepresentative.id ==
            appraisal.representativeId,
      ),
    );
  }

  void _onPressAdd(BuildContext context, Representative representative) {
    showCupertinoDialog(
      context: context,
      builder: (_) => getIt<AddRepresentativeAppraisalDialogWidgetInterface>(
        param1: AddRepresentativeAppraisalDialogProps(
          representative: representative,
        ),
      ),
    );
  }

  void _onPressShowWelcomeBooklet() async {
    _loaderUtils.startLoading(context);
    await _fileDataService.openFromFileSystemByUniqueName(
      'welcome_booklet.pdf',
      download: true,
      withRemove: true,
    );
    if (!mounted) return;
    await _loaderUtils.stopLoading(context);
  }

  void _onPressRecall(BuildContext context, Representative representative) {
    showCupertinoDialog(
      context: context,
      builder: (_) => getIt<RepresentativeAppraisalRecallDialogWidgetInterface>(
        param1: RepresentativeAppraisalRecallDialogProps(
          representative: representative,
        ),
      ),
    );
  }

  void _onPressShowBadgeDescription(Map<String, dynamic> badge,
      {double? width, double? height}) async {
    showCupertinoDialog(
      context: context,
      builder: (_) => getIt<BadgeDialogWidgetInterface>(
        param1: BadgeDialogProps(
          icon: badge['icon'],
          description: badge['description'],
          width: width,
          height: height,
        ),
      ),
    );
  }

  void _onPressOpenBadgesFile() async {
    _loaderUtils.startLoading(context);
    await _fileDataService.openFromFileSystemByUniqueName(
      'representative_appraisal_badges_information.pdf',
      download: true,
      withRemove: true,
    );
    if (!mounted) return;
    await _loaderUtils.stopLoading(context);
  }
}
