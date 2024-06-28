import 'package:mobx/mobx.dart';

part 'account_reset_password_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountResetPasswordStoreInterface {
  AccountResetPasswordStoreInterface._(
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  );

  // Variables
  String currentPassword;
  String newPassword;
  String confirmPassword;

  // Computed
  bool get canUpdate;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class AccountResetPasswordStore = _AccountResetPasswordStore
    with _$AccountResetPasswordStore;

abstract class _AccountResetPasswordStore
    with Store
    implements AccountResetPasswordStoreInterface {
  @override
  @observable
  String currentPassword = '';

  @override
  @observable
  String newPassword = '';

  @override
  @observable
  String confirmPassword = '';

  @override
  @computed
  bool get canUpdate {
    return currentPassword != '' &&
        newPassword != '' &&
        confirmPassword != '' &&
        newPassword == confirmPassword;
  }
}
