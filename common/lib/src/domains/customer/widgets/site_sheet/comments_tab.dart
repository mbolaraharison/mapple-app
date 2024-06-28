import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CommentsTabWidgetInterface implements Widget {
  CommentsTabProps get props;
}

// Props:-----------------------------------------------------------------------
class CommentsTabProps {
  const CommentsTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class CommentsTab extends StatefulWidget implements CommentsTabWidgetInterface {
  const CommentsTab({super.key, required this.props});

  @override
  final CommentsTabProps props;

  @override
  State<CommentsTab> createState() => _CommentsTabState();
}

class _CommentsTabState extends State<CommentsTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _periodsOfUnavailabilityController =
      TextEditingController();
  final TextEditingController _othersObservationsController =
      TextEditingController();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _periodsOfUnavailabilityController.text =
        widget.props.store.siteSheet?.periodsOfUnavailability ?? '';
    _othersObservationsController.text =
        widget.props.store.siteSheet?.othersObservations ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.other.periods_of_unavailability'.tr(),
            textAlign: TextAlign.right,
            controller: _periodsOfUnavailabilityController,
            withDebounce: true,
            debounceKey: 'periodsOfUnavailability',
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setPeriodsOfUnavailability,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.other.heating_system'.tr(),
            value: widget.props.store.siteSheet!.heatingSystem,
            displayedValue: widget.props.store.siteSheet!.heatingSystem?.label,
            choices: HeatingSystem.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setHeatingSystem(
              value as HeatingSystem?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.other.zone'.tr(),
            value: widget.props.store.siteSheet!.zone,
            displayedValue: widget.props.store.siteSheet!.zone?.label,
            choices: Zone.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setZone(
              value as Zone?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.other.others_observations'.tr(),
            textAlign: TextAlign.right,
            controller: _othersObservationsController,
            withDebounce: true,
            debounceKey: 'othersObservations',
            borderRadius: BorderRadius.zero,
            onChanged: widget.props.store.setOthersObservations,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<RowButtonWidgetInterface>(
          param1: RowButtonProps(
            value: 'site_sheet.content.other.drawing_area'.tr(),
            valueColor: _appThemeData.defaultTextColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            rightChild: widget.props.store.siteSheet?.drawingFileDataId != null
                ? const Icon(CupertinoIcons.checkmark_alt)
                : null,
            onPressed: _drawingAreaPressed,
          ),
        ),
      ],
    );
  }

  // General methods:-----------------------------------------------------------
  void _drawingAreaPressed() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<DrawingAreaDialogWidgetInterface>(
        param1: DrawingAreaDialogProps(
          store: widget.props.store,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _periodsOfUnavailabilityController.dispose();
    _othersObservationsController.dispose();
    super.dispose();
  }
}
