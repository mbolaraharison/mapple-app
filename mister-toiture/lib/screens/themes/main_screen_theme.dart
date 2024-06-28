import 'dart:ui';
import 'package:maple_common/maple_common.dart';
import 'package:mister_toiture_app/constants/assets.dart';

class MainScreenTheme implements MainScreenThemeInterface {
  @override
  final Color defaultBackgroundColor = MapleCommonColors.greyMidLight;

  @override
  final String syncErrorBackgroundImage = Assets.loginBackground;
}
