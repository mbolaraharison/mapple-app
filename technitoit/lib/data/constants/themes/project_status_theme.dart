import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

class ProjectStatusTheme implements ProjectStatusThemeInterface {
  @override
  final Map<ProjectStatus, String> icons = {
    ProjectStatus.inProgress: MapleCommonAssets.inProgress,
    ProjectStatus.validated: MapleCommonAssets.validated,
    ProjectStatus.cancelled: MapleCommonAssets.cancelled,
  };

  @override
  final Map<ProjectStatus, LinearGradient> gradients = {
    ProjectStatus.inProgress: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFFF8A00),
        Color(0xFFFFC700),
      ],
    ),
    ProjectStatus.validated: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF2EB6BE),
        Color(0xFF4CCFBF),
      ],
    ),
    ProjectStatus.cancelled: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFFE4E4E),
        Color(0xFFFF7373),
      ],
    ),
  };
}
