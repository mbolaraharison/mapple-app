import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class PriceListItemServiceInterface {
  Future<PriceListItem?> getById(String id,
      {bool eager = false, List<Type> flow = const []});
  Future<List<PriceListItem>> getByPriceListId(String priceListId,
      {bool eager = false, List<Type> flow = const []});
  Future<PriceListItemResult> findOneByServiceAndOptions(
    Service service,
    ServiceOptionItem? option1,
    ServiceOptionItem? option2,
    num quantity,
  );
  Future<List<PriceListItem>> getAllByAgencyIdOrNullAgencyId(String agencyId);
  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100});
  Future<void> stopSync();
  Future<void> deleteAll({bool applyToFirestore = true});
}

// Types:-----------------------------------------------------------------------
class PriceListItemResult {
  PriceListItem? defaultPriceListItem;
  PriceListItem? alternativePriceListItem;
}

// Implementation:--------------------------------------------------------------
class PriceListItemService extends AbstractModelService<
    PriceListItem,
    $PriceListItemsTable,
    AgencyDatabase> implements PriceListItemServiceInterface {
  PriceListItemService()
      : super(
            getIt<PriceListItemDriftDao>(), getIt<PriceListItemFirestoreDao>());

  // DAO:------------------------------------------------------------------------
  final PriceListServiceInterface _priceListService =
      getIt<PriceListServiceInterface>();

  @override
  Future<PriceListItem?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    PriceListItem? priceListItem = await super.getById(id);
    if (eager && priceListItem != null) {
      await priceListItem.loadData(eager: eager, flow: flow);
    }
    return Future.value(priceListItem);
  }

  // Methods:-------------------------------------------------------------------
  @override
  Future<PriceListItemResult> findOneByServiceAndOptions(
    Service service,
    ServiceOptionItem? option1,
    ServiceOptionItem? option2,
    num quantity,
  ) async {
    final List<PriceList> priceLists =
        await _priceListService.getByService(service);
    final result = PriceListItemResult();

    for (final PriceList priceList in priceLists) {
      final List<PriceListItem> priceListItems =
          await (localDao as PriceListItemDriftDao)
              .findByPriceListId(priceList.id);
      final List<PriceListItem> filteredListItems =
          priceListItems.where((item) {
        if (priceList.priceListType == PriceListType.T02) {
          return item.option1Id == option1?.id;
        } else if (priceList.priceListType == PriceListType.T03) {
          return item.option1Id == option1?.id && item.option2Id == option2?.id;
        } else {
          return true;
        }
      }).toList();

      final PriceListItem? priceListItem = filteredListItems.firstWhereOrNull(
        (item) => quantity >= item.minQuantity && quantity < item.maxQuantity,
      );

      // If price list item found and result is empty (no price list item found yet)
      if (priceListItem != null && result.defaultPriceListItem == null) {
        result.defaultPriceListItem = priceListItem;
      }

      // Check for package price
      final PriceListItem? packagePriceListItem =
          filteredListItems.firstWhereOrNull(
        (item) => item.unit == PriceListItem.packageUnit,
      );

      // If package price found and result is empty (no price list item found yet)
      // -> set package price as result and search for alternative price list item
      if (packagePriceListItem != null && result.defaultPriceListItem == null) {
        result.defaultPriceListItem = packagePriceListItem;

        // The alternative price list item is the price list item with min quantity lower
        PriceListItem? alternativePriceListItem;
        for (final PriceListItem item in filteredListItems) {
          if (item.unit == PriceListItem.packageUnit) {
            continue;
          }
          if (alternativePriceListItem == null) {
            alternativePriceListItem = item;
          } else if (item.minQuantity < alternativePriceListItem.minQuantity) {
            alternativePriceListItem = item;
          }
        }
        result.alternativePriceListItem = alternativePriceListItem;
      } else if (packagePriceListItem != null &&
          result.defaultPriceListItem != null) {
        // If package price found and result is not empty (price list item found)
        // -> set package price as alternative price list item
        result.alternativePriceListItem = packagePriceListItem;
      }

      if (result.defaultPriceListItem != null &&
          result.alternativePriceListItem != null) {
        break;
      }
    }

    return Future.value(result);
  }

  @override
  Future<List<PriceListItem>> getByPriceListId(String priceListId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<PriceListItem> priceListItems =
        await (localDao as PriceListItemDriftDao)
            .findByPriceListId(priceListId);
    if (eager) {
      for (int i = 0; i < priceListItems.length; i++) {
        await priceListItems[i].loadData(eager: eager, flow: flow);
      }
    }
    return Future.value(priceListItems);
  }

  Stream<List<PriceListItem>> getByPriceListIdAsStream(String priceListId) {
    return (localDao as PriceListItemDriftDao)
        .findByPriceListIdAsStream(priceListId);
  }
}
