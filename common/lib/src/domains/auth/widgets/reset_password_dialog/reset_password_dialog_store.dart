import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'reset_password_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ResetPasswordDialogStoreInterface {
  ResetPasswordDialogStoreInterface._(this.email);
  // Variables
  String email;

  // Methods
  void setEmail(String value);
  Future<void> resetPassword();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ResetPasswordDialogStore = _ResetPasswordDialogStoreBase
    with _$ResetPasswordDialogStore;

abstract class _ResetPasswordDialogStoreBase
    with Store
    implements ResetPasswordDialogStoreInterface {
  // store variables:-----------------------------------------------------------
  @override
  @observable
  String email = '';

  // actions:-------------------------------------------------------------------
  @override
  @action
  void setEmail(String value) {
    email = value;
  }

  @override
  @action
  Future<void> resetPassword() async {
    try {
      final actionCodeSettings = ActionCodeSettings(
        url: dotenv.env['RESET_PASSWORD_URL']!,
        handleCodeInApp: true,
        iOSBundleId: 'com.mistertoiture.app',
        dynamicLinkDomain: dotenv.env['FIREBASE_DYNAMICS_LINKS_DOMAIN']!,
      );
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
    } on FirebaseAuthException catch (e) {
      throw ResetPasswordException(e.code);
    }
  }
}
