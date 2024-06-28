import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class AuthStoreInterface {
  AuthStoreInterface._(this.isLoading);

  User? currentUser;

  bool get isLoggedIn;

  bool isLoading;

  Future<void> logout();

  bool setIsLoading(bool value);

  void initAuthListener();

  void deleteKeysFromLocalDb();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store implements AuthStoreInterface {
  // constructor:---------------------------------------------------------------
  _AuthStore() {
    initAuthListener();
  }

  // Services:------------------------------------------------------------------
  late final LocalDbUtilsInterface _localDbUtils =
      getIt.get<LocalDbUtilsInterface>();

  // store variables:-----------------------------------------------------------
  @override
  @observable
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  @computed
  bool get isLoggedIn => currentUser != null;

  @override
  @observable
  bool isLoading = false;

  // actions:-------------------------------------------------------------------
  @override
  @action
  Future<void> logout() async {
    try {
      deleteKeysFromLocalDb();
      // Wait end of screen transition
      await Future.delayed(const Duration(milliseconds: 500));
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  @action
  bool setIsLoading(bool value) => isLoading = value;

  // general methods:-----------------------------------------------------------
  @override
  void initAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      setIsLoading(true);
      if (user != null) {
        try {
          await user.getIdToken(true);
          currentUser = user;
          FirebaseCrashlytics.instance.setUserIdentifier(user.uid);
        } catch (e) {
          currentUser = null;
          await FirebaseAuth.instance.signOut();
          rethrow;
        }
      } else {
        currentUser = null;
      }
    });
  }

  @override
  void deleteKeysFromLocalDb() {
    // delete current agency id
    _localDbUtils.delete(Representative.currentAgencyIdKey);
    // delete current fair id
    _localDbUtils.delete(Representative.currentFairIdKey);
  }
}
