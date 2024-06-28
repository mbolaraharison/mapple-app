import 'package:maple_common/maple_common.dart';

class EnvelopeDefinitionModel {
  late final List<DocumentModel> documents;
  late final String emailSubject;
  late final RecipientsModel recipients;
  late final String status;

  EnvelopeDefinitionModel({
    required this.documents,
    required this.emailSubject,
    required this.recipients,
    required this.status,
  });

  EnvelopeDefinitionModel.fromJson(Map<String, dynamic> json)
      : documents = json['documents'],
        emailSubject = json['emailSubject'],
        recipients = json['recipients'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'documents': documents
            .map((DocumentModel document) => document.toJson())
            .toList(),
        'emailSubject': emailSubject,
        'recipients': recipients.toJson(),
        'status': status,
      };
}
