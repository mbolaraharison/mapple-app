import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RepresentativeServiceInterface {
  Future<Representative?> getCurrent({bool eager = false});

  Stream<Representative?> getCurrentAsStream({bool eager = false});

  Stream<Representative?> getFirstByEmailByAgencyIdByRolesFromFirestoreAsStream(
      String email, String agencyId, List<Role> roles);

  Future<Representative?> getById(String id, {bool eager = false});

  Future<Representative?> getByIdFromFirestore(String id, {bool eager = false});

  Stream<Representative?> getByIdFromFirestoreAsStream(String id);

  Stream<List<Representative>> getByIdsAsStream(List<String> ids);

  Future<Representative?> getByEmailByAgencyIdFromFirestore(
      String email, String agencyId);

  Future<Representative?> getFirstByEmailFromFirestore(String email);

  Future<List<Representative>> getAll();

  Future<List<Representative>> getActiveAndAvailableToSell();

  Stream<List<Representative>> getSalesRepsByAgencyIdFromFirestoreAsStream(
      String agencyId);

  Future<void> setCurrentIsDirectSale(bool value);

  Future<Representative> setIsDirectSale(Representative item, bool value,
      {bool applyToFirestore = true});

  Future<void> update(Representative item, {bool applyToFirestore = true});

  Future<Representative> updateToFirestore(Representative item);

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class RepresentativeService extends AbstractModelService<
    Representative,
    $RepresentativesTable,
    AgencyDatabase> implements RepresentativeServiceInterface {
  RepresentativeService()
      : super(getIt<RepresentativeDriftDao>(),
            getIt<RepresentativeFirestoreDao>());

  // Dependencies:--------------------------------------------------------------
  final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();
  final LocalDbUtilsInterface _localDbUtils = getIt<LocalDbUtilsInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<void> setCurrentIsDirectSale(bool value) async {
    // update to sqlite
    Representative? current = await getCurrent();
    if (current == null) {
      return Future.value();
    }
    current.isDirectSale = value;
    await super.update(current, applyToFirestore: true);
    return Future.value();
  }

  @override
  Future<Representative> setIsDirectSale(Representative item, bool value,
      {bool applyToFirestore = true}) async {
    item.isDirectSale = value;
    await super.update(item, applyToFirestore: applyToFirestore);
    await _localDbUtils.delete(Representative.currentFairIdKey);
    return item;
  }

  @override
  Stream<Representative?> getCurrentAsStream({bool eager = false}) {
    Stream<Representative?> representativeStream =
        (localDao as RepresentativeDriftDao)
            .findFirstByEmailAsStream(_authStore.currentUser?.email ?? '')
            .transform(streamTransformerUtils
                .getSingleResultDriftStreamOptimizer<Representative>());
    if (eager) {
      representativeStream =
          representativeStream.asyncMap((Representative? representative) async {
        if (representative != null) {
          await representative.loadData();
        }
        return representative;
      });
    }
    return representativeStream;
  }

  @override
  Stream<Representative?> getFirstByEmailByAgencyIdByRolesFromFirestoreAsStream(
      String email, String agencyId, List<Role> roles) {
    return (remoteDao as RepresentativeFirestoreDao)
        .getFirstByEmailAgencyIdByRolesAsStream(email, agencyId, roles);
  }

  @override
  Future<Representative?> getCurrent({bool eager = false}) async {
    Representative? representative = await (localDao as RepresentativeDriftDao)
        .findFirstByEmail(_authStore.currentUser?.email ?? '');
    if (eager && representative != null) {
      await representative.loadData();
    }
    return representative;
  }

  @override
  Future<List<Representative>> getAll() async {
    Representative? currentRepresentative = await getCurrent();
    if (currentRepresentative == null) {
      return Future.value([]);
    }
    Agency? currentAgency = await getIt<AgencyServiceInterface>()
        .getById(currentRepresentative.agencyId);
    if (currentAgency == null) {
      return Future.value([]);
    }
    // Get all reps by agency
    return (remoteDao as RepresentativeFirestoreDao)
        .getAllByAgencyId(currentAgency.id);
  }

  @override
  Future<Representative?> getById(String id, {bool eager = false}) async {
    Representative? representative =
        await (localDao as RepresentativeDriftDao).findById(id);
    if (eager && representative != null) {
      await representative.loadData();
    }
    return representative;
  }

  @override
  Future<Representative?> getByIdFromFirestore(String id,
      {bool eager = false}) async {
    Representative? representative =
        await (remoteDao as RepresentativeFirestoreDao).getById(id);
    if (eager && representative != null) {
      await representative.loadData();
    }
    return representative;
  }

  @override
  Stream<Representative?> getByIdFromFirestoreAsStream(String id) {
    return (remoteDao as RepresentativeFirestoreDao).getByIdAsStream(id);
  }

  @override
  Future<Representative?> getByEmailByAgencyIdFromFirestore(
      String email, String agencyId) async {
    return (remoteDao as RepresentativeFirestoreDao)
        .getByEmailByAgencyId(email, agencyId);
  }

  @override
  Future<Representative?> getFirstByEmailFromFirestore(String email) async {
    return (remoteDao as RepresentativeFirestoreDao).getFirstByEmail(email);
  }

  @override
  Future<List<Representative>> getActiveAndAvailableToSell() async {
    return (localDao as RepresentativeDriftDao).getActiveAndAvailableToSell();
  }

  @override
  Stream<List<Representative>> getSalesRepsByAgencyIdFromFirestoreAsStream(
      String agencyId) {
    return (remoteDao as RepresentativeFirestoreDao)
        .getSalesRepsByAgencyIdAsStream(agencyId);
  }
}
