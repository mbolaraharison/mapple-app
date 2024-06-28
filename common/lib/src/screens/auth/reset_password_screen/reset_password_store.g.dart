// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResetPasswordStore on _ResetPasswordStoreBase, Store {
  Computed<bool>? _$canResetPasswordComputed;

  @override
  bool get canResetPassword => (_$canResetPasswordComputed ??= Computed<bool>(
          () => super.canResetPassword,
          name: '_ResetPasswordStoreBase.canResetPassword'))
      .value;

  late final _$newPasswordAtom =
      Atom(name: '_ResetPasswordStoreBase.newPassword', context: context);

  @override
  String get newPassword {
    _$newPasswordAtom.reportRead();
    return super.newPassword;
  }

  @override
  set newPassword(String value) {
    _$newPasswordAtom.reportWrite(value, super.newPassword, () {
      super.newPassword = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_ResetPasswordStoreBase.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_ResetPasswordStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$codeAtom =
      Atom(name: '_ResetPasswordStoreBase.code', context: context);

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$setCodeAsyncAction =
      AsyncAction('_ResetPasswordStoreBase.setCode', context: context);

  @override
  Future<void> setCode(String value) {
    return _$setCodeAsyncAction.run(() => super.setCode(value));
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('_ResetPasswordStoreBase.resetPassword', context: context);

  @override
  Future<void> resetPassword() {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword());
  }

  late final _$_ResetPasswordStoreBaseActionController =
      ActionController(name: '_ResetPasswordStoreBase', context: context);

  @override
  void setNewPassword(String value) {
    final _$actionInfo = _$_ResetPasswordStoreBaseActionController.startAction(
        name: '_ResetPasswordStoreBase.setNewPassword');
    try {
      return super.setNewPassword(value);
    } finally {
      _$_ResetPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_ResetPasswordStoreBaseActionController.startAction(
        name: '_ResetPasswordStoreBase.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_ResetPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ResetPasswordStoreBaseActionController.startAction(
        name: '_ResetPasswordStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ResetPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newPassword: ${newPassword},
confirmPassword: ${confirmPassword},
loading: ${loading},
code: ${code},
canResetPassword: ${canResetPassword}
    ''';
  }
}
