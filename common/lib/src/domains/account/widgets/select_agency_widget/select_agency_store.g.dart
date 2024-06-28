// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_agency_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectAgencyStore on _SelectAgencyStore, Store {
  late final _$agencyIdAtom =
      Atom(name: '_SelectAgencyStore.agencyId', context: context);

  @override
  String get agencyId {
    _$agencyIdAtom.reportRead();
    return super.agencyId;
  }

  @override
  set agencyId(String value) {
    _$agencyIdAtom.reportWrite(value, super.agencyId, () {
      super.agencyId = value;
    });
  }

  late final _$currentAgencyAtom =
      Atom(name: '_SelectAgencyStore.currentAgency', context: context);

  @override
  Agency? get currentAgency {
    _$currentAgencyAtom.reportRead();
    return super.currentAgency;
  }

  @override
  set currentAgency(Agency? value) {
    _$currentAgencyAtom.reportWrite(value, super.currentAgency, () {
      super.currentAgency = value;
    });
  }

  late final _$currentRepresentativeAtom =
      Atom(name: '_SelectAgencyStore.currentRepresentative', context: context);

  @override
  Representative? get currentRepresentative {
    _$currentRepresentativeAtom.reportRead();
    return super.currentRepresentative;
  }

  @override
  set currentRepresentative(Representative? value) {
    _$currentRepresentativeAtom.reportWrite(value, super.currentRepresentative,
        () {
      super.currentRepresentative = value;
    });
  }

  late final _$loadRepresentativeStoreAsyncAction = AsyncAction(
      '_SelectAgencyStore.loadRepresentativeStore',
      context: context);

  @override
  Future<void> loadRepresentativeStore() {
    return _$loadRepresentativeStoreAsyncAction
        .run(() => super.loadRepresentativeStore());
  }

  late final _$_SelectAgencyStoreActionController =
      ActionController(name: '_SelectAgencyStore', context: context);

  @override
  void setAgencyId(String value) {
    final _$actionInfo = _$_SelectAgencyStoreActionController.startAction(
        name: '_SelectAgencyStore.setAgencyId');
    try {
      return super.setAgencyId(value);
    } finally {
      _$_SelectAgencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
agencyId: ${agencyId},
currentAgency: ${currentAgency},
currentRepresentative: ${currentRepresentative}
    ''';
  }
}
