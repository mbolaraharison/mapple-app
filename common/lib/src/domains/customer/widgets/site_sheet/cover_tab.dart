import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CoverTabWidgetInterface implements Widget {
  CoverTabProps get props;
}

// Props:-----------------------------------------------------------------------
class CoverTabProps {
  const CoverTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class CoverTab extends StatefulWidget implements CoverTabWidgetInterface {
  const CoverTab({super.key, required this.props});

  @override
  final CoverTabProps props;

  @override
  State<CoverTab> createState() => _CoverTabState();
}

class _CoverTabState extends State<CoverTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _modelsAndDimensionsController =
      TextEditingController();
  final TextEditingController _numberOfSlatesOrTilesInAdvanceController =
      TextEditingController();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _modelsAndDimensionsController.text =
        widget.props.store.siteSheet?.modelsAndDimensions ?? '';
    _numberOfSlatesOrTilesInAdvanceController.text =
        widget.props.store.siteSheet?.numberOfSlatesOrTilesInAdvance ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getIt<TextInputWidgetInterface>(
            param1: TextInputProps(
              label: 'site_sheet.content.cover.models_and_dimensions'.tr(),
              textAlign: TextAlign.right,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              controller: _modelsAndDimensionsController,
              withDebounce: true,
              debounceKey: 'modelsAndDimensions',
              onChanged: widget.props.store.setModelsAndDimensions,
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<MultiSelectDialogWidgetInterface>(
            param1: MultiSelectDialogProps(
              label: 'site_sheet.content.cover.types'.tr(),
              values: widget.props.store.siteSheet!.coverTypes
                  .map((e) => e.name)
                  .toList(),
              displayedValue: widget.props.store.siteSheet!.coverTypesString,
              choices: CoverType.choices,
              borderRadius: BorderRadius.zero,
              onChanged: widget.props.store.setCoverTypes,
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<TextInputWidgetInterface>(
            param1: TextInputProps(
              label:
                  'site_sheet.content.cover.number_of_slates_or_tiles_in_advance'
                      .tr(),
              textAlign: TextAlign.right,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              controller: _numberOfSlatesOrTilesInAdvanceController,
              withDebounce: true,
              debounceKey: 'numberOfSlatesOrTilesInAdvance',
              onChanged: widget.props.store.setNumberOfSlatesOrTilesInAdvance,
            ),
          ),
        ],
      ),
    );
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _modelsAndDimensionsController.dispose();
    _numberOfSlatesOrTilesInAdvanceController.dispose();
    super.dispose();
  }
}
