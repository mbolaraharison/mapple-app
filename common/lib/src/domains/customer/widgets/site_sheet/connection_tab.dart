import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ConnectionTabWidgetInterface implements Widget {
  ConnectionTabProps get props;
}

// Props:-----------------------------------------------------------------------
class ConnectionTabProps {
  const ConnectionTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class ConnectionTab extends StatelessWidget
    implements ConnectionTabWidgetInterface {
  const ConnectionTab({super.key, required this.props});

  @override
  final ConnectionTabProps props;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getIt<SelectDialogWidgetInterface>(
            param1: SelectDialogProps(
              label: 'site_sheet.content.connection.water_recuperator'.tr(),
              value: props.store.siteSheet!.waterRecuperator,
              displayedValue: props.store.siteSheet!.waterRecuperator == null
                  ? null
                  : props.store.siteSheet!.waterRecuperator!
                      ? 'yes'.tr()
                      : 'no'.tr(),
              choices: yesNoChoices,
              nullable: true,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              onChanged: (dynamic value) => props.store.setWaterRecuperator(
                value as bool?,
              ),
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<SelectDialogWidgetInterface>(
            param1: SelectDialogProps(
              label: 'site_sheet.content.connection.water_supply_type'.tr(),
              value: props.store.siteSheet!.waterSupplyType,
              displayedValue: props.store.siteSheet!.waterSupplyType?.label,
              choices: WaterSupplyType.choices,
              nullable: true,
              borderRadius: BorderRadius.zero,
              onChanged: (dynamic value) => props.store.setWaterSupplyType(
                value as WaterSupplyType?,
              ),
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<SelectDialogWidgetInterface>(
            param1: SelectDialogProps(
              label: 'site_sheet.content.connection.water_supply_outdoor_type'
                  .tr(),
              value: props.store.siteSheet!.waterSupplyOutdoorType,
              displayedValue:
                  props.store.siteSheet!.waterSupplyOutdoorType?.label,
              choices: WaterSupplyOutdoorType.choices,
              nullable: true,
              borderRadius: BorderRadius.zero,
              onChanged: (dynamic value) =>
                  props.store.setWaterSupplyOutdoorType(
                value as WaterSupplyOutdoorType?,
              ),
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<SelectDialogWidgetInterface>(
            param1: SelectDialogProps(
              label: 'site_sheet.content.connection.water_pression_type'.tr(),
              value: props.store.siteSheet!.waterPressionType,
              displayedValue: props.store.siteSheet!.waterPressionType?.label,
              choices: WaterPressionType.choices,
              nullable: true,
              borderRadius: BorderRadius.zero,
              onChanged: (dynamic value) => props.store.setWaterPressionType(
                value as WaterPressionType?,
              ),
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<SelectDialogWidgetInterface>(
            param1: SelectDialogProps(
              label: 'site_sheet.content.connection.electricity_type'.tr(),
              value: props.store.siteSheet!.electricityType,
              displayedValue: props.store.siteSheet!.electricityType?.label,
              choices: ElectricityType.choices,
              nullable: true,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              onChanged: (dynamic value) => props.store.setElectricityType(
                value as ElectricityType?,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
