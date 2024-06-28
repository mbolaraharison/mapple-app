import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceFamilyServiceInterface {
  Future<ServiceFamily?> getById(String id);

  Future<List<ServiceFamily>> getByDiscountCodeId(String discountCodeId);

  Future<List<ServiceFamily>> getAllActiveAndOrderByPosition();

  Stream<List<ServiceFamily>> getAllActiveAndOrderByPositionAsStream();

  Future<List<ServiceFamily>> getAll();

  Future<void> startSyncAll({int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class ServiceFamilyService extends AbstractModelService<
    ServiceFamily,
    $ServiceFamiliesTable,
    AgencyDatabase> implements ServiceFamilyServiceInterface {
  ServiceFamilyService()
      : super(
            getIt<ServiceFamilyDriftDao>(), getIt<ServiceFamilyFirestoreDao>());

  @override
  Future<List<ServiceFamily>> getByDiscountCodeId(String discountCodeId) {
    return (localDao as ServiceFamilyDriftDao)
        .findByDiscountCodeId(discountCodeId);
  }

  Stream<List<ServiceFamily>> getByDiscountCodeIdAsStream(
      String discountCodeId) {
    return (localDao as ServiceFamilyDriftDao)
        .findByDiscountCodeIdAsStream(discountCodeId);
  }

  @override
  Future<List<ServiceFamily>> getAllActiveAndOrderByPosition() {
    return (localDao as ServiceFamilyDriftDao)
        .findAllActiveAndOrderByPosition();
  }

  @override
  Stream<List<ServiceFamily>> getAllActiveAndOrderByPositionAsStream() {
    return (localDao as ServiceFamilyDriftDao)
        .findAllActiveAndOrderByPositionAsStream()
        .transform(streamTransformerUtils
            .getListResultDriftStreamOptimizer<ServiceFamily>());
  }
}
