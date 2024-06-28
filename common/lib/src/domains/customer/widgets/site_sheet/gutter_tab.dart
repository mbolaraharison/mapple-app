import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class GutterTabWidgetInterface implements Widget {
  GutterTabProps get props;
}

// Props:-----------------------------------------------------------------------
class GutterTabProps {
  const GutterTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class GutterTab extends StatefulWidget implements GutterTabWidgetInterface {
  const GutterTab({super.key, required this.props});

  @override
  final GutterTabProps props;

  @override
  State<GutterTab> createState() => _GutterTabState();
}

class _GutterTabState extends State<GutterTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _otherMaterialController =
      TextEditingController();
  final TextEditingController _lengthInLinearMetersController =
      TextEditingController();
  final TextEditingController _downspoutLengthController =
      TextEditingController();
  final TextEditingController _guttersColorController = TextEditingController();
  final TextEditingController _downspoutsColorController =
      TextEditingController();
  final TextEditingController _leftAngleQuantityController =
      TextEditingController();
  final TextEditingController _rightAngleQuantityController =
      TextEditingController();
  final TextEditingController _numberOfGutterBottomsController =
      TextEditingController();
  final TextEditingController _numberOfGutterBirthsController =
      TextEditingController();
  final TextEditingController _numberOfGutterBendsController =
      TextEditingController();
  final TextEditingController _numberOfGutterSleevesOrDolphinController =
      TextEditingController();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _otherMaterialController.text =
        widget.props.store.siteSheet?.otherMaterial ?? '';
    _lengthInLinearMetersController.text =
        widget.props.store.siteSheet?.lengthInLinearMeters ?? '';
    _downspoutLengthController.text =
        widget.props.store.siteSheet?.downspoutLength ?? '';
    _guttersColorController.text =
        widget.props.store.siteSheet?.guttersColor ?? '';
    _downspoutsColorController.text =
        widget.props.store.siteSheet?.downspoutsColor ?? '';
    _leftAngleQuantityController.text =
        widget.props.store.siteSheet?.leftAngleQuantity ?? '';
    _rightAngleQuantityController.text =
        widget.props.store.siteSheet?.rightAngleQuantity ?? '';
    _numberOfGutterBottomsController.text =
        widget.props.store.siteSheet?.numberOfGutterBottoms ?? '';
    _numberOfGutterBirthsController.text =
        widget.props.store.siteSheet?.numberOfGutterBirths ?? '';
    _numberOfGutterBendsController.text =
        widget.props.store.siteSheet?.numberOfGutterBends ?? '';
    _numberOfGutterSleevesOrDolphinController.text =
        widget.props.store.siteSheet?.numberOfGutterSleevesOrDolphin ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getIt<MultiSelectDialogWidgetInterface>(
          param1: MultiSelectDialogProps(
            label: 'site_sheet.content.gutters.gutter_types'.tr(),
            values: widget.props.store.siteSheet!.gutterTypes
                .map((e) => e.name)
                .toList(),
            displayedValue: widget.props.store.siteSheet!.gutterTypesString,
            choices: GutterType.choices,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setGutterTypes,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.other_material'.tr(),
            textAlign: TextAlign.right,
            controller: _otherMaterialController,
            withDebounce: true,
            debounceKey: 'otherMaterial',
            onChanged: widget.props.store.setOtherMaterial,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.length_in_linear_meters'.tr(),
            textAlign: TextAlign.right,
            controller: _lengthInLinearMetersController,
            withDebounce: true,
            debounceKey: 'lengthInLinearMeters',
            onChanged: widget.props.store.setLengthInLinearMeters,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.downspout_length'.tr(),
            textAlign: TextAlign.right,
            controller: _downspoutLengthController,
            withDebounce: true,
            debounceKey: 'downspoutLength',
            onChanged: widget.props.store.setDownspoutLength,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.gutters_color'.tr(),
            textAlign: TextAlign.right,
            controller: _guttersColorController,
            withDebounce: true,
            debounceKey: 'guttersColor',
            onChanged: widget.props.store.setGuttersColor,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.downspouts_color'.tr(),
            textAlign: TextAlign.right,
            controller: _downspoutsColorController,
            withDebounce: true,
            debounceKey: 'downspoutsColor',
            onChanged: widget.props.store.setDownspoutsColor,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.gutters.downspout_type'.tr(),
            value: widget.props.store.siteSheet!.downspoutType,
            displayedValue: widget.props.store.siteSheet!.downspoutType?.label,
            choices: DownspoutType.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setDownspoutType(
              value as DownspoutType?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.left_angle_quantity'.tr(),
            textAlign: TextAlign.right,
            controller: _leftAngleQuantityController,
            withDebounce: true,
            debounceKey: 'leftAngleQuantity',
            onChanged: widget.props.store.setLeftAngleQuantity,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.right_angle_quantity'.tr(),
            textAlign: TextAlign.right,
            controller: _rightAngleQuantityController,
            withDebounce: true,
            debounceKey: 'rightAngleQuantity',
            onChanged: widget.props.store.setRightAngleQuantity,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.number_of_gutter_bottoms'.tr(),
            textAlign: TextAlign.right,
            controller: _numberOfGutterBottomsController,
            withDebounce: true,
            debounceKey: 'numberOfGutterBottoms',
            onChanged: widget.props.store.setNumberOfGutterBottoms,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.number_of_gutter_births'.tr(),
            textAlign: TextAlign.right,
            controller: _numberOfGutterBirthsController,
            withDebounce: true,
            debounceKey: 'numberOfGutterBirths',
            onChanged: widget.props.store.setNumberOfGutterBirths,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.gutters.number_of_gutter_bends'.tr(),
            textAlign: TextAlign.right,
            controller: _numberOfGutterBendsController,
            withDebounce: true,
            debounceKey: 'numberOfGutterBends',
            onChanged: widget.props.store.setNumberOfGutterBends,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label:
                'site_sheet.content.gutters.number_of_gutter_sleeves_or_dolphin'
                    .tr(),
            textAlign: TextAlign.right,
            controller: _numberOfGutterSleevesOrDolphinController,
            withDebounce: true,
            debounceKey: 'numberOfGutterSleevesOrDolphin',
            onChanged: widget.props.store.setNumberOfGutterSleevesOrDolphin,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.gutters.with_water_recuperator'.tr(),
            value: widget.props.store.siteSheet!.withWaterRecuperator,
            displayedValue:
                widget.props.store.siteSheet!.withWaterRecuperator == null
                    ? null
                    : widget.props.store.siteSheet!.withWaterRecuperator!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setWithWaterRecuperator(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.gutters.with_leaf_guard'.tr(),
            value: widget.props.store.siteSheet!.withLeafGuard,
            displayedValue: widget.props.store.siteSheet!.withLeafGuard == null
                ? null
                : widget.props.store.siteSheet!.withLeafGuard!
                    ? 'yes'.tr()
                    : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: (dynamic value) => widget.props.store.setWithLeafGuard(
              value as bool?,
            ),
          ),
        ),
      ],
    );
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _otherMaterialController.dispose();
    _lengthInLinearMetersController.dispose();
    _downspoutLengthController.dispose();
    _guttersColorController.dispose();
    _downspoutsColorController.dispose();
    _leftAngleQuantityController.dispose();
    _rightAngleQuantityController.dispose();
    _numberOfGutterBottomsController.dispose();
    _numberOfGutterBirthsController.dispose();
    _numberOfGutterBendsController.dispose();
    _numberOfGutterSleevesOrDolphinController.dispose();
    super.dispose();
  }
}
