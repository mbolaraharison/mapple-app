import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AgencyServiceInterface {
  Future<Agency?> getCurrent();

  Stream<Agency?> getCurrentAsStream();

  Future<List<Agency>> getAllByEmail(String email,
      {List<Role>? roles, bool hasAccessToAppraisalModule = false});

  Stream<List<Agency>> getAllByEmailAsStream(String email,
      {List<Role>? roles, bool hasAccessToAppraisalModule = false});

  Future<Agency?> getById(String id);

  Future<Agency?> getByIdFromFirestore(String id);

  Future<String> getOrderFormIdAndIncrement(String id);

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class AgencyService
    extends AbstractModelService<Agency, $AgenciesTable, AgencyDatabase>
    implements AgencyServiceInterface {
  AgencyService() : super(getIt<AgencyDriftDao>(), getIt<AgencyFirestoreDao>());
  // Services:------------------------------------------------------------------
  late final RepresentativeFirestoreDao _representativeFirestoreDao =
      getIt<RepresentativeFirestoreDao>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<Agency?> getCurrent() async {
    return localDao.findFirst();
  }

  @override
  Stream<Agency?> getCurrentAsStream() {
    return localDao.findFirstAsStream().transform(
        streamTransformerUtils.getSingleResultDriftStreamOptimizer<Agency>());
  }

  @override
  Future<List<Agency>> getAllByEmail(String email,
      {List<Role>? roles, bool hasAccessToAppraisalModule = false}) async {
    List<Representative> reps =
        await _representativeFirestoreDao.getAllByEmail(email, roles: roles);

    final futures = <Future<List<Agency>>>[];
    for (int i = 0; i < reps.length; i += 10) {
      List<Representative> repsChunk =
          reps.sublist(i, i + 10 > reps.length ? reps.length : i + 10);
      List<String> agencyIds = repsChunk.map((e) => e.agencyId).toList();
      Future<List<Agency>> future = hasAccessToAppraisalModule == false
          ? (remoteDao as AgencyFirestoreDao).getByIds(agencyIds)
          : (remoteDao as AgencyFirestoreDao)
              .getAllThatHaveAccessToAppraisalModuleByIds(agencyIds);
      futures.add(future);
    }

    return await Future.wait(futures).then((List<List<Agency>> agenciesList) {
      return agenciesList.expand((element) => element).toList();
    });
  }

  @override
  Stream<List<Agency>> getAllByEmailAsStream(String email,
      {List<Role>? roles, bool hasAccessToAppraisalModule = false}) {
    Stream<List<Representative>> repsStream =
        _representativeFirestoreDao.getAllByEmailAsStream(email, roles: roles);

    return repsStream.asyncMap((List<Representative> reps) async {
      final futures = <Future<List<Agency>>>[];
      for (int i = 0; i < reps.length; i += 10) {
        List<Representative> repsChunk =
            reps.sublist(i, i + 10 > reps.length ? reps.length : i + 10);
        List<String> agencyIds = repsChunk.map((e) => e.agencyId).toList();
        Future<List<Agency>> future = hasAccessToAppraisalModule == false
            ? (remoteDao as AgencyFirestoreDao).getByIds(agencyIds)
            : (remoteDao as AgencyFirestoreDao)
                .getAllThatHaveAccessToAppraisalModuleByIds(agencyIds);
        futures.add(future);
      }
      return await Future.wait(futures).then((List<List<Agency>> agenciesList) {
        return agenciesList.expand((element) => element).toList();
      });
    });
  }

  @override
  Future<Agency?> getByIdFromFirestore(String id) async {
    return remoteDao.getById(id);
  }

  @override
  Future<String> getOrderFormIdAndIncrement(String id) async {
    DocumentReference<Agency> agencyRef = remoteDao.collection.doc(id);
    final orderFormNumber = await (remoteDao as AgencyFirestoreDao)
        .getOrderFormNumberAndIncrement(agencyRef);
    final Agency agency = await agencyRef.get().then((value) => value.data()!);
    return agency.sageId + orderFormNumber.toString().padLeft(5, '0');
  }

  @override
  Future<void> startSyncByAgencyId(
      {String? agencyId, int batchSize = 100}) async {
    agencySubscription?.cancel();
    final Completer<void> completer = Completer<void>();
    bool isFutureResolved = false;
    DocumentReference docRef = remoteDao.collection.doc(agencyId);

    agencySubscription = docRef.snapshots().listen((event) async {
      if (event.exists) {
        final Agency agency = event.data() as Agency;
        await localDao.daoCreateOrUpdate(agency);
      } else {
        await localDao.daoDeleteAll();
      }

      if (!isFutureResolved) {
        isFutureResolved = true;
        completer.complete();
      }
    });

    await completer.future;
  }
}
