import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class WoodTreatmentTabWidgetInterface implements Widget {
  WoodTreatmentTabProps get props;
}

// Props:-----------------------------------------------------------------------
class WoodTreatmentTabProps {
  const WoodTreatmentTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class WoodTreatmentTab extends StatefulWidget
    implements WoodTreatmentTabWidgetInterface {
  const WoodTreatmentTab({super.key, required this.props});

  @override
  final WoodTreatmentTabProps props;

  @override
  State<WoodTreatmentTab> createState() => _WoodTreatmentTabState();
}

class _WoodTreatmentTabState extends State<WoodTreatmentTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _woodTreatmentAreaController =
      TextEditingController();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _woodTreatmentAreaController.text =
        widget.props.store.siteSheet?.woodTreatmentArea ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.wood_treatment.wood_treatment_type'.tr(),
            value: widget.props.store.siteSheet!.woodTreatmentType,
            displayedValue:
                widget.props.store.siteSheet!.woodTreatmentType?.label,
            choices: WoodTreatmentType.choices,
            nullable: true,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            onChanged: (dynamic value) =>
                widget.props.store.setWoodTreatmentType(
              value as WoodTreatmentType?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.wood_treatment.wood_treatment_area'.tr(),
            textAlign: TextAlign.right,
            controller: _woodTreatmentAreaController,
            withDebounce: true,
            debounceKey: 'woodTreatmentArea',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setWoodTreatmentArea,
          ),
        ),
      ],
    );
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _woodTreatmentAreaController.dispose();
    super.dispose();
  }
}
