import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SupplierServiceInterface {
  Future<List<Supplier>> getAll();

  Future<Supplier?> getById(String id,
      {bool eager = false, List<Type> flow = const []});

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class SupplierService
    extends AbstractModelService<Supplier, $SuppliersTable, AgencyDatabase>
    implements SupplierServiceInterface {
  SupplierService()
      : super(getIt<SupplierDriftDao>(), getIt<SupplierFirestoreDao>());

  // Services:--------------------------------------------------------------------
  late final AgencyServiceInterface _agencyService =
      getIt.get<AgencyServiceInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<List<Supplier>> getAll() async {
    final currentAgency = await _agencyService.getCurrent();

    return (localDao as SupplierDriftDao).findAllByAgencyId(currentAgency!.id);
  }

  @override
  Future<Supplier?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    final supplier = await super.getById(id);
    if (supplier != null && eager) {
      await supplier.loadData(eager: eager, flow: flow);
    }
    return supplier;
  }
}
