// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountDialogStore on _AccountDialogStoreBase, Store {
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_AccountDialogStoreBase.canSubmit'))
          .value;

  late final _$representativeAtom =
      Atom(name: '_AccountDialogStoreBase.representative', context: context);

  @override
  Representative? get representative {
    _$representativeAtom.reportRead();
    return super.representative;
  }

  @override
  set representative(Representative? value) {
    _$representativeAtom.reportWrite(value, super.representative, () {
      super.representative = value;
    });
  }

  late final _$userSettingAtom =
      Atom(name: '_AccountDialogStoreBase.userSetting', context: context);

  @override
  UserSetting? get userSetting {
    _$userSettingAtom.reportRead();
    return super.userSetting;
  }

  @override
  set userSetting(UserSetting? value) {
    _$userSettingAtom.reportWrite(value, super.userSetting, () {
      super.userSetting = value;
    });
  }

  late final _$agencyAtom =
      Atom(name: '_AccountDialogStoreBase.agency', context: context);

  @override
  Agency? get agency {
    _$agencyAtom.reportRead();
    return super.agency;
  }

  @override
  set agency(Agency? value) {
    _$agencyAtom.reportWrite(value, super.agency, () {
      super.agency = value;
    });
  }

  late final _$fairAtom =
      Atom(name: '_AccountDialogStoreBase.fair', context: context);

  @override
  Fair? get fair {
    _$fairAtom.reportRead();
    return super.fair;
  }

  @override
  set fair(Fair? value) {
    _$fairAtom.reportWrite(value, super.fair, () {
      super.fair = value;
    });
  }

  late final _$fairIdAtom =
      Atom(name: '_AccountDialogStoreBase.fairId', context: context);

  @override
  String get fairId {
    _$fairIdAtom.reportRead();
    return super.fairId;
  }

  @override
  set fairId(String value) {
    _$fairIdAtom.reportWrite(value, super.fairId, () {
      super.fairId = value;
    });
  }

  late final _$_initAsyncAction =
      AsyncAction('_AccountDialogStoreBase._init', context: context);

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  late final _$_AccountDialogStoreBaseActionController =
      ActionController(name: '_AccountDialogStoreBase', context: context);

  @override
  void setFairId(String value) {
    final _$actionInfo = _$_AccountDialogStoreBaseActionController.startAction(
        name: '_AccountDialogStoreBase.setFairId');
    try {
      return super.setFairId(value);
    } finally {
      _$_AccountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void submit() {
    final _$actionInfo = _$_AccountDialogStoreBaseActionController.startAction(
        name: '_AccountDialogStoreBase.submit');
    try {
      return super.submit();
    } finally {
      _$_AccountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_AccountDialogStoreBaseActionController.startAction(
        name: '_AccountDialogStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_AccountDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
representative: ${representative},
userSetting: ${userSetting},
agency: ${agency},
fair: ${fair},
fairId: ${fairId},
canSubmit: ${canSubmit}
    ''';
  }
}
