import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

// Interface:-------------------------------------------------------------------
abstract class DirectorAppraisalsHistoryViewWidgetInterface implements Widget {
  DirectorAppraisalsHistoryViewProps get props;
}

// Props:-----------------------------------------------------------------------
class DirectorAppraisalsHistoryViewProps {
  DirectorAppraisalAgencyStoreInterface store;
  Representative editingRepresentative;

  DirectorAppraisalsHistoryViewProps({
    required this.store,
    required this.editingRepresentative,
  });
}

// Implementation:--------------------------------------------------------------
class DirectorAppraisalsHistoryView extends StatelessWidget
    implements DirectorAppraisalsHistoryViewWidgetInterface {
  DirectorAppraisalsHistoryView({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final DirectorAppraisalsHistoryViewProps props;

  // Services:------------------------------------------------------------------
  final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 24),
            color: MapleCommonColors.greyLightest,
            child: Column(children: [
              Observer(builder: (context) {
                return props.store.selectedYear == null
                    ? _buildYearsList(context)
                    : _buildAppraisalsList(context);
              })
            ])));
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildAppraisalsList(BuildContext context) {
    var selectedYearAppraisals =
        props.store.appraisalsHistoryByYear[props.store.selectedYear];
    return getIt<DirectorAppraisalsListViewWidgetInterface>(
        param1: DirectorAppraisalsListViewProps(
      store: props.store,
      appraisals: ObservableList<RepresentativeAppraisal>.of(
          selectedYearAppraisals as Iterable<RepresentativeAppraisal>),
      editingRepresentative: props.editingRepresentative,
      header: _buildHistoryListHeader(),
      showColumnHeader: false,
      paddingVertical: 0,
      paddingHorizontal: 0,
      onPressed: (appraisal, context) {
        _onViewCompletedAppraisalForm(appraisal, context);
      },
    ));
  }

  Widget _buildHistoryListHeader() {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: CupertinoButton(
                    child: Row(children: [
                      const Icon(
                        CupertinoIcons.chevron_left,
                        color: MapleCommonColors.red,
                      ),
                      Text('back'.tr(),
                          style: TextStyle(
                              color: _appThemeData.buttonColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 17))
                    ]),
                    onPressed: () {
                      props.store.setSelectedYear(null);
                    })),
            Expanded(
                child: Text(
                    'appraisal.history.year'.tr(namedArgs: {
                      'year': props.store.selectedYear.toString(),
                    }),
                    style: TextStyle(
                        color: _appThemeData.defaultTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22))),
            const SizedBox(width: 150)
          ],
        ));
  }

  Widget _buildYearsList(BuildContext context) {
    final yearButtons = props.store.appraisalsHistoryByYear.keys.map((int y) {
      return _buildYearButton(y);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Text('appraisal.history.appraisals_history'.tr(),
              style: TextStyle(
                  color: _appThemeData.defaultTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
        ),
        const SizedBox(height: 24),
        SizedBox(
            height: MediaQuery.of(context).size.height - 240,
            child: CupertinoScrollbar(
                child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: yearButtons),
            )))
      ],
    );
  }

  Widget _buildYearButton(int year) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: CupertinoButton(
            color: CupertinoColors.white,
            child: SizedBox(
              width: 344,
              height: 30,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'appraisal.history.year'.tr(namedArgs: {
                          'year': year.toString(),
                        }),
                        style: TextStyle(
                            color: _appThemeData.defaultTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                    const Icon(
                      CupertinoIcons.chevron_right,
                      color: MapleCommonColors.greyLight,
                    ),
                  ]),
            ),
            onPressed: () {
              props.store.setSelectedYear(year);
            }));
  }

  Future<void> _onViewCompletedAppraisalForm(
      RepresentativeAppraisal appraisal, BuildContext context) async {
    _loaderUtils.startLoading(context);
    await appraisal.loadRepresentativeAppraisalFormFileData();
    if (appraisal.representativeAppraisalFormFileData == null) {
      if (!context.mounted) return;
      await _loaderUtils.stopLoading(context);
      return;
    }
    await _fileDataService.openFromFileSystemByUniqueName(
      appraisal.representativeAppraisalFormFileData!.uniqueName,
      download: true,
      withRemove: true,
    );
    if (!context.mounted) return;
    await _loaderUtils.stopLoading(context);
  }
}
