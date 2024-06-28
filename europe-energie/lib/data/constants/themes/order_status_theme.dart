import 'package:maple_common/maple_common.dart';
import 'dart:ui';

class OrderStatusTheme implements OrderStatusThemeInterface {
  @override
  Map<OrderStatus, String> icons = {
    OrderStatus.A: MapleCommonAssets.inProgress,
    OrderStatus.B: MapleCommonAssets.inProgress,
    OrderStatus.C: MapleCommonAssets.cancelled,
    OrderStatus.D: MapleCommonAssets.cancelled,
    OrderStatus.E: MapleCommonAssets.validated,
    OrderStatus.Z: MapleCommonAssets.inProgress,
  };

  @override
  final Map<OrderStatus, List<Color>> colors = {
    OrderStatus.A: [
      Color(0xFFFF8A00),
      Color(0xFFFFC700),
    ],
    OrderStatus.B: [
      Color(0xFFFF8A00),
      Color(0xFFFFC700),
    ],
    OrderStatus.C: [
      Color(0xFFFE4E4E),
      Color(0xFFFF7373),
    ],
    OrderStatus.D: [
      Color(0xFFFE4E4E),
      Color(0xFFFF7373),
    ],
    OrderStatus.E: [
      Color(0xFF2EB6BE),
      Color(0xFF4CCFBF),
    ],
    OrderStatus.Z: [
      Color.fromARGB(255, 43, 0, 255),
      Color.fromARGB(255, 10, 192, 253),
    ],
  };
}
