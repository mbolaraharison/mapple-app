// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SyncStore on _SyncStore, Store {
  late final _$isOkAtom = Atom(name: '_SyncStore.isOk', context: context);

  @override
  bool get isOk {
    _$isOkAtom.reportRead();
    return super.isOk;
  }

  @override
  set isOk(bool value) {
    _$isOkAtom.reportWrite(value, super.isOk, () {
      super.isOk = value;
    });
  }

  late final _$integrityJobModelAtom =
      Atom(name: '_SyncStore.integrityJobModel', context: context);

  @override
  IntegrityJobModel? get integrityJobModel {
    _$integrityJobModelAtom.reportRead();
    return super.integrityJobModel;
  }

  @override
  set integrityJobModel(IntegrityJobModel? value) {
    _$integrityJobModelAtom.reportWrite(value, super.integrityJobModel, () {
      super.integrityJobModel = value;
    });
  }

  late final _$_SyncStoreActionController =
      ActionController(name: '_SyncStore', context: context);

  @override
  void setIsOk(bool value, {IntegrityJobModel? integrityJobModel}) {
    final _$actionInfo =
        _$_SyncStoreActionController.startAction(name: '_SyncStore.setIsOk');
    try {
      return super.setIsOk(value, integrityJobModel: integrityJobModel);
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancel() {
    final _$actionInfo =
        _$_SyncStoreActionController.startAction(name: '_SyncStore.cancel');
    try {
      return super.cancel();
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _listenToJob() {
    final _$actionInfo = _$_SyncStoreActionController.startAction(
        name: '_SyncStore._listenToJob');
    try {
      return super._listenToJob();
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isOk: ${isOk},
integrityJobModel: ${integrityJobModel}
    ''';
  }
}
