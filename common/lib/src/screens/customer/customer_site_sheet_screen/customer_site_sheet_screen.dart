import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerSiteSheetScreenInterface implements Widget {
  CustomerSiteSheetScreenArguments get arguments;
}

// Enums:-----------------------------------------------------------------------
enum CustomerSiteSheetScreenTab {
  statementOfInformation,
  roof,
  cover,
  exposure,
  gutters,
  fasciaBoard,
  facade,
  woodTreatment,
  insulation,
  connection,
  comments;

  String get label => 'site_sheet.sidebar.items.$name'.tr();
}

// Implementation:--------------------------------------------------------------
class CustomerSiteSheetScreen extends StatefulWidget
    implements CustomerSiteSheetScreenInterface {
  const CustomerSiteSheetScreen({super.key, required this.arguments});

  @override
  final CustomerSiteSheetScreenArguments arguments;

  @override
  State<CustomerSiteSheetScreen> createState() =>
      _CustomerSiteSheetScreenState();
}

class _CustomerSiteSheetScreenState extends State<CustomerSiteSheetScreen> {
  // Dependencies:--------------------------------------------------------------
  final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();
  late final SiteSheetGeneratorInterface _siteSheetGenerator =
      getIt<SiteSheetGeneratorInterface>();

  // Stores:--------------------------------------------------------------------
  late final CustomerSiteSheetStoreInterface _store =
      getIt<CustomerSiteSheetStoreInterface>(
    param1: CustomerSiteSheetStoreParams(
      orderId: widget.arguments.orderId,
    ),
  );

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_store.siteSheet == null) {
      init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        disabledHeader: true,
        backgroundColor: MapleCommonColors.greyLightest,
        padding: const EdgeInsets.only(top: 17, left: 35),
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: getIt<HeaderWidgetInterface>(
                  param1: HeaderProps(
                    title: 'site_sheet.title'.tr(),
                    withBackButton: true,
                    rightChild: Row(
                      children: [
                        Observer(builder: (context) {
                          if (_store.siteSheet == null) {
                            return const SizedBox();
                          }
                          return CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            onPressed: _onViewPressed,
                            child: Icon(
                              CupertinoIcons.eye_fill,
                              color: _appThemeData.buttonColor,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 36),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSidebar(),
                      _buildSeparator(),
                      _buildContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildSidebar() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'site_sheet.sidebar.title'.tr(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ...CustomerSiteSheetScreenTab.values.map((tab) {
              return Observer(builder: (_) {
                final isCompleted = _store.completedTabs[tab] ?? false;

                return CupertinoButton(
                  padding: const EdgeInsets.only(left: 8),
                  onPressed: _store.currentTab == tab
                      ? null
                      : () => _store.setCurrentTab(tab),
                  color: _store.currentTab == tab
                      ? MapleCommonColors.greyBackground
                      : null,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.check_mark_circled,
                        color: !isCompleted
                            ? MapleCommonColors.transparent
                            : _appThemeData.activeMenuColor,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        tab.label,
                        style: TextStyle(
                          color: _appThemeData.defaultTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              });
            }),
            const Spacer(),
            Center(
              child: Observer(builder: (_) {
                return CupertinoButton(
                  color: _appThemeData.buttonColor,
                  onPressed: _store.isCompleted ? _onGeneratePressed : null,
                  child: AutoSizeText('site_sheet.generate'.tr(), maxLines: 1),
                );
              }),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: 1,
      margin: const EdgeInsets.only(bottom: 50),
      color: CupertinoColors.opaqueSeparator,
    );
  }

  Widget _buildContent() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CupertinoScrollbar(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 16, right: 35),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Observer(builder: (BuildContext context) {
              if (_store.siteSheet == null) {
                return const SizedBox();
              }

              switch (_store.currentTab) {
                case CustomerSiteSheetScreenTab.statementOfInformation:
                  return getIt<StatementOfInformationTabWidgetInterface>(
                    param1: StatementOfInformationTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.roof:
                  return getIt<RoofTabWidgetInterface>(
                    param1: RoofTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.cover:
                  return getIt<CoverTabWidgetInterface>(
                    param1: CoverTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.exposure:
                  return getIt<ExposureTabWidgetInterface>(
                    param1: ExposureTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.gutters:
                  return getIt<GutterTabWidgetInterface>(
                    param1: GutterTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.fasciaBoard:
                  return getIt<FasciaBoardTabWidgetInterface>(
                    param1: FasciaBoardTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.facade:
                  return getIt<FacadeTabWidgetInterface>(
                    param1: FacadeTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.woodTreatment:
                  return getIt<WoodTreatmentTabWidgetInterface>(
                    param1: WoodTreatmentTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.insulation:
                  return getIt<InsulationTabWidgetInterface>(
                    param1: InsulationTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.connection:
                  return getIt<ConnectionTabWidgetInterface>(
                    param1: ConnectionTabProps(
                      store: _store,
                    ),
                  );
                case CustomerSiteSheetScreenTab.comments:
                  return getIt<CommentsTabWidgetInterface>(
                    param1: CommentsTabProps(
                      store: _store,
                    ),
                  );
                default:
                  return const SizedBox();
              }
            }),
          ),
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  Future<void> init() async {
    _loaderUtils.startLoading(context);
    await _store.init();
    if (!mounted) return;
    await _loaderUtils.stopLoading(context);
  }

  Future<void> _onViewPressed() {
    return _generateSiteSheet(false);
  }

  Future<void> _onGeneratePressed() {
    return _generateSiteSheet(true);
  }

  Future<void> _generateSiteSheet(bool withSave) async {
    _loaderUtils.startLoading(context);
    try {
      await _siteSheetGenerator.generate(
        siteSheet: _store.siteSheet!,
        withSave: withSave,
        drawing: _store.drawing,
      );
      if (!mounted) return;
      await _loaderUtils.stopLoading(context);
    } catch (e) {
      if (!mounted) return;
      await _loaderUtils.stopLoading(context);
      rethrow;
    }
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }
}
