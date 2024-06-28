import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

// Interface:-------------------------------------------------------------------
abstract class DirectorAppraisalsListViewWidgetInterface implements Widget {
  DirectorAppraisalsListViewProps get props;
}

// Props:-----------------------------------------------------------------------
class DirectorAppraisalsListViewProps {
  DirectorAppraisalAgencyStoreInterface store;
  ObservableList<RepresentativeAppraisal> appraisals;
  Representative editingRepresentative;
  Widget? header;
  bool? showColumnHeader = true;
  bool? showLimitDateColumn = true;
  double? paddingVertical;
  double? paddingHorizontal;
  void Function(RepresentativeAppraisal, BuildContext)? onPressed;

  DirectorAppraisalsListViewProps({
    required this.store,
    required this.appraisals,
    required this.editingRepresentative,
    this.header,
    this.showColumnHeader,
    this.showLimitDateColumn,
    this.paddingVertical,
    this.paddingHorizontal,
    this.onPressed,
  });
}

// Implementation:--------------------------------------------------------------
class DirectorAppraisalsListView extends StatelessWidget
    implements DirectorAppraisalsListViewWidgetInterface {
  DirectorAppraisalsListView({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final DirectorAppraisalsListViewProps props;

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
            padding: EdgeInsets.symmetric(
                vertical: props.paddingVertical ?? 36,
                horizontal: props.paddingHorizontal ?? 24),
            color: MapleCommonColors.greyLightest,
            child: Column(
              children: [
                if (props.header != null) ...[
                  props.header!,
                  const SizedBox(height: 24)
                ],
                _buildList(context)
              ],
            )));
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildList(BuildContext context) {
    return Observer(
        builder: (_) => Column(
              children: [
                if (props.showColumnHeader != false) _buildHeaders(),
                _buildRows(context),
              ],
            ));
  }

  Widget _buildHeaders() {
    return Row(
      children: [
        if (props.store.isMultiSelection == true)
          const SizedBox(
            width: 50,
          ),
        const SizedBox(
          width: 73,
        ),
        _buildHeader('appraisal.list.header.name'.tr(), flexValue: 2),
        _buildHeader('appraisal.list.header.type'.tr()),
        if (props.showLimitDateColumn == true)
          _buildHeader('appraisal.list.header.limit_date'.tr()),
      ],
    );
  }

  Widget _buildHeader(String headerName, {int flexValue = 1}) {
    return Expanded(
      flex: flexValue,
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
          itemCount: props.appraisals.length,
          itemBuilder: (context, index) {
            return _buildRow(props.appraisals[index], context);
          },
        ));
  }

  Widget _buildRow(RepresentativeAppraisal appraisal, BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        props.store.isMultiSelection == true
            ? props.store.selectAppraisal(appraisal)
            : (props.onPressed != null
                ? props.onPressed!(appraisal, context)
                : _navigator.key.currentState!.pushNamed(
                    _navigator.representativeAppraisalsRoute,
                    arguments: RepresentativeAppraisalsScreenArguments(
                      representative: appraisal.representative!,
                      editingRepresentative: props.editingRepresentative,
                    ),
                  ));
      },
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 60,
        padding:
            EdgeInsets.only(right: props.showLimitDateColumn == true ? 0 : 28),
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          children: [
            if (props.store.isMultiSelection == true)
              SizedBox(
                width: 50,
                child: Center(child: Observer(builder: (context) {
                  return Icon(
                    props.store.selectedAppraisals.contains(appraisal)
                        ? CupertinoIcons.check_mark_circled_solid
                        : CupertinoIcons.circle,
                    color: MapleCommonColors.red,
                    size: 20,
                  );
                })),
              ),
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
                      appraisal.representative?.initials ?? '',
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
            _buildCell(appraisal.representative?.fullName ?? '', flexValue: 2),
            _buildCell(appraisal.type.label,
                flexValue: props.showLimitDateColumn == true ? 1 : 0),
            if (props.showLimitDateColumn == true)
              _buildCell(DateFormat('dd/MM/yyyy').format(appraisal.limitDate)),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String cellValue, {int flexValue = 1}) {
    return Expanded(
      flex: flexValue,
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
