import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RoofTabWidgetInterface implements Widget {
  RoofTabProps get props;
}

// Props:-----------------------------------------------------------------------
class RoofTabProps {
  const RoofTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class RoofTab extends StatefulWidget implements RoofTabWidgetInterface {
  const RoofTab({super.key, required this.props});

  @override
  final RoofTabProps props;

  @override
  State<RoofTab> createState() => _RoofTabState();
}

class _RoofTabState extends State<RoofTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _numberOfSectionsController =
      TextEditingController();
  final TextEditingController _totalRoofAreaController =
      TextEditingController();
  final TextEditingController _ageOfRoofAreaController =
      TextEditingController();
  final TextEditingController _checkingRecoveryController =
      TextEditingController();
  final TextEditingController _existingGutterController =
      TextEditingController();
  final TextEditingController _existingGuttersColorsController =
      TextEditingController();
  final TextEditingController _gableHeightController = TextEditingController();
  final TextEditingController _heightUnderGutterController =
      TextEditingController();
  final TextEditingController _numberOfChimneysController =
      TextEditingController();
  final TextEditingController _chimneysToPaintColorController =
      TextEditingController();
  final TextEditingController _numberOfDormersController =
      TextEditingController();
  final TextEditingController _numberOfVeluxController =
      TextEditingController();
  final TextEditingController _typeOfRidgeController = TextEditingController();
  final TextEditingController _waterRepellentColorController =
      TextEditingController();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _numberOfSectionsController.text =
        widget.props.store.siteSheet?.numberOfSections ?? '';
    _totalRoofAreaController.text =
        widget.props.store.siteSheet?.totalRoofArea ?? '';
    _ageOfRoofAreaController.text =
        widget.props.store.siteSheet?.ageOfRoof ?? '';
    _existingGutterController.text =
        widget.props.store.siteSheet?.existingGutter ?? '';
    _existingGuttersColorsController.text =
        widget.props.store.siteSheet?.existingGuttersColors ?? '';
    _gableHeightController.text =
        widget.props.store.siteSheet?.gableHeight ?? '';
    _heightUnderGutterController.text =
        widget.props.store.siteSheet?.heightUnderGutter ?? '';
    _numberOfChimneysController.text =
        widget.props.store.siteSheet?.numberOfChimneys ?? '';
    _chimneysToPaintColorController.text =
        widget.props.store.siteSheet?.chimneysToPaintColor ?? '';
    _numberOfDormersController.text =
        widget.props.store.siteSheet?.numberOfDormers ?? '';
    _numberOfVeluxController.text =
        widget.props.store.siteSheet?.numberOfVelux ?? '';
    _typeOfRidgeController.text =
        widget.props.store.siteSheet?.typeOfRidge ?? '';
    _waterRepellentColorController.text =
        widget.props.store.siteSheet?.waterRepellentColor ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'site_sheet.content.mandatory_fields'.tr(),
          style: const TextStyle(
            color: CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'site_sheet.content.roof.category.roof'.tr().toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        const SizedBox(height: 10),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.number_of_sections'.tr(),
            textAlign: TextAlign.right,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            controller: _numberOfSectionsController,
            withDebounce: true,
            debounceKey: 'numberOfSections',
            onChanged: widget.props.store.setNumberOfSections,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<RowButtonWidgetInterface>(
          param1: RowButtonProps(
            value: 'site_sheet.content.roof.has_return_in_l'.tr(),
            disableOnTapEffect: true,
            valueColor: _appThemeData.defaultTextColor,
            rightChild: CupertinoSwitch(
              value: widget.props.store.siteSheet!.hasReturnInL,
              activeColor: _appThemeData.activeSwitchButtonColor,
              onChanged: widget.props.store.setHasReturnInL,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.total_roof_area'.tr(),
            textAlign: TextAlign.right,
            controller: _totalRoofAreaController,
            withDebounce: true,
            debounceKey: 'totalRoofArea',
            onChanged: widget.props.store.setTotalRoofArea,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.age_of_roof'.tr(),
            textAlign: TextAlign.right,
            controller: _ageOfRoofAreaController,
            withDebounce: true,
            debounceKey: 'ageOfRoof',
            onChanged: widget.props.store.setAgeOfRoof,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.state_of_roof'.tr(),
            value: widget.props.store.siteSheet!.stateOfRoof,
            displayedValue: widget.props.store.siteSheet!.stateOfRoof?.label,
            choices: StateOfRoof.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setStateOfRoof(
              value as StateOfRoof?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.vegetation'.tr(),
            value: widget.props.store.siteSheet!.vegetation,
            displayedValue: widget.props.store.siteSheet!.vegetation?.label,
            choices: Vegetation.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setVegetation(
              value as Vegetation?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.roof_pitch'.tr(),
            value: widget.props.store.siteSheet!.roofPitch,
            displayedValue: widget.props.store.siteSheet!.roofPitch?.label,
            choices: RoofPitch.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setRoofPitch(
              value as RoofPitch?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.checking_recovery'.tr(),
            textAlign: TextAlign.right,
            controller: _checkingRecoveryController,
            withDebounce: true,
            debounceKey: 'checking_recovery',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setCheckingRecovery,
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'site_sheet.content.roof.category.gutter'.tr().toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        const SizedBox(height: 10),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.existing_gutter'.tr(),
            textAlign: TextAlign.right,
            controller: _existingGutterController,
            withDebounce: true,
            debounceKey: 'existingGutter',
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setExistingGutters,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.existing_gutters_colors'.tr(),
            textAlign: TextAlign.right,
            controller: _existingGuttersColorsController,
            withDebounce: true,
            debounceKey: 'existingGuttersColors',
            onChanged: widget.props.store.setExistingGuttersColors,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.gable_height'.tr(),
            textAlign: TextAlign.right,
            controller: _gableHeightController,
            withDebounce: true,
            debounceKey: 'gableHeight',
            onChanged: widget.props.store.setGableHeight,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.height_under_gutter'.tr(),
            textAlign: TextAlign.right,
            controller: _heightUnderGutterController,
            withDebounce: true,
            debounceKey: 'heightUnderGutter',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setHeightUnderGutter,
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'site_sheet.content.roof.category.roofing_elements'
                .tr()
                .toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        const SizedBox(height: 10),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.got_veranda'.tr(),
            value: widget.props.store.siteSheet!.gotVeranda,
            displayedValue: widget.props.store.siteSheet!.gotVeranda == null
                ? null
                : widget.props.store.siteSheet!.gotVeranda!
                    ? 'yes'.tr()
                    : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            onChanged: (dynamic value) => widget.props.store.setGotVeranda(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.got_photovoltaic'.tr(),
            value: widget.props.store.siteSheet!.gotPhotovoltaic,
            displayedValue:
                widget.props.store.siteSheet!.gotPhotovoltaic == null
                    ? null
                    : widget.props.store.siteSheet!.gotPhotovoltaic!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setGotPhotovoltaic(value as bool?),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.number_of_chimneys'.tr(),
            textAlign: TextAlign.right,
            controller: _numberOfChimneysController,
            withDebounce: true,
            debounceKey: 'numberOfChimneys',
            onChanged: widget.props.store.setNumberOfChimneys,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.need_to_paint_chimneys'.tr(),
            value: widget.props.store.siteSheet!.needToPaintChimneys,
            displayedValue:
                widget.props.store.siteSheet!.needToPaintChimneys == null
                    ? null
                    : widget.props.store.siteSheet!.needToPaintChimneys!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setNeedToPaintChimneys(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.chimneys_to_paint_color'.tr(),
            textAlign: TextAlign.right,
            controller: _chimneysToPaintColorController,
            withDebounce: true,
            debounceKey: 'chimneysToPaintColor',
            onChanged: widget.props.store.setChimneysToPaintColor,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.number_of_dormers'.tr(),
            textAlign: TextAlign.right,
            controller: _numberOfDormersController,
            withDebounce: true,
            debounceKey: 'numberOfDormers',
            onChanged: widget.props.store.setNumberOfDormers,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.number_of_velux'.tr(),
            textAlign: TextAlign.right,
            controller: _numberOfVeluxController,
            withDebounce: true,
            debounceKey: 'numberOfVelux',
            onChanged: widget.props.store.setNumberOfVelux,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.type_of_ridge'.tr(),
            textAlign: TextAlign.right,
            controller: _typeOfRidgeController,
            withDebounce: true,
            debounceKey: 'typeOfRidge',
            onChanged: widget.props.store.setTypeOfRidge,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.state_of_ridge'.tr(),
            value: widget.props.store.siteSheet!.stateOfRidge,
            displayedValue: widget.props.store.siteSheet!.stateOfRidge?.label,
            choices: StateOfRidge.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setStateOfRidge(
              value as StateOfRidge?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.need_for_cement_work'.tr(),
            value: widget.props.store.siteSheet!.needForCementWork,
            displayedValue:
                widget.props.store.siteSheet!.needForCementWork == null
                    ? null
                    : widget.props.store.siteSheet!.needForCementWork!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: (dynamic value) =>
                widget.props.store.setNeedForCementWork(value as bool?),
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'site_sheet.content.roof.category.water_repellent'
                .tr()
                .toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        const SizedBox(height: 10),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.velux_to_be_waterproofed'.tr(),
            value: widget.props.store.siteSheet!.veluxToBeWaterproofed,
            displayedValue:
                widget.props.store.siteSheet!.veluxToBeWaterproofed == null
                    ? null
                    : widget.props.store.siteSheet!.veluxToBeWaterproofed!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            onChanged: (dynamic value) =>
                widget.props.store.setVeluxToBeWaterproofed(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.ridge_to_be_waterproofed'.tr(),
            value: widget.props.store.siteSheet!.rigdeToBeWaterproofed,
            displayedValue:
                widget.props.store.siteSheet!.rigdeToBeWaterproofed == null
                    ? null
                    : widget.props.store.siteSheet!.rigdeToBeWaterproofed!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setRigdeToBeWaterproofed(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.cladding_to_be_waterproofed'.tr(),
            value: widget.props.store.siteSheet!.claddingToBeWaterproofed,
            displayedValue:
                widget.props.store.siteSheet!.claddingToBeWaterproofed == null
                    ? null
                    : widget.props.store.siteSheet!.claddingToBeWaterproofed!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setCladdingToBeWaterproofed(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.roof.edges_to_be_waterproofed'.tr(),
            value: widget.props.store.siteSheet!.edgesToBeWaterproofed,
            displayedValue:
                widget.props.store.siteSheet!.edgesToBeWaterproofed == null
                    ? null
                    : widget.props.store.siteSheet!.edgesToBeWaterproofed!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setEdgesToBeWaterproofed(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.roof.water_repellent_color'.tr(),
            textAlign: TextAlign.right,
            controller: _waterRepellentColorController,
            withDebounce: true,
            debounceKey: 'waterRepellentColor',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setWaterRepellentColor,
          ),
        ),
      ],
    );
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _numberOfSectionsController.dispose();
    _totalRoofAreaController.dispose();
    _ageOfRoofAreaController.dispose();
    _checkingRecoveryController.dispose();
    _existingGutterController.dispose();
    _existingGuttersColorsController.dispose();
    _gableHeightController.dispose();
    _heightUnderGutterController.dispose();
    _numberOfChimneysController.dispose();
    _chimneysToPaintColorController.dispose();
    _numberOfDormersController.dispose();
    _numberOfVeluxController.dispose();
    _typeOfRidgeController.dispose();
    _waterRepellentColorController.dispose();
    super.dispose();
  }
}
