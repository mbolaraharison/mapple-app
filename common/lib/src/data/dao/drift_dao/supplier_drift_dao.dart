import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'supplier_drift_dao.g.dart';

@DriftAccessor(tables: [Suppliers])
class SupplierDriftDao
    extends AbstractDriftDao<Supplier, $SuppliersTable, AgencyDatabase>
    with _$SupplierDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  SupplierDriftDao(AgencyDatabase db) : super(db, db.suppliers);

  Future<List<Supplier>> findAllByAgencyId(String agencyId) async {
    return (select(suppliers)
          ..where((tbl) =>
              tbl.agencyId.equals(agencyId) & tbl.isActive.equals(true)))
        .get();
  }
}
