import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DocusignLogServiceInterface {
  Future<DocusignLog> create(DocusignLog docusignLog);
  Future<DocusignLog> createLog({
    required String envelopeId,
    required String orderId,
    required String recipientId,
    required String recipientName,
    required DocusignLogAction action,
    required String actionLabel,
    required String actionDescription,
  });
  Future<void> createLogWhileOpeningEnvelope({
    required String envelopeId,
    required String orderId,
    required String recipientId,
    required String recipientName,
    required String url,
    required String initialUrl,
    bool isSigned = false,
    bool isCompleted = false,
  });
}

// Implementation:--------------------------------------------------------------
class DocusignLogService implements DocusignLogServiceInterface {
  DocusignLogFirestoreDao docusignLogDao = getIt<DocusignLogFirestoreDao>();
  UuidUtilsInterface uuidUtils = getIt<UuidUtilsInterface>();

  @override
  Future<DocusignLog> create(DocusignLog docusignLog) async {
    return docusignLogDao.create(docusignLog);
  }

  @override
  Future<DocusignLog> createLog({
    required String envelopeId,
    required String orderId,
    required String recipientId,
    required String recipientName,
    required DocusignLogAction action,
    required String actionLabel,
    required String actionDescription,
  }) async {
    final docusignLog = DocusignLog(
      id: uuidUtils.generate(),
      envelopeId: envelopeId,
      orderId: orderId,
      recipientId: recipientId,
      recipientName: recipientName,
      action: action,
      actionLabel: actionLabel,
      actionDescription: actionDescription,
    );
    return create(docusignLog);
  }

  @override
  Future<void> createLogWhileOpeningEnvelope({
    required String envelopeId,
    required String orderId,
    required String recipientId,
    required String recipientName,
    required String url,
    required String initialUrl,
    bool isSigned = false,
    bool isCompleted = false,
  }) async {
    // save docusign log for recipient opening envelope
    if (url == initialUrl) {
      await createLog(
        envelopeId: envelopeId,
        orderId: orderId,
        recipientId: recipientId,
        recipientName: recipientName,
        action: DocusignLogAction.ENVELOPE_OPENED,
        actionLabel: DocusignLogAction.ENVELOPE_OPENED.label,
        actionDescription: DocusignLogAction.ENVELOPE_OPENED.description,
      );
    } else if (url.contains('/Signing/')) {
      // save docusign log for authentication
      await createLog(
        envelopeId: envelopeId,
        orderId: orderId,
        recipientId: recipientId,
        recipientName: recipientName,
        action: DocusignLogAction.ENVELOPE_AUTHENTICATION,
        actionLabel: DocusignLogAction.ENVELOPE_AUTHENTICATION.label,
        actionDescription:
            DocusignLogAction.ENVELOPE_AUTHENTICATION.description,
      );
    } else if (url.startsWith('https://docusign.return.url') &&
        url.endsWith('event=signing_complete') &&
        isSigned == true) {
      // save docusign log for recipient that has signed envelope
      await createLog(
        envelopeId: envelopeId,
        orderId: orderId,
        recipientId: recipientId,
        recipientName: recipientName,
        action: DocusignLogAction.ENVELOPE_SIGNED,
        actionLabel: DocusignLogAction.ENVELOPE_SIGNED.label,
        actionDescription: DocusignLogAction.ENVELOPE_SIGNED.description,
      );
      if (isCompleted == true) {
        // save docusign log for completed envelope
        await createLog(
          envelopeId: envelopeId,
          orderId: orderId,
          recipientId: '',
          recipientName: 'Docusign Account',
          action: DocusignLogAction.ENVELOPE_COMPLETED,
          actionLabel: DocusignLogAction.ENVELOPE_COMPLETED.label,
          actionDescription: DocusignLogAction.ENVELOPE_COMPLETED.description,
        );
      }
    } else {
      // save docusign log for random navigation
      await createLog(
        envelopeId: envelopeId,
        orderId: orderId,
        recipientId: recipientId,
        recipientName: recipientName,
        action: DocusignLogAction.RANDOM_NAVIGATION,
        actionLabel: DocusignLogAction.RANDOM_NAVIGATION.label,
        actionDescription: url,
      );
    }
  }
}
