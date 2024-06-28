import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

// Interface:-------------------------------------------------------------------
abstract class RepresentativesListViewWidgetInterface implements Widget {
  RepresentativesListViewProps get props;
}

// Props:-----------------------------------------------------------------------
class RepresentativesListViewProps {
  ObservableList<Representative> representatives;
  Representative editingRepresentative;
  String title;

  RepresentativesListViewProps({
    required this.representatives,
    required this.editingRepresentative,
    required this.title,
  });
}

// Implementation:--------------------------------------------------------------
class RepresentativesListView extends StatelessWidget
    implements RepresentativesListViewWidgetInterface {
  RepresentativesListView({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final RepresentativesListViewProps props;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();
  final CustomersListViewThemeInterface _theme =
      getIt<CustomersListViewThemeInterface>();

  // Navigator:-----------------------------------------------------------------
  late final AppraisalsNavigatorInterface _navigator =
      getIt<AppraisalsNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            color: MapleCommonColors.greyLightest,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Text(props.title.tr(),
                          style: TextStyle(
                              color: _appThemeData.defaultTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildList(context)
              ],
            )));
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildList(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 73,
            ),
            _buildHeader('appraisal.list.header.name'.tr()),
          ],
        ),
        _buildRows(context),
      ],
    );
  }

  Widget _buildHeader(String headerName) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          headerName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: MapleCommonColors.greyLighter,
          ),
        ),
      ),
    );
  }

  Widget _buildRows(context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 244,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: props.representatives.length,
          itemBuilder: (context, index) {
            return _buildRow(props.representatives[index]);
          },
        ));
  }

  Widget _buildRow(Representative representative) {
    return CupertinoButton(
      onPressed: () {
        _navigator.key.currentState!.pushNamed(
          _navigator.representativeAppraisalsRoute,
          arguments: RepresentativeAppraisalsScreenArguments(
            representative: representative,
            editingRepresentative: props.editingRepresentative,
          ),
        );
      },
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 73,
              child: Center(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _theme.rowCircleBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      representative.initials,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildCell(representative.fullName),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String cellValue) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          cellValue,
          maxLines: 1,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _appThemeData.defaultTextColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
