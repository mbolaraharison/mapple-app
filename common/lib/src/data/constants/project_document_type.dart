// ignore_for_file: constant_identifier_names

import 'package:easy_localization/easy_localization.dart';

enum ProjectDocumentType {
  ORDER_FORM('project_document_type.order_form'),
  TERMS_APPROVAL('project_document_type.terms_approval'),
  VAT_CERTIFICATE('project_document_type.vat_certificate');

  const ProjectDocumentType(this.labelKey);

  final String labelKey;

  String get label => labelKey.tr();
}
