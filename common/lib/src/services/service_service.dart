import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceServiceInterface {
  search(String query, {bool eager = false, List<Type> flow = const []});

  searchAsStream(String query,
      {bool eager = false, List<Type> flow = const []});

  Future<Service?> getById(String id,
      {bool eager = false, List<Type> flow = const []});

  Stream<Service?> getByIdAsStream(String id, {bool eager = false});

  Future<List<Service>> getByDiscountCodeId(String discountCodeId,
      {bool eager = false, List<Type> flow = const []});

  Future<List<Service>> getBySubFamilyId(String subFamilyId);

  Future<List<Service>> getAllActiveByFamilyId(String familyId,
      {bool eager = false, List<Type> flow = const []});

  Stream<List<Service>> getAllActiveByFamilyIdAsStream(String familyId,
      {bool eager = false, List<Type> flow = const []});

  Future<List<Service>> getAllByAgencyIdOrNullAgencyId(String agencyId);

  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class ServiceService
    extends AbstractModelService<Service, $ServicesTable, AgencyDatabase>
    implements ServiceServiceInterface {
  ServiceService()
      : super(getIt<ServiceDriftDao>(), getIt<ServiceFirestoreDao>());

  // Methods:-------------------------------------------------------------------
  @override
  Future<List<Service>> search(String query,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Service> services = await (localDao as ServiceDriftDao).search(query);
    if (eager) {
      for (int i = 0; i < services.length; i++) {
        await services[i].loadData(eager: eager, flow: flow);
      }
    }
    return services;
  }

  @override
  Stream<List<Service>> searchAsStream(String query,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Service>> servicesStream =
        (localDao as ServiceDriftDao).searchAsStream(query);

    if (eager) {
      servicesStream = servicesStream.asyncMap((services) async {
        for (int i = 0; i < services.length; i++) {
          await services[i].loadData(eager: eager, flow: flow);
        }
        return services;
      });
    }

    return servicesStream;
  }

  @override
  Future<Service?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    Service? service = await super.getById(id);
    if (eager && service != null) {
      await service.loadData(eager: eager, flow: flow);
    }
    return Future.value(service);
  }

  @override
  Future<List<Service>> getBySubFamilyId(String subFamilyId) async {
    return Future.value(
        (localDao as ServiceDriftDao).findBySubFamilyId(subFamilyId));
  }

  @override
  Future<List<Service>> getAllActiveByFamilyId(String familyId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Service> services =
        await (localDao as ServiceDriftDao).findAllActiveByFamilyId(familyId);
    if (eager) {
      for (int i = 0; i < services.length; i++) {
        await services[i].loadData(eager: eager, flow: flow);
      }
    }
    return services;
  }

  @override
  Stream<List<Service>> getAllActiveByFamilyIdAsStream(String familyId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Service>> servicesStream = (localDao as ServiceDriftDao)
        .findAllActiveByFamilyIdAsStream(familyId)
        .transform(streamTransformerUtils
            .getListResultDriftStreamOptimizer<Service>());

    if (eager) {
      servicesStream = servicesStream.asyncMap((services) async {
        for (int i = 0; i < services.length; i++) {
          await services[i].loadData(eager: eager, flow: flow);
        }
        return services;
      });
    }

    return servicesStream;
  }

  Stream<List<Service>> getAllActiveBySubFamilyIdAsStream(String subFamilyId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Service>> servicesStream = (localDao as ServiceDriftDao)
        .findAllActiveBySubFamilyIdAsStream(subFamilyId);

    if (eager) {
      servicesStream = servicesStream.asyncMap((services) async {
        for (int i = 0; i < services.length; i++) {
          await services[i].loadData(eager: eager, flow: flow);
        }
        return services;
      });
    }

    return servicesStream;
  }

  @override
  Future<List<Service>> getByDiscountCodeId(String discountCodeId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Service> services = await (localDao as ServiceDriftDao)
        .findByDiscountCodeId(discountCodeId);
    if (eager) {
      for (int i = 0; i < services.length; i++) {
        await services[i].loadData(eager: eager, flow: flow);
      }
    }
    return services;
  }

  Stream<List<Service>> getByDiscountCodeIdAsStream(String discountCodeId) {
    return (localDao as ServiceDriftDao)
        .findByDiscountCodeIdAsStream(discountCodeId);
  }
}
