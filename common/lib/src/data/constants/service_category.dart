// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum ServiceCategory {
  PREST('service_category.service'),
  COMP('service_category.component'),
  REFAC('service_category.rebilling'),
  DIV('service_category.miscellaneous');

  const ServiceCategory(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();
}
