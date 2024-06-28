// ignore_for_file: constant_identifier_names
import 'package:easy_localization/easy_localization.dart';

// Enum:------------------------------------------------------------------------
enum DocusignLogAction {
  ENVELOPE_CREATED('docusign.log.envelope_created.title',
      'docusign.log.envelope_created.description'),
  ENVELOPE_OPENED('docusign.log.envelope_opened.title',
      'docusign.log.envelope_opened.description'),
  ENVELOPE_SIGNED('docusign.log.envelope_signed.title',
      'docusign.log.envelope_signed.description'),
  ENVELOPE_COMPLETED('docusign.log.envelope_completed.title',
      'docusign.log.envelope_completed.description'),
  ENVELOPE_DELETED('docusign.log.envelope_deleted.title',
      'docusign.log.envelope_deleted.description'),
  ENVELOPE_SIGNATURE_NAVIGATION(
      'docusign.log.envelope_signature_navigation.title',
      'docusign.log.envelope_signature_navigation.description'),
  ENVELOPE_AUTHENTICATION('docusign.log.envelope_authentication.title',
      'docusign.log.envelope_authentication.description'),
  RANDOM_NAVIGATION('docusign.log.random_navigation.title',
      'docusign.log.random_navigation.description'),
  WEBVIEW_CLOSED('docusign.log.webview_closed.title',
      'docusign.log.webview_closed.description'),
  NAVIGATION_ERROR('docusign.log.navigation_error.title',
      'docusign.log.navigation_error.description');

  const DocusignLogAction(this.labelKey, this.descriptionKey);

  final String labelKey;
  final String descriptionKey;

  String get label => labelKey.tr();
  String get description => descriptionKey.tr();

  static DocusignLogAction fromValue(String value) {
    return DocusignLogAction.values.firstWhere(
      (element) => element.labelKey == value,
      orElse: () => DocusignLogAction.ENVELOPE_CREATED,
    );
  }
}
