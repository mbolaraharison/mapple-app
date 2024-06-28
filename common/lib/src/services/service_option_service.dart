import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceOptionServiceInterface {
  Future<List<ServiceOption>> getByServiceId(String serviceId,
      {bool eager = false, List<Type> flow = const []});

  Future<List<ServiceOption>> getAllByAgencyIdOrNullAgencyId(String agencyId);

  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class ServiceOptionService extends AbstractModelService<
    ServiceOption,
    $ServiceOptionsTable,
    AgencyDatabase> implements ServiceOptionServiceInterface {
  ServiceOptionService()
      : super(
            getIt<ServiceOptionDriftDao>(), getIt<ServiceOptionFirestoreDao>());

  // Methods:-------------------------------------------------------------------
  @override
  Future<List<ServiceOption>> getByServiceId(String serviceId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<ServiceOption> serviceOptions =
        await (localDao as ServiceOptionDriftDao).findByServiceId(serviceId);
    if (eager) {
      for (int i = 0; i < serviceOptions.length; i++) {
        await serviceOptions[i].loadData(eager: eager, flow: flow);
      }
    }
    return Future.value(serviceOptions);
  }

  Stream<List<ServiceOption>> getByServiceIdAsStream(String serviceId) {
    return (localDao as ServiceOptionDriftDao)
        .findByServiceIdAsStream(serviceId);
  }
}
