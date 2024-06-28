import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RepresentativeAppraisalRecallDialogWidgetInterface
    implements Widget {
  RepresentativeAppraisalRecallDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class RepresentativeAppraisalRecallDialogProps {
  const RepresentativeAppraisalRecallDialogProps({
    required this.representative,
  });

  final Representative representative;
}

// Implementation:--------------------------------------------------------------
class RepresentativeAppraisalRecallDialog extends StatelessWidget
    implements RepresentativeAppraisalRecallDialogWidgetInterface {
  RepresentativeAppraisalRecallDialog({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final RepresentativeAppraisalRecallDialogProps props;

  // Stores:--------------------------------------------------------------------
  final RepresentativeAppraisalRecallDialogStoreInterface _store =
      getIt<RepresentativeAppraisalRecallDialogStoreInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 500,
        height: 500,
        header: _buildHeader(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Row(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'back'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: Text(
          'appraisal.list.recall_modal.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(builder: (_) {
          return CupertinoButton(
            child: Text(
              'appraisal.list.recall_modal.send'.tr(),
              style: _store.selectedAppraisals.isNotEmpty
                  ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                      .copyWith(fontWeight: FontWeight.w600)
                  : const TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
            ),
            onPressed: () => _store.selectedAppraisals.isNotEmpty
                ? {
                    _store.sendRecalls(),
                    _showRecallNotification(),
                    Navigator.pop(context)
                  }
                : null,
          );
        }),
      ),
    );
  }

  Widget _buildContent() {
    return FutureBuilder<List<RepresentativeAppraisal>>(
        future: _store.getNotCompletedByRepresentativeByRepresentativeId(
            props.representative),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          List<RepresentativeAppraisal> appraisals = snapshot.data;

          return SizedBox(
              height: 430,
              child: ListView.builder(
                itemCount: appraisals.length,
                itemBuilder: (context, index) {
                  return _buildRow(appraisals[index]);
                },
              ));
        });
  }

  Widget _buildRow(RepresentativeAppraisal appraisal) {
    return CupertinoButton(
      onPressed: () => _store.selectAppraisal(appraisal),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(right: 0),
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Center(child: Observer(builder: (context) {
                return Icon(
                  _store.selectedAppraisals.contains(appraisal)
                      ? CupertinoIcons.check_mark_circled_solid
                      : CupertinoIcons.circle,
                  color: MapleCommonColors.red,
                  size: 20,
                );
              })),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  appraisal.type.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _appThemeData.defaultTextColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(appraisal.limitDate),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _appThemeData.defaultTextColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
}
