import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class EmailTemplateServiceInterface {
  Future<EmailTemplate?> getByTemplateName(String templateName);

  Future<void> startSyncAll({int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class EmailTemplateService extends AbstractModelService<
    EmailTemplate,
    $EmailTemplatesTable,
    AgencyDatabase> implements EmailTemplateServiceInterface {
  EmailTemplateService()
      : super(
            getIt<EmailTemplateDriftDao>(), getIt<EmailTemplateFirestoreDao>());

  // Methods:-------------------------------------------------------------------
  @override
  Future<EmailTemplate?> getByTemplateName(String templateName) {
    return (remoteDao as EmailTemplateFirestoreDao)
        .getByTemplateName(templateName);
  }
}
