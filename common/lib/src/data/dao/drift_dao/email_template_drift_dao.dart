import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'email_template_drift_dao.g.dart';

@DriftAccessor(tables: [EmailTemplates])
class EmailTemplateDriftDao extends AbstractDriftDao<EmailTemplate,
    $EmailTemplatesTable, AgencyDatabase> with _$EmailTemplateDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  EmailTemplateDriftDao(AgencyDatabase db) : super(db, db.emailTemplates);
}
