import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ExposureTabWidgetInterface implements Widget {
  ExposureTabProps get props;
}

// Props:-----------------------------------------------------------------------
class ExposureTabProps {
  const ExposureTabProps({
    required this.store,
  });

  final CustomerSiteSheetStoreInterface store;
}

// Implementation:--------------------------------------------------------------
class ExposureTab extends StatelessWidget
    implements ExposureTabWidgetInterface {
  const ExposureTab({super.key, required this.props});

  @override
  final ExposureTabProps props;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getIt<MultiSelectDialogWidgetInterface>(
            param1: MultiSelectDialogProps(
              label: 'site_sheet.content.exposure.exposure'.tr(),
              values:
                  props.store.siteSheet!.exposures.map((e) => e.name).toList(),
              displayedValue: props.store.siteSheet!.exposuresString,
              choices: Exposure.choices,
              onChanged: props.store.setExposures,
            ),
          ),
        ],
      ),
    );
  }
}
