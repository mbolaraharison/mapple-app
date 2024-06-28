import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DiscountCodeServiceInterface {
  Future<void> create(DiscountCode item,
      {bool applyToFirestore = true, bool onlyToFirestore = false});

  Future<DiscountCode?> getById(String id,
      {bool eager = false, List<Type> flow = const []});

  Future<DiscountCode?> getByCode(String code, DateTime date);

  Stream<List<DiscountCode>> getAvailableAsStream(DateTime date,
      {bool eager = false, List<Type> flow = const []});

  Future<String> generateCode(String agencyId);

  Future<bool> isCodeAvailable({
    required String code,
    required String agencyId,
    DiscountCode? discountCode,
  });

  Future<void> update(DiscountCode item, {bool applyToFirestore = true});

  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});

  Future<void> delete(DiscountCode item, {bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class DiscountCodesService extends AbstractModelService<
    DiscountCode,
    $DiscountCodesTable,
    AgencyDatabase> implements DiscountCodeServiceInterface {
  DiscountCodesService()
      : super(getIt<DiscountCodeDriftDao>(), getIt<DiscountCodeFirestoreDao>());

  // Dao:-------------------------------------------------------------------------
  final DiscountCodeServiceDriftDao _discountCodeServiceDao =
      getIt<DiscountCodeServiceDriftDao>();
  final DiscountCodeServiceFamilyDriftDao _discountCodeServiceFamilyDao =
      getIt<DiscountCodeServiceFamilyDriftDao>();
  final DiscountCodeServiceSubFamilyDriftDao _discountCodeServiceSubFamilyDao =
      getIt<DiscountCodeServiceSubFamilyDriftDao>();

  // Methods:-------------------------------------------------------------------
  @override
  Stream<List<DiscountCode>> getAvailableAsStream(DateTime date,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<DiscountCode>> discountCodesStream =
        (localDao as DiscountCodeDriftDao).findAvailableAsStream(date);

    if (eager) {
      discountCodesStream = discountCodesStream.asyncMap((discountCodes) async {
        for (int i = 0; i < discountCodes.length; i++) {
          await discountCodes[i].loadData(eager: eager, flow: flow);
        }
        return discountCodes;
      });
    }

    return discountCodesStream.transform(streamTransformerUtils
        .getListResultDriftStreamOptimizer<DiscountCode>());
  }

  @override
  Future<DiscountCode?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    final discountCode = await super.getById(id);
    if (discountCode != null && eager) {
      await discountCode.loadData(eager: eager, flow: flow);
    }
    return discountCode;
  }

  @override
  Future<void> create(DiscountCode item,
      {bool applyToFirestore = true, bool onlyToFirestore = false}) async {
    await super.create(item,
        applyToFirestore: applyToFirestore, onlyToFirestore: onlyToFirestore);
    await localDao.batch(
      (batch) {
        batch = _syncRelationships(batch, item);
      },
    );
  }

  @override
  Future<void> update(DiscountCode item, {bool applyToFirestore = true}) async {
    await super.update(item, applyToFirestore: applyToFirestore);
    await localDao.batch(
      (batch) {
        batch = _syncRelationships(batch, item);
      },
    );
  }

  @override
  Future<void> delete(DiscountCode item,
      {bool applyToFirestore = true, final bool softDelete = true}) async {
    await localDao.batch(
      (batch) {
        batch = _deleteRelationships(batch, item);
      },
    );
    await super
        .delete(item, applyToFirestore: applyToFirestore, softDelete: true);
  }

  @override
  Future<bool> isCodeAvailable({
    required String code,
    required String agencyId,
    DiscountCode? discountCode,
  }) async {
    return (remoteDao as DiscountCodeFirestoreDao).isCodeAvailable(
      code: code,
      agencyId: agencyId,
      discountCode: discountCode,
    );
  }

  @override
  Future<DiscountCode?> getByCode(String code, DateTime date) async {
    return (localDao as DiscountCodeDriftDao).findByCode(code, date);
  }

  @override
  Future<String> generateCode(String agencyId) async {
    return (remoteDao as DiscountCodeFirestoreDao).generateCode(agencyId);
  }

  @override
  Future<void> onDataChange(List<DocumentChange<DiscountCode>> changes,
      {int batchSize = 100}) async {
    final futures = <Future>[];
    for (int i = 0; i < changes.length; i += batchSize) {
      final endIndex = min(i + batchSize, changes.length);
      final batchDocChanges = changes.sublist(i, endIndex);

      // batch firestore
      final batchFuture = localDao.batch((batch) {
        for (var change in batchDocChanges) {
          final doc = change.doc;
          final data = doc.data() as DiscountCode;
          switch (change.type) {
            case DocumentChangeType.added:
              batch = _createSync(batch, data);
              break;
            case DocumentChangeType.modified:
              batch = _updateSync(batch, data);
              break;
            case DocumentChangeType.removed:
              batch = _deleteSync(batch, data);
              break;
          }
        }
      });

      futures.add(batchFuture);
    }

    await Future.wait(futures);
  }

  Batch _createSync(Batch batch, DiscountCode discountCode) {
    batch = localDao.daoBatchCreateOrUpdate(batch, discountCode);
    batch = _syncRelationships(batch, discountCode);
    return batch;
  }

  Batch _updateSync(Batch batch, DiscountCode discountCode) {
    batch = localDao.daoBatchUpdate(batch, discountCode);
    batch = _syncRelationships(batch, discountCode);
    return batch;
  }

  Batch _deleteSync(Batch batch, DiscountCode discountCode) {
    batch = _deleteRelationships(batch, discountCode);
    batch = localDao.daoBatchDelete(batch, discountCode);
    return batch;
  }

  Batch _syncRelationships(Batch batch, DiscountCode discountCode) {
    batch = _deleteRelationships(batch, discountCode);

    // Create services, families and subfamilies
    for (var serviceId in discountCode.serviceIds) {
      batch = _discountCodeServiceDao.daoBatchCreate(
          batch,
          DiscountCodeService(
              discountCodeId: discountCode.id, serviceId: serviceId));
    }
    for (var serviceFamilyId in discountCode.familyIds) {
      batch = _discountCodeServiceFamilyDao.daoBatchCreate(
          batch,
          DiscountCodeServiceFamily(
              discountCodeId: discountCode.id,
              serviceFamilyId: serviceFamilyId));
    }
    for (var serviceSubFamilyId in discountCode.subFamilyIds) {
      batch = _discountCodeServiceSubFamilyDao.daoBatchCreate(
          batch,
          DiscountCodeServiceSubFamily(
              discountCodeId: discountCode.id,
              serviceSubFamilyId: serviceSubFamilyId));
    }
    return batch;
  }

  Batch _deleteRelationships(Batch batch, DiscountCode discountCode) {
    batch = _discountCodeServiceDao.batchDeleteByDiscountCodeId(
        batch, discountCode.id);
    batch = _discountCodeServiceFamilyDao.batchDeleteByDiscountCodeId(
        batch, discountCode.id);
    batch = _discountCodeServiceSubFamilyDao.batchDeleteByDiscountCodeId(
        batch, discountCode.id);
    return batch;
  }
}
