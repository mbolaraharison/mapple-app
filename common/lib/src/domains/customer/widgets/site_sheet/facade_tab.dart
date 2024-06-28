import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class FacadeTabWidgetInterface implements Widget {
  FacadeTabProps get props;
}

// Props:-----------------------------------------------------------------------
class FacadeTabProps {
  const FacadeTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class FacadeTab extends StatefulWidget implements FacadeTabWidgetInterface {
  const FacadeTab({super.key, required this.props});

  @override
  final FacadeTabProps props;

  @override
  State<FacadeTab> createState() => _FacadeTabState();
}

class _FacadeTabState extends State<FacadeTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _facadeAreaController = TextEditingController();
  final TextEditingController _facadeAgeController = TextEditingController();
  final TextEditingController _typeOfExistingSupportController =
      TextEditingController();
  final TextEditingController _numberOfWindowsController =
      TextEditingController();
  final TextEditingController _cracksController = TextEditingController();
  final TextEditingController _microCracksController = TextEditingController();
  final TextEditingController _facadeColorController = TextEditingController();
  final TextEditingController _baseColorController = TextEditingController();
  final TextEditingController _windowSurroundingColorController =
      TextEditingController();
  final TextEditingController _externalVentilationGrillesController =
      TextEditingController();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _facadeAreaController.text = widget.props.store.siteSheet?.facadeArea ?? '';
    _facadeAgeController.text = widget.props.store.siteSheet?.facadeAge ?? '';
    _typeOfExistingSupportController.text =
        widget.props.store.siteSheet?.typeOfExistingSupport ?? '';
    _numberOfWindowsController.text =
        widget.props.store.siteSheet?.numberOfWindows ?? '';
    _cracksController.text = widget.props.store.siteSheet?.cracks ?? '';
    _microCracksController.text =
        widget.props.store.siteSheet?.microCracks ?? '';
    _facadeColorController.text =
        widget.props.store.siteSheet?.facadeColor ?? '';
    _baseColorController.text = widget.props.store.siteSheet?.baseColor ?? '';
    _windowSurroundingColorController.text =
        widget.props.store.siteSheet?.windowSurroundingColor ?? '';
    _externalVentilationGrillesController.text =
        widget.props.store.siteSheet?.externalVentilationGrilles ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.facade_area'.tr(),
            textAlign: TextAlign.right,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            controller: _facadeAreaController,
            withDebounce: true,
            debounceKey: 'facadeArea',
            onChanged: widget.props.store.setFacadeArea,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.facade_age'.tr(),
            textAlign: TextAlign.right,
            controller: _facadeAgeController,
            withDebounce: true,
            debounceKey: 'facadeAge',
            onChanged: widget.props.store.setFacadeAge,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.type_of_existing_support'.tr(),
            textAlign: TextAlign.right,
            controller: _typeOfExistingSupportController,
            withDebounce: true,
            debounceKey: 'typeOfExistingSupport',
            onChanged: widget.props.store.setTypeOfExistingSupport,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<MultiSelectDialogWidgetInterface>(
          param1: MultiSelectDialogProps(
            label:
                'site_sheet.content.facade.facade_existing_support_types'.tr(),
            values: widget.props.store.siteSheet!.facadeExistingSupportTypes
                .map((e) => e.name)
                .toList(),
            displayedValue:
                widget.props.store.siteSheet!.facadeExistingSupportTypesString,
            choices: FacadeExistingSupportType.choices,
            borderRadius: BorderRadius.zero,
            onChanged: widget.props.store.setFacadeExistingSupportTypes,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<RowButtonWidgetInterface>(
          param1: RowButtonProps(
            value: 'site_sheet.content.facade.is_damp_support'.tr(),
            disableOnTapEffect: true,
            valueColor: _appThemeData.defaultTextColor,
            rightChild: CupertinoSwitch(
              value: widget.props.store.siteSheet!.isDampSupport,
              activeColor: _appThemeData.activeSwitchButtonColor,
              onChanged: widget.props.store.setIsDampSupport,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.facade.is_blown_coating'.tr(),
            value: widget.props.store.siteSheet!.isBlownCoating,
            displayedValue: widget.props.store.siteSheet!.isBlownCoating == null
                ? null
                : widget.props.store.siteSheet!.isBlownCoating!
                    ? 'yes'.tr()
                    : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setIsBlownCoating(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.facade.facade_type_of_work'.tr(),
            value: widget.props.store.siteSheet!.facadeTypeOfWork,
            displayedValue:
                widget.props.store.siteSheet!.facadeTypeOfWork?.label,
            choices: FacadeTypeOfWork.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setFacadeTypeOfWork(
              value as FacadeTypeOfWork?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.facade.water_repellent_type'.tr(),
            value: widget.props.store.siteSheet!.waterRepellentType,
            displayedValue:
                widget.props.store.siteSheet!.waterRepellentType?.label,
            choices: WaterRepellentType.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setWaterRepellentType(
              value as WaterRepellentType?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.number_of_windows'.tr(),
            textAlign: TextAlign.right,
            controller: _numberOfWindowsController,
            withDebounce: true,
            debounceKey: 'numberOfWindows',
            onChanged: widget.props.store.setNumberOfWindows,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.cracks'.tr(),
            textAlign: TextAlign.right,
            controller: _cracksController,
            withDebounce: true,
            debounceKey: 'cracks',
            onChanged: widget.props.store.setCracks,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.micro_cracks'.tr(),
            textAlign: TextAlign.right,
            controller: _microCracksController,
            withDebounce: true,
            debounceKey: 'microCracks',
            onChanged: widget.props.store.setMicroCracks,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.facade_color'.tr(),
            textAlign: TextAlign.right,
            controller: _facadeColorController,
            withDebounce: true,
            debounceKey: 'facadeColor',
            onChanged: widget.props.store.setFacadeColor,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.base_color'.tr(),
            textAlign: TextAlign.right,
            controller: _baseColorController,
            withDebounce: true,
            debounceKey: 'baseColor',
            onChanged: widget.props.store.setBaseColor,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.facade.window_surrounding_color'.tr(),
            textAlign: TextAlign.right,
            controller: _windowSurroundingColorController,
            withDebounce: true,
            debounceKey: 'windowSurroundingColor',
            onChanged: widget.props.store.setWindowSurroundingColor,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label:
                'site_sheet.content.facade.external_ventilation_grilles'.tr(),
            textAlign: TextAlign.right,
            controller: _externalVentilationGrillesController,
            withDebounce: true,
            debounceKey: 'externalVentilationGrilles',
            onChanged: widget.props.store.setExternalVentilationGrilles,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<MultiSelectDialogWidgetInterface>(
          param1: MultiSelectDialogProps(
            label: 'site_sheet.content.facade.surrounding_windows_types'.tr(),
            values: widget.props.store.siteSheet!.surroundingWindowsTypes
                .map((e) => e.name)
                .toList(),
            displayedValue:
                widget.props.store.siteSheet!.surroundingWindowsTypesString,
            choices: SurroundingWindowsType.choices,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setSurroundingWindowsTypes,
          ),
        ),
      ],
    );
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _facadeAreaController.dispose();
    _facadeAgeController.dispose();
    _typeOfExistingSupportController.dispose();
    _numberOfWindowsController.dispose();
    _cracksController.dispose();
    _microCracksController.dispose();
    _facadeColorController.dispose();
    _baseColorController.dispose();
    _windowSurroundingColorController.dispose();
    _externalVentilationGrillesController.dispose();
    super.dispose();
  }
}
