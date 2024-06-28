import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';
import 'package:drift/drift.dart';

abstract class AbstractModelService<T extends AbstractBaseModel,
    R extends Table, D extends GeneratedDatabase> {
  AbstractModelService(this.localDao, this.remoteDao);

  // Subscriptions:------------------------------------------------------------
  StreamSubscription? agencySubscription;
  StreamSubscription? globalSubscription;
  StreamSubscription? userSettingSubscription;

  // Dao:-----------------------------------------------------------------------
  final AbstractDriftDao<T, R, D> localDao;
  final AbstractFirestoreDao<T> remoteDao;

  // Stores:--------------------------------------------------------------------
  final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();

  // Utils:-------------------------------------------------------------------
  final StreamTransformerUtilsInterface streamTransformerUtils =
      getIt<StreamTransformerUtilsInterface>();

  // Methods:-------------------------------------------------------------------
  Future<void> create(T item,
      {bool applyToFirestore = true, bool onlyToFirestore = false}) async {
    if (onlyToFirestore == false) {
      // create in sqlite
      await localDao.daoCreate(item);
    }
    if (applyToFirestore == true || onlyToFirestore == true) {
      // create in firestore
      await remoteDao.create(item);
    }
    return Future.value();
  }

  Future<void> update(T item, {bool applyToFirestore = true}) async {
    // update in sqlite
    await localDao.daoUpdate(item);
    if (applyToFirestore) {
      // update in firestore
      await remoteDao.update(item);
    }
    return Future.value();
  }

  Future<T> updateToFirestore(T item) async {
    // update in firestore
    await remoteDao.update(item);
    return item;
  }

  Future<void> delete(T item,
      {bool applyToFirestore = true, bool softDelete = false}) async {
    // delete in sqlite
    if (softDelete) {
      await localDao.daoSoftDelete(item);
    } else {
      await localDao.daoDelete(item);
    }
    if (applyToFirestore) {
      // delete in firestore
      await remoteDao.delete(item);
    }
    return Future.value();
  }

  Future<void> deleteAll({bool applyToFirestore = true}) async {
    // delete all in sqlite
    await localDao.daoDeleteAll();
    // delete all in firestore
    if (applyToFirestore) {
      await remoteDao.deleteAll();
    }
    return Future.value();
  }

  Future<List<T>> getAll() async {
    return localDao.findAll();
  }

  Future<void> startSyncByAgencyId(
      {String? agencyId, int batchSize = 100}) async {
    agencySubscription?.cancel();
    final Completer<void> completer = Completer<void>();
    bool isFutureResolved = false;

    agencySubscription = remoteDao.collection
        .where('agencyId', isEqualTo: agencyId)
        .snapshots()
        .listen((snapshot) async {
      await onDataChange(snapshot.docChanges, batchSize: batchSize);

      if (!isFutureResolved) {
        isFutureResolved = true;
        completer.complete();
      }
    });

    await completer.future;
  }

  Future<List<T>> getAllByAgencyIdOrNullAgencyId(String agencyId) async {
    return localDao.findAllByAgencyIdOrNullAgencyId(agencyId);
  }

  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100}) async {
    globalSubscription?.cancel();
    agencySubscription?.cancel();
    final globalCompleter = Completer<void>();
    final agencyCompleter = Completer<void>();
    bool isGlobalFutureResolved = false;
    bool isAgencyFutureResolved = false;

    globalSubscription = remoteDao.collection
        .where('agencyId', isNull: true)
        .snapshots()
        .listen((snapshot) async {
      await onDataChange(snapshot.docChanges, batchSize: batchSize);

      if (!isGlobalFutureResolved) {
        isGlobalFutureResolved = true;
        globalCompleter.complete();
      }
    });

    agencySubscription = remoteDao.collection
        .where('agencyId', isEqualTo: agencyId)
        .snapshots()
        .listen((snapshot) async {
      await onDataChange(snapshot.docChanges, batchSize: batchSize);

      if (!isAgencyFutureResolved) {
        isAgencyFutureResolved = true;
        agencyCompleter.complete();
      }
    });

    await Future.wait([globalCompleter.future, agencyCompleter.future]);
  }

  Future<void> startSyncAll({int batchSize = 100}) async {
    globalSubscription?.cancel();
    final Completer<void> completer = Completer<void>();
    bool isFutureResolved = false;

    globalSubscription =
        remoteDao.collection.snapshots().listen((snapshot) async {
      await onDataChange(snapshot.docChanges, batchSize: batchSize);

      if (!isFutureResolved) {
        isFutureResolved = true;
        completer.complete();
      }
    });

    await completer.future;
  }

  Future<void> startSyncByCurrentUser({int batchSize = 100}) async {
    userSettingSubscription?.cancel();
    final Completer<void> completer = Completer<void>();
    bool isFutureResolved = false;

    userSettingSubscription = remoteDao.collection
        .where('userId', isEqualTo: _authStore.currentUser?.uid ?? '')
        .snapshots()
        .listen((snapshot) async {
      await onDataChange(snapshot.docChanges, batchSize: batchSize);

      if (!isFutureResolved) {
        isFutureResolved = true;
        completer.complete();
      }
    });

    await completer.future;
  }

  Future<void> onDataChange(List<DocumentChange<T>> changes,
      {int batchSize = 100}) async {
    final futures = <Future>[];
    for (int i = 0; i < changes.length; i += batchSize) {
      final endIndex = min(i + batchSize, changes.length);
      final batchDocChanges = changes.sublist(i, endIndex);

      // batch firestore
      final batchFuture = localDao.batch((batch) {
        for (var change in batchDocChanges) {
          final doc = change.doc;
          final data = doc.data() as T;
          switch (change.type) {
            case DocumentChangeType.added:
              batch = localDao.daoBatchCreateOrUpdate(batch, data);
              break;
            case DocumentChangeType.modified:
              batch = localDao.daoBatchUpdate(batch, data);
              break;
            case DocumentChangeType.removed:
              batch = localDao.daoBatchDelete(batch, data);
              break;
          }
        }
      });

      futures.add(batchFuture);
    }

    await Future.wait(futures);
  }

  Future<void> stopSync() async {
    globalSubscription?.cancel();
    agencySubscription?.cancel();
  }

  Future<T?> getById(String id) async {
    return localDao.findById(id);
  }

  Future<List<T>> getByIds(List<String> ids) async {
    return localDao.findByIds(ids);
  }

  Stream<List<T>> getByIdsAsStream(List<String> ids,
      {bool eager = false, List<Type> flow = const []}) {
    return localDao.findByIdsAsStream(ids).transform(
        streamTransformerUtils.getListResultDriftStreamOptimizer<T>());
  }

  Stream<T?> getByIdAsStream(String id, {bool eager = false}) {
    return localDao.findByIdAsStream(id).transform(
        streamTransformerUtils.getSingleResultDriftStreamOptimizer<T>());
  }

  Stream<List<T>> getAllAsStream() {
    return localDao.findAllAsStream();
  }
}
