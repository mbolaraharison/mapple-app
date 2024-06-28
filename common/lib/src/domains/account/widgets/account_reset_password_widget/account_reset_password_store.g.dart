// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_reset_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountResetPasswordStore on _AccountResetPasswordStore, Store {
  Computed<bool>? _$canUpdateComputed;

  @override
  bool get canUpdate =>
      (_$canUpdateComputed ??= Computed<bool>(() => super.canUpdate,
              name: '_AccountResetPasswordStore.canUpdate'))
          .value;

  late final _$currentPasswordAtom = Atom(
      name: '_AccountResetPasswordStore.currentPassword', context: context);

  @override
  String get currentPassword {
    _$currentPasswordAtom.reportRead();
    return super.currentPassword;
  }

  @override
  set currentPassword(String value) {
    _$currentPasswordAtom.reportWrite(value, super.currentPassword, () {
      super.currentPassword = value;
    });
  }

  late final _$newPasswordAtom =
      Atom(name: '_AccountResetPasswordStore.newPassword', context: context);

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

  late final _$confirmPasswordAtom = Atom(
      name: '_AccountResetPasswordStore.confirmPassword', context: context);

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

  @override
  String toString() {
    return '''
currentPassword: ${currentPassword},
newPassword: ${newPassword},
confirmPassword: ${confirmPassword},
canUpdate: ${canUpdate}
    ''';
  }
}
