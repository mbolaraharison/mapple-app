import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'sync_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class SyncStoreInterface {
  SyncStoreInterface._();

  // Store variables:-----------------------------------------------------------
  bool get isOk;
  IntegrityJobModel? integrityJobModel;

  // Methods:-------------------------------------------------------------------
  void setIsOk(bool value, {IntegrityJobModel? integrityJobModel});
  void cancel();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class SyncStore = _SyncStore with _$SyncStore;

abstract class _SyncStore with Store implements SyncStoreInterface {
  // Dependencies:--------------------------------------------------------------
  late final IntegrityJobFirestoreDao _integrityJobFirestoreDao =
      getIt<IntegrityJobFirestoreDao>();
  late final AgencyDatabase _agencyDatabase = getIt<AgencyDatabase>();
  late final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  bool isOk = true;

  @override
  @observable
  IntegrityJobModel? integrityJobModel;

  StreamSubscription<DocumentSnapshot<IntegrityJobModel>>? _jobSubscription;

  // Methods:-------------------------------------------------------------------
  @override
  @action
  void setIsOk(bool value, {IntegrityJobModel? integrityJobModel}) {
    cancel();
    isOk = value;
    this.integrityJobModel = integrityJobModel;

    if (integrityJobModel != null) {
      _listenToJob();
    }
  }

  @override
  @action
  void cancel() {
    _jobSubscription?.cancel();
    integrityJobModel = null;
  }

  @action
  void _listenToJob() {
    if (integrityJobModel == null) {
      return;
    }
    _jobSubscription = _integrityJobFirestoreDao
        .getSnapshots(integrityJobModel!)
        .listen((snapshot) async {
      integrityJobModel = snapshot.data();

      if (!integrityJobModel!.isPending) {
        _jobSubscription?.cancel();
      }

      if (integrityJobModel!.isSuccess) {
        await _agencyDatabase.load(
          email: _authStore.currentUser!.email!,
          agencyId: integrityJobModel!.agencyId,
        );
      }
    });
  }
}
