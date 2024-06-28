import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class FairServiceInterface {
  Future<Fair?> getById(String id);

  Future<Fair?> getByIdFromFirestore(String id);

  Future<Fair?> getFirstActiveByAgencyIdFromFirestore(String agencyId);

  Future<Fair?> getCurrent();

  Stream<Fair?> getCurrentAsStream();

  Future<void> setCurrentById(String id);

  Future<List<Fair>> getAll();

  Stream<List<Fair>> getAllAsStream();

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class FairService
    extends AbstractModelService<Fair, $FairsTable, AgencyDatabase>
    implements FairServiceInterface {
  FairService() : super(getIt<FairDriftDao>(), getIt<FairFirestoreDao>());
  // Dao:-------------------------------------------------------------------------
  final LocalDbUtilsInterface _localDbUtils =
      getIt.get<LocalDbUtilsInterface>();

  // Services:--------------------------------------------------------------------
  late final AgencyServiceInterface _agencyService =
      getIt.get<AgencyServiceInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<List<Fair>> getAll() async {
    final currentAgency = await _agencyService.getCurrent();
    if (currentAgency == null) {
      return Future.value([]);
    }

    return (remoteDao as FairFirestoreDao).getAllByAgencyId(currentAgency.id);
  }

  @override
  Future<Fair?> getCurrent() async {
    return (localDao as FairDriftDao).findCurrent();
  }

  @override
  Stream<Fair?> getCurrentAsStream() {
    return (localDao as FairDriftDao).findCurrentAsStream().transform(
        streamTransformerUtils.getSingleResultDriftStreamOptimizer<Fair>());
  }

  @override
  Future<void> setCurrentById(String id) async {
    Fair? fair = await localDao.findById(id);
    if (fair != null) {
      await setCurrent(fair);
    }
  }

  Future<void> createOrUpdate(Fair fair, {bool applyToFirestore = true}) async {
    // set current
    fair = await setCurrent(fair) as Fair;
    await super.create(fair, applyToFirestore: true);
    // set if current
    final String? fairId =
        await _localDbUtils.get(Representative.currentFairIdKey);
    if (fairId != null && fairId == fair.id) {
      await setCurrent(fair);
    }
  }

  @override
  Future<void> update(Fair item, {bool applyToFirestore = true}) async {
    await super.update(item, applyToFirestore: applyToFirestore);
    // set if current
    final String? fairId =
        await _localDbUtils.get(Representative.currentFairIdKey);
    if (fairId != null && fairId == item.id) {
      await setCurrent(item);
    }
  }

  Future<void> deleteAndRemoveFromLocalDb(Fair fair) async {
    await delete(fair, applyToFirestore: true);
    final String? fairId =
        await _localDbUtils.get(Representative.currentFairIdKey);
    if (fairId != null && fairId == fair.id) {
      await _localDbUtils.delete(Representative.currentFairIdKey);
    }
  }

  Future<void> setCurrent(Fair newCurrentFair) async {
    // get last current => set isCurrent to false
    final String? fairId =
        await _localDbUtils.get(Representative.currentFairIdKey);
    if (fairId != null && fairId != newCurrentFair.id) {
      Fair? fair = await localDao.findById(fairId);
      if (fair != null) {
        fair.isCurrent = false;
        await localDao.daoUpdate(fair);
      }
    }
    // set new current
    // check if new current is valid
    if (newCurrentFair.isValid) {
      await _localDbUtils.put(
          Representative.currentFairIdKey, newCurrentFair.id);
      newCurrentFair.isCurrent = true;
      await localDao.daoUpdate(newCurrentFair);
    } else {
      await _localDbUtils.delete(Representative.currentFairIdKey);
      newCurrentFair.isCurrent = false;
      await localDao.daoUpdate(newCurrentFair);
    }
  }

  @override
  Future<Fair?> getByIdFromFirestore(String id) async {
    return (remoteDao as FairFirestoreDao).getById(id);
  }

  @override
  Future<Fair?> getFirstActiveByAgencyIdFromFirestore(String agencyId) async {
    List<Fair> fairs =
        await (remoteDao as FairFirestoreDao).getAllByAgencyId(agencyId);
    if (fairs.isEmpty) {
      return null;
    }
    return fairs.firstWhereOrNull((element) => element.isValid);
  }

  @override
  Future<void> onDataChange(List<DocumentChange<Fair>> changes,
      {int batchSize = 100}) async {
    for (var change in changes) {
      final doc = change.doc;
      final data = doc.data() as Fair;
      switch (change.type) {
        case DocumentChangeType.added:
          await _createSync(data);
          break;
        case DocumentChangeType.modified:
          await _updateSync(data);
          break;
        case DocumentChangeType.removed:
          await _deleteSync(data);
          break;
      }
    }
  }

  Future<void> _createSync(Fair fair) async {
    await localDao.daoCreateOrUpdate(fair);
    // set if current
    final String? fairId =
        await _localDbUtils.get(Representative.currentFairIdKey);
    if (fairId != null && fairId == fair.id) {
      await setCurrent(fair);
    }
  }

  Future<void> _updateSync(Fair fair) async {
    await localDao.daoUpdate(fair);
    // set if current
    final String? fairId =
        await _localDbUtils.get(Representative.currentFairIdKey);
    if (fairId != null && fairId == fair.id) {
      await setCurrent(fair);
    }
  }

  Future<void> _deleteSync(Fair fair) async {
    await localDao.daoDelete(fair);
    // set if current
    final String? fairId =
        await _localDbUtils.get(Representative.currentFairIdKey);
    if (fairId != null && fairId == fair.id) {
      await _localDbUtils.delete(Representative.currentFairIdKey);
    }
  }
}
