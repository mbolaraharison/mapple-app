import 'dart:ui';
import 'package:europe_energie_app/constants/assets.dart';
import 'package:maple_common/maple_common.dart';

class MainScreenTheme implements MainScreenThemeInterface {
  @override
  final Color defaultBackgroundColor = MapleCommonColors.greyMidLight;

  @override
  final String syncErrorBackgroundImage = Assets.loginBackground;
}
