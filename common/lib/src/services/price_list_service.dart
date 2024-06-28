import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class PriceListServiceInterface {
  Future<PriceList?> getById(String id,
      {bool eager = false, List<Type> flow = const []});

  Future<List<PriceList>> getByService(Service service);

  Future<List<PriceList>> getAllByAgencyIdOrNullAgencyId(String agencyId);

  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class PriceListService
    extends AbstractModelService<PriceList, $PriceListsTable, AgencyDatabase>
    implements PriceListServiceInterface {
  PriceListService()
      : super(getIt<PriceListDriftDao>(), getIt<PriceListFirestoreDao>());

  // DAO:------------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<PriceList?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    PriceList? priceList = await super.getById(id);
    if (eager && priceList != null) {
      await priceList.loadData(eager: eager, flow: flow);
    }
    return Future.value(priceList);
  }

  @override
  Future<List<PriceList>> getByService(Service service) async {
    // Get current representative:
    final Representative? currentRep =
        await _representativeService.getCurrent();
    if (currentRep == null) {
      return Future.value([]);
    }
    List<PriceList> priceLists = await (localDao as PriceListDriftDao)
        .findCurrentByAgencyIdAndServiceId(currentRep.agencyId, service.id);
    priceLists.sort((a, b) {
      if (a.priority == b.priority) {
        if (a.agencyId == null) {
          return 1;
        } else if (b.agencyId == null) {
          return -1;
        } else {
          return 0;
        }
      } else {
        return a.priority.compareTo(b.priority);
      }
    });

    return Future.value(priceLists);
  }
}
