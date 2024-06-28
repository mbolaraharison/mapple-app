import 'package:firebase_auth/firebase_auth.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'reset_password_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ResetPasswordStoreInterface {
  ResetPasswordStoreInterface._(
    this.newPassword,
    this.confirmPassword,
    this.loading,
  );
  // Variables
  String newPassword;
  String confirmPassword;
  bool loading;
  String? code;

  // Computed
  bool get canResetPassword;

  // Methods
  void setNewPassword(String value);
  void setConfirmPassword(String value);
  void setLoading(bool value);
  Future<void> setCode(String value);
  Future<void> resetPassword();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ResetPasswordStore = _ResetPasswordStoreBase with _$ResetPasswordStore;

abstract class _ResetPasswordStoreBase
    with Store
    implements ResetPasswordStoreInterface {
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$';

  // store variables:-----------------------------------------------------------
  @override
  @observable
  String newPassword = '';

  @override
  @observable
  String confirmPassword = '';

  @override
  @observable
  bool loading = true;

  @override
  @observable
  String? code;

  // computed:------------------------------------------------------------------
  @override
  @computed
  bool get canResetPassword =>
      newPassword.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      newPassword == confirmPassword;

  // actions:-------------------------------------------------------------------
  @override
  @action
  void setNewPassword(String value) {
    newPassword = value;
  }

  @override
  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @override
  @action
  void setLoading(bool value) {
    loading = value;
  }

  @override
  @action
  Future<void> setCode(String value) async {
    if (value == code) return;
    code = value;
    try {
      await FirebaseAuth.instance.verifyPasswordResetCode(code!);
      loading = false;
    } on FirebaseAuthException catch (e) {
      throw ResetPasswordException(e.code);
    }
  }

  @override
  @action
  Future<void> resetPassword() async {
    validateNewPassword();
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: code!,
        newPassword: newPassword,
      );
    } on FirebaseAuthException catch (e) {
      throw ResetPasswordException(e.code);
    }
  }

  // methods:-------------------------------------------------------------------
  void validateNewPassword() {
    if (!RegExp(passwordRegex).hasMatch(newPassword)) {
      throw ResetPasswordException('weak-password');
    }
  }
}
