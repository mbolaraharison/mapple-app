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
      const Color(0xFFFF8A00),
      const Color(0xFFFFC700),
    ],
    OrderStatus.B: [
      const Color(0xFFFF8A00),
      const Color(0xFFFFC700),
    ],
    OrderStatus.C: [
      const Color(0xFFFE4E4E),
      const Color(0xFFFF7373),
    ],
    OrderStatus.D: [
      const Color(0xFFFE4E4E),
      const Color(0xFFFF7373),
    ],
    OrderStatus.E: [
      const Color(0xFF2EB6BE),
      const Color(0xFF4CCFBF),
    ],
    OrderStatus.Z: [
      const Color.fromARGB(255, 43, 0, 255),
      const Color.fromARGB(255, 10, 192, 253),
    ],
  };
}
