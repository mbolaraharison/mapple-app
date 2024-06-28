import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class LoginStoreInterface {
  LoginStoreInterface._(
    this.email,
    this.password,
    this.success,
    this.loading,
    this.error,
  );

  // Variables
  String email;
  String password;
  bool success;
  bool loading;
  String error;

  // Computed
  bool get canLogin;

  // Methods
  void setEmail(String value);
  void setPassword(String value);
  Future<void> login();
  Future<void> resetPassword(String email);
  void clearError();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store implements LoginStoreInterface {
  // store variables:-----------------------------------------------------------
  @override
  @observable
  String email = '';

  @override
  @observable
  String password = '';

  @override
  @observable
  bool success = false;

  @override
  @observable
  bool loading = false;

  @override
  @observable
  String error = '';

  // computed:------------------------------------------------------------------
  @override
  @computed
  bool get canLogin => email.isNotEmpty && password.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @override
  @action
  void setEmail(String value) {
    email = value;
  }

  @override
  @action
  void setPassword(String value) {
    password = value;
  }

  @override
  @action
  Future<void> login() async {
    loading = true;
    clearError();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      success = true;
    } on FirebaseAuthException catch (e) {
      error = e.code;
    } finally {
      loading = false;
    }
  }

  @override
  @action
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  @action
  void clearError() {
    error = '';
  }
}
