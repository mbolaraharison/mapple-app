import 'package:easy_localization/easy_localization.dart';

enum FileDataMode {
  local('file_data_mode.local'),
  remote('file_data_mode.remote');

  const FileDataMode(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();
}
