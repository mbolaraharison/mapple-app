import 'package:easy_localization/easy_localization.dart';

enum FileDataType {
  normal('file_data_type.normal'),
  quote('file_data_type.quote');

  const FileDataType(this.labelKey);

  final String labelKey;
  String get label => labelKey.tr();
}
