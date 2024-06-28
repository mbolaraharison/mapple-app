import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DirectorAppraisalAgencyScreenInterface implements Widget {
  DirectorAppraisalAgencyScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class DirectorAppraisalAgencyScreen extends StatefulWidget
    implements DirectorAppraisalAgencyScreenInterface {
  // Constructor:---------------------------------------------------------------
  const DirectorAppraisalAgencyScreen({super.key, required this.arguments});

  // Arguments:-----------------------------------------------------------------
  @override
  final DirectorAppraisalAgencyScreenArguments arguments;

  @override
  State<DirectorAppraisalAgencyScreen> createState() =>
      _DirectorAppraisalAgencyScreenState();
}

class _DirectorAppraisalAgencyScreenState
    extends State<DirectorAppraisalAgencyScreen> {
  // Stores:--------------------------------------------------------------------
  late final DirectorAppraisalAgencyStoreInterface _store =
      getIt<DirectorAppraisalAgencyStoreInterface>(
    param1: DirectorAppraisalAgencyStoreParams(
      agency: widget.arguments.agency,
    ),
  );

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Services:------------------------------------------------------------------
  final EmailServiceInterface _emailService = getIt<EmailServiceInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Dependencies:--------------------------------------------------------------
  final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Navigator:-----------------------------------------------------------------
  late final AppraisalsNavigatorInterface _navigator =
      getIt<AppraisalsNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
        param1: MainLayoutProps(
      backgroundColor: MapleCommonColors.greyLightest,
      disabledHeader: true,
      padding: EdgeInsets.zero,
      child: _buildContent(context),
    ));
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildContent(BuildContext context) {
    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 336),
          child: Image.asset(
            MapleCommonAssets.bgRepresentativeAppraisals,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Column(
            children: [
              const SizedBox(height: 17),
              getIt<HeaderWidgetInterface>(
                param1: HeaderProps(
                  title: widget.arguments.agency.city,
                  mode: HeaderMode.light,
                  withBackButton: true,
                ),
              ),
              IntrinsicHeight(
                  child: Row(
                children: [
                  Column(children: [
                    const SizedBox(height: 35),
                    _buildMenu(),
                  ]),
                  const SizedBox(width: 36),
                  const VerticalDivider(
                    color: MapleCommonColors.greyMidLight,
                    thickness: 1,
                    width: 1,
                  ),
                  _buildRightContent(),
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return Observer(builder: (context) {
      return Column(
        children: [
          _buildMenuButton(1, MapleCommonAssets.recall,
              'appraisal.appraisals_for_representative',
              count: _store.appraisalsForRepresentatives.length),
          const SizedBox(height: 18),
          _buildMenuButton(2, MapleCommonAssets.progressChart,
              'appraisal.appraisals_for_director',
              count: _store.appraisalsForDirector.length),
          const SizedBox(height: 18),
          _buildMenuButton(
              3, MapleCommonAssets.users, 'appraisal.representatives',
              count: _store.representatives.length),
          const SizedBox(height: 18),
          _buildMenuButton(4, MapleCommonAssets.users,
              'appraisal.representatives_without_appraisal',
              count: _store.representativesWithoutAppraisal.length),
          const SizedBox(height: 18),
          _buildMenuButton(5, MapleCommonAssets.history,
              'appraisal.history.appraisals_history'),
        ],
      );
    });
  }

  Widget _buildMenuButton(int id, String icon, String title, {int? count}) {
    return CupertinoButton(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 14, bottom: 16),
      onPressed: () {
        _store.setSelectedTabIndex(id);
      },
      color: CupertinoColors.white,
      child: SizedBox(
          width: 236,
          height: 64,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _store.selectTabIndex == id
                            ? _appThemeData.buttonColor
                            : MapleCommonColors.greyLighter,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            icon,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (count != null)
                      Text(
                        count.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _store.selectTabIndex == id
                              ? _appThemeData.defaultTextColor
                              : MapleCommonColors.greyLighter,
                        ),
                      )
                  ],
                ),
                Text(
                  title.tr(),
                  style: TextStyle(
                    fontSize: 17,
                    color: _store.selectTabIndex == id
                        ? _appThemeData.defaultTextColor
                        : MapleCommonColors.greyLighter,
                  ),
                )
              ])),
    );
  }

  Widget _buildRightContent() {
    return StreamBuilder<Representative?>(
        stream: _representativeService
            .getFirstByEmailByAgencyIdByRolesFromFirestoreAsStream(
                widget.arguments.email,
                widget.arguments.agency.id,
                [Role.agencyDirector, Role.regionalDirector]),
        builder: (_, AsyncSnapshot<Representative?> snapshot) {
          if (snapshot.hasData == false) {
            return const SizedBox();
          }
          Representative director = snapshot.data!;
          return Observer(builder: (_) {
            switch (_store.selectTabIndex) {
              case 1:
                return _buildAppraisalListForRepresentatives(director);
              case 2:
                return _buildAppraisalListForDirector(director);
              case 3:
                return _buildRepresentativeList(director);
              case 4:
                return _buildRepresentativeWithoutAppraisalList(director);
              case 5:
                return _buildHistory(director);
              default:
                return _buildAppraisalListForRepresentatives(director);
            }
          });
        });
  }

  Widget _buildAppraisalListForRepresentatives(Representative director) {
    return getIt<DirectorAppraisalsListViewWidgetInterface>(
      param1: DirectorAppraisalsListViewProps(
        store: _store,
        appraisals: _store.appraisalsForRepresentatives,
        editingRepresentative: director,
        header: _buildAppraisalsListViewHeader(
            'appraisal.appraisals_for_representative', true),
        showLimitDateColumn: true,
        onPressed: (appraisal, context) {
          _navigator.key.currentState!.pushNamed(
            _navigator.fillAppraisalRoute,
            arguments: FillAppraisalScreenArguments(
              representativeAppraisal: appraisal,
              editingRepresentative: director,
              isOwnAppraisal: false,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppraisalListForDirector(Representative director) {
    return getIt<DirectorAppraisalsListViewWidgetInterface>(
        param1: DirectorAppraisalsListViewProps(
            store: _store,
            appraisals: _store.appraisalsForDirector,
            editingRepresentative: director,
            header: _buildAppraisalsListViewHeader(
                'appraisal.appraisals_for_director', false),
            showLimitDateColumn: true,
            onPressed: (appraisal, context) {
              _navigator.key.currentState!.pushNamed(
                _navigator.fillAppraisalRoute,
                arguments: FillAppraisalScreenArguments(
                  representativeAppraisal: appraisal,
                  editingRepresentative: director,
                  isOwnAppraisal: false,
                ),
              );
            }));
  }

  Widget _buildHistory(Representative director) {
    return getIt<DirectorAppraisalsHistoryViewWidgetInterface>(
        param1: DirectorAppraisalsHistoryViewProps(
      store: _store,
      editingRepresentative: director,
    ));
  }

  Widget _buildRepresentativeList(Representative director) {
    return getIt<RepresentativesListViewWidgetInterface>(
        param1: RepresentativesListViewProps(
      representatives: _store.representatives,
      editingRepresentative: director,
      title: 'appraisal.representatives',
    ));
  }

  Widget _buildRepresentativeWithoutAppraisalList(Representative director) {
    return getIt<RepresentativesListViewWidgetInterface>(
        param1: RepresentativesListViewProps(
      representatives: _store.representativesWithoutAppraisal,
      editingRepresentative: director,
      title: 'appraisal.representatives_without_appraisal',
    ));
  }

  Widget _buildAppraisalsListViewHeader(String title, bool showSelectButton) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr(),
              style: TextStyle(
                  color: _appThemeData.defaultTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          const Spacer(),
          if (showSelectButton == true) ..._actionButtons()
        ],
      ),
    );
  }

  List<Widget> _actionButtons() {
    List<Widget> buttons = [];
    if (_store.isMultiSelection) {
      buttons.add(CupertinoButton(
        onPressed: () => _showConfirmDialog(),
        child: Text(
          'appraisal.list.recall_action'.tr(),
          style: TextStyle(
            color: _appThemeData.buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    buttons.add(CupertinoButton(
      onPressed: () => setState(() {
        _store.toggleMultiSelection();
      }),
      child: Text(
        _store.isMultiSelection ? 'cancel'.tr() : 'appraisal.list.select'.tr(),
        style: TextStyle(
          color: _appThemeData.buttonColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));

    return buttons;
  }

  // General methods:-----------------------------------------------------------
  Future<void> init() async {
    _loaderUtils.startLoading(context);
    await _store.init();
    if (!mounted) return;
    await _loaderUtils.stopLoading(context);
  }

  Future<void> _showConfirmDialog() async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('appraisal.list.recall_modal.title'.tr()),
          content: Text('appraisal.list.recall_modal.content'.tr()),
          actions: [
            CupertinoDialogAction(
                child: Text(
                  'appraisal.list.recall_modal.send'.tr(),
                  style: TextStyle(
                    color: _appThemeData.buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  await _emailService.sendRepresentativeAppraisalRecall(
                      _store.selectedAppraisals);
                  setState(() {
                    _store.toggleMultiSelection();
                    _showRecallNotification();
                    if (!mounted) return;
                    Navigator.pop(context);
                  });
                }),
            CupertinoDialogAction(
              child: Text('cancel'.tr(),
                  style: TextStyle(
                    color: _appThemeData.buttonColor,
                  )),
              onPressed: () => setState(() {
                Navigator.pop(context);
              }),
            ),
          ],
        );
      },
    );
  }

  // Other methods:-------------------------------------------------------------
  void _showRecallNotification() {
    Fluttertoast.showToast(
      msg: 'appraisal.list.recall_modal.notification'.tr(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: CupertinoColors.activeGreen,
      textColor: CupertinoColors.white,
      fontSize: 16.0,
    );
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }
}
