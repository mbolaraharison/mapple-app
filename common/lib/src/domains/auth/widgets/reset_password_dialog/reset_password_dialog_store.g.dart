// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResetPasswordDialogStore on _ResetPasswordDialogStoreBase, Store {
  late final _$emailAtom =
      Atom(name: '_ResetPasswordDialogStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$resetPasswordAsyncAction = AsyncAction(
      '_ResetPasswordDialogStoreBase.resetPassword',
      context: context);

  @override
  Future<void> resetPassword() {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword());
  }

  late final _$_ResetPasswordDialogStoreBaseActionController =
      ActionController(name: '_ResetPasswordDialogStoreBase', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_ResetPasswordDialogStoreBaseActionController
        .startAction(name: '_ResetPasswordDialogStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_ResetPasswordDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email}
    ''';
  }
}
