import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceOptionItemServiceInterface {
  Future<ServiceOptionItem?> getById(String id);

  Future<List<ServiceOptionItem>> getAll();

  Future<void> startSyncAll({int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class ServiceOptionItemService extends AbstractModelService<
    ServiceOptionItem,
    $ServiceOptionItemsTable,
    AgencyDatabase> implements ServiceOptionItemServiceInterface {
  ServiceOptionItemService()
      : super(getIt<ServiceOptionItemDriftDao>(),
            getIt<ServiceOptionItemFirestoreDao>());
}
