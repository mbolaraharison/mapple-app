import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class StatementOfInformationTabWidgetInterface implements Widget {
  StatementOfInformationTabProps get props;
}

// Props:-----------------------------------------------------------------------
class StatementOfInformationTabProps {
  const StatementOfInformationTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class StatementOfInformationTab extends StatelessWidget
    implements StatementOfInformationTabWidgetInterface {
  const StatementOfInformationTab({super.key, required this.props});

  @override
  final StatementOfInformationTabProps props;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'site_sheet.content.mandatory_fields'.tr(),
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 18),
          Observer(builder: (context) {
            return getIt<MultiSelectDialogWidgetInterface>(
              param1: MultiSelectDialogProps(
                label: 'site_sheet.content.informations'.tr(),
                values: props.store.siteSheet!.houseTypes
                    .map((e) => e.name)
                    .toList(),
                displayedValue: props.store.siteSheet!.houseTypesString,
                choices: HouseType.choices,
                onChanged: props.store.setHouseTypes,
              ),
            );
          }),
        ],
      ),
    );
  }
}
