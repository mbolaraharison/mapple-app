import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class InsulationTabWidgetInterface implements Widget {
  InsulationTabProps get props;
}

// Props:-----------------------------------------------------------------------
class InsulationTabProps {
  const InsulationTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class InsulationTab extends StatefulWidget
    implements InsulationTabWidgetInterface {
  const InsulationTab({super.key, required this.props});

  @override
  final InsulationTabProps props;

  @override
  State<InsulationTab> createState() => _InsulationTabState();
}

class _InsulationTabState extends State<InsulationTab> {
  // Variables:-----------------------------------------------------------------
  final TextEditingController _insulationAreaController =
      TextEditingController();
  final TextEditingController _mineralWoolTypeController =
      TextEditingController();
  final TextEditingController _existingInsulationAgeController =
      TextEditingController();
  final TextEditingController _ventilationSystemAgeController =
      TextEditingController();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _insulationAreaController.text =
        widget.props.store.siteSheet?.insulationArea ?? '';
    _mineralWoolTypeController.text =
        widget.props.store.siteSheet?.mineralWoolType ?? '';
    _existingInsulationAgeController.text =
        widget.props.store.siteSheet?.existingInsulationAge ?? '';
    _ventilationSystemAgeController.text =
        widget.props.store.siteSheet?.ventilationSystemAge ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.insulation.insulation_access_type'.tr(),
            value: widget.props.store.siteSheet!.insulationAccessType,
            displayedValue:
                widget.props.store.siteSheet!.insulationAccessType?.label,
            choices: InsulationAccessType.choices,
            nullable: true,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            onChanged: (dynamic value) =>
                widget.props.store.setInsulationAccessType(
              value as InsulationAccessType?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<MultiSelectDialogWidgetInterface>(
          param1: MultiSelectDialogProps(
            label: 'site_sheet.content.insulation.insulators'.tr(),
            values: widget.props.store.siteSheet!.insulators
                .map((e) => e.name)
                .toList(),
            displayedValue: widget.props.store.siteSheet!.insulatorsString,
            choices: Insulator.choices,
            borderRadius: BorderRadius.zero,
            onChanged: widget.props.store.setInsulators,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.insulation.insulation_area'.tr(),
            textAlign: TextAlign.right,
            controller: _insulationAreaController,
            withDebounce: true,
            debounceKey: 'insulationArea',
            onChanged: widget.props.store.setInsulationArea,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.insulation.mineral_wool_type'.tr(),
            textAlign: TextAlign.right,
            controller: _mineralWoolTypeController,
            withDebounce: true,
            debounceKey: 'mineralWoolType',
            onChanged: widget.props.store.setMineralWoolType,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label:
                'site_sheet.content.insulation.insulation_type_of_installation'
                    .tr(),
            value: widget.props.store.siteSheet!.insulationTypeOfInstallation,
            displayedValue: widget
                .props.store.siteSheet!.insulationTypeOfInstallation?.label,
            choices: InsulationTypeOfInstallation.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setInsulationTypeOfInstallation(
              value as InsulationTypeOfInstallation?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label:
                'site_sheet.content.insulation.existing_insulation_type'.tr(),
            value: widget.props.store.siteSheet!.existingInsulationType,
            displayedValue:
                widget.props.store.siteSheet!.existingInsulationType?.label,
            choices: ExistingInsulationType.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setExistingInsulationType(
              value as ExistingInsulationType?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.insulation.existing_insulation_age'.tr(),
            textAlign: TextAlign.right,
            controller: _existingInsulationAgeController,
            withDebounce: true,
            debounceKey: 'existingInsulationAge',
            onChanged: widget.props.store.setExistingInsulationAge,
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label:
                'site_sheet.content.insulation.removal_of_existing_insulation'
                    .tr(),
            value: widget.props.store.siteSheet!.removalOfExistingInsulation,
            displayedValue:
                widget.props.store.siteSheet!.removalOfExistingInsulation ==
                        null
                    ? null
                    : widget.props.store.siteSheet!.removalOfExistingInsulation!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setRemovalOfExistingInsulation(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.insulation.attic_floor_type'.tr(),
            value: widget.props.store.siteSheet!.atticFloorType,
            displayedValue: widget.props.store.siteSheet!.atticFloorType?.label,
            choices: AtticFloorType.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) => widget.props.store.setAtticFloorType(
              value as AtticFloorType?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.insulation.roof_structure_type'.tr(),
            value: widget.props.store.siteSheet!.roofStructureType,
            displayedValue:
                widget.props.store.siteSheet!.roofStructureType?.label,
            choices: RoofStructureType.choices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setRoofStructureType(
              value as RoofStructureType?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<SelectDialogWidgetInterface>(
          param1: SelectDialogProps(
            label: 'site_sheet.content.insulation.ventilation_system'.tr(),
            value: widget.props.store.siteSheet!.ventilationSystem,
            displayedValue:
                widget.props.store.siteSheet!.ventilationSystem == null
                    ? null
                    : widget.props.store.siteSheet!.ventilationSystem!
                        ? 'yes'.tr()
                        : 'no'.tr(),
            choices: yesNoChoices,
            nullable: true,
            borderRadius: BorderRadius.zero,
            onChanged: (dynamic value) =>
                widget.props.store.setVentilationSystem(
              value as bool?,
            ),
          ),
        ),
        getIt<SeparatorWidgetInterface>(),
        getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: 'site_sheet.content.insulation.ventilation_system_age'.tr(),
            textAlign: TextAlign.right,
            controller: _ventilationSystemAgeController,
            withDebounce: true,
            debounceKey: 'ventilationSystemAge',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            onChanged: widget.props.store.setVentilationSystemAge,
          ),
        ),
      ],
    );
  }

  // Dispose methods:-----------------------------------------------------------
  @override
  void dispose() {
    _insulationAreaController.dispose();
    _mineralWoolTypeController.dispose();
    _existingInsulationAgeController.dispose();
    _ventilationSystemAgeController.dispose();
    super.dispose();
  }
}
