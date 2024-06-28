import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Theme:-----------------------------------------------------------------------
abstract class ProjectStatusThemeInterface {
  ProjectStatusThemeInterface._(this.icons, this.gradients);

  final Map<ProjectStatus, String> icons;

  final Map<ProjectStatus, LinearGradient> gradients;
}

// Enum:------------------------------------------------------------------------
enum ProjectStatus {
  inProgress('project_status_in_progress'),
  validated('project_status_validated'),
  cancelled('project_status_cancelled');

  const ProjectStatus(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();

  ProjectStatusThemeInterface get _theme =>
      getIt<ProjectStatusThemeInterface>();

  String get icon => _theme.icons[this]!;

  LinearGradient get gradient => _theme.gradients[this]!;
}
