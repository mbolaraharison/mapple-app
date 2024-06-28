import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:technitoit_app/constants/colors.dart';

class CustomerTypeTheme implements CustomerTypeThemeInterface {
  @override
  final Map<CustomerType, String> icons = {
    CustomerType.individual: MapleCommonAssets.homeActive,
    CustomerType.professional: MapleCommonAssets.buildings,
  };

  @override
  final Map<CustomerType, Color> activeColors = {
    CustomerType.individual: AppColors.blueLight,
    CustomerType.professional: AppColors.orange,
  };
}
