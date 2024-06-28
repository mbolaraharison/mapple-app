import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'service_option_item_drift_dao.g.dart';

@DriftAccessor(tables: [ServiceOptionItems])
class ServiceOptionItemDriftDao extends AbstractDriftDao<
    ServiceOptionItem,
    $ServiceOptionItemsTable,
    AgencyDatabase> with _$ServiceOptionItemDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ServiceOptionItemDriftDao(AgencyDatabase db)
      : super(db, db.serviceOptionItems);
}
