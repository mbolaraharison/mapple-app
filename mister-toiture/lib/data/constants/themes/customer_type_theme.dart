import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mister_toiture_app/constants/colors.dart';

class CustomerTypeTheme implements CustomerTypeThemeInterface {
  @override
  final Map<CustomerType, String> icons = {
    CustomerType.individual: MapleCommonAssets.homeActive,
    CustomerType.professional: MapleCommonAssets.buildings,
  };

  @override
  final Map<CustomerType, Color> activeColors = {
    CustomerType.individual: AppColors.blue,
    CustomerType.professional: MapleCommonColors.red,
  };
}
