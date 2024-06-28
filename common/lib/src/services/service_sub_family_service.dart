import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceSubFamilyServiceInterface {
  Future<ServiceSubFamily?> getById(String id,
      {bool eager = false, List<Type> flow = const []});

  Future<List<ServiceSubFamily>> getByDiscountCodeId(String discountCodeId,
      {bool eager = false, List<Type> flow = const []});

  Future<List<ServiceSubFamily>> getByFamilyId(String familyId,
      {bool eager = false, List<Type> flow = const []});

  Stream<List<ServiceSubFamily>> getByFamilyIdAsStream(String familyId,
      {bool eager = false, List<Type> flow = const []});

  Future<List<ServiceSubFamily>> getAll();

  Future<void> startSyncAll({int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class ServiceSubFamilyService extends AbstractModelService<
    ServiceSubFamily,
    $ServiceSubFamiliesTable,
    AgencyDatabase> implements ServiceSubFamilyServiceInterface {
  ServiceSubFamilyService()
      : super(getIt<ServiceSubFamilyDriftDao>(),
            getIt<ServiceSubFamilyFirestoreDao>());

  // Methods:-------------------------------------------------------------------
  @override
  Future<ServiceSubFamily?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    ServiceSubFamily? serviceSubFamily = await super.getById(id);
    if (eager && serviceSubFamily != null) {
      await serviceSubFamily.loadData(eager: eager, flow: flow);
    }
    return Future.value(serviceSubFamily);
  }

  @override
  Future<List<ServiceSubFamily>> getByFamilyId(String familyId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<ServiceSubFamily> serviceSubFamilies =
        await (localDao as ServiceSubFamilyDriftDao).findByFamilyId(familyId);

    if (eager) {
      for (int i = 0; i < serviceSubFamilies.length; i++) {
        await serviceSubFamilies[i].loadData(eager: eager, flow: flow);
      }
    }

    return serviceSubFamilies;
  }

  @override
  Stream<List<ServiceSubFamily>> getByFamilyIdAsStream(String familyId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<ServiceSubFamily>> serviceSubFamiliesStream =
        (localDao as ServiceSubFamilyDriftDao)
            .findByFamilyIdAsStream(familyId)
            .transform(streamTransformerUtils
                .getListResultDriftStreamOptimizer<ServiceSubFamily>());
    if (eager) {
      serviceSubFamiliesStream =
          serviceSubFamiliesStream.asyncMap((serviceSubFamilies) async {
        for (int i = 0; i < serviceSubFamilies.length; i++) {
          await serviceSubFamilies[i].loadData(eager: eager, flow: flow);
        }
        return serviceSubFamilies;
      });
    }

    return serviceSubFamiliesStream;
  }

  @override
  Future<List<ServiceSubFamily>> getByDiscountCodeId(String discountCodeId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<ServiceSubFamily> serviceSubFamilies =
        await (localDao as ServiceSubFamilyDriftDao)
            .findByDiscountCodeId(discountCodeId);
    if (eager) {
      for (int i = 0; i < serviceSubFamilies.length; i++) {
        await serviceSubFamilies[i].loadData(eager: eager, flow: flow);
      }
    }
    return serviceSubFamilies;
  }
}
