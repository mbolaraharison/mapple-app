// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalization_step_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FinalizationStepStore on _FinalizationStepStoreBase, Store {
  Computed<String>? _$formattedInstallAtComputed;

  @override
  String get formattedInstallAt => (_$formattedInstallAtComputed ??=
          Computed<String>(() => super.formattedInstallAt,
              name: '_FinalizationStepStoreBase.formattedInstallAt'))
      .value;
  Computed<String>? _$formattedEndProjectAtComputed;

  @override
  String get formattedEndProjectAt => (_$formattedEndProjectAtComputed ??=
          Computed<String>(() => super.formattedEndProjectAt,
              name: '_FinalizationStepStoreBase.formattedEndProjectAt'))
      .value;
  Computed<Future<List<Contact>>>? _$selectedContactsComputed;

  @override
  Future<List<Contact>> get selectedContacts => (_$selectedContactsComputed ??=
          Computed<Future<List<Contact>>>(() => super.selectedContacts,
              name: '_FinalizationStepStoreBase.selectedContacts'))
      .value;
  Computed<bool>? _$isSubmittableComputed;

  @override
  bool get isSubmittable =>
      (_$isSubmittableComputed ??= Computed<bool>(() => super.isSubmittable,
              name: '_FinalizationStepStoreBase.isSubmittable'))
          .value;
  Computed<bool>? _$isInstallAtUpToDateComputed;

  @override
  bool get isInstallAtUpToDate => (_$isInstallAtUpToDateComputed ??=
          Computed<bool>(() => super.isInstallAtUpToDate,
              name: '_FinalizationStepStoreBase.isInstallAtUpToDate'))
      .value;
  Computed<bool>? _$canGenerateQuoteComputed;

  @override
  bool get canGenerateQuote => (_$canGenerateQuoteComputed ??= Computed<bool>(
          () => super.canGenerateQuote,
          name: '_FinalizationStepStoreBase.canGenerateQuote'))
      .value;
  Computed<bool>? _$isEndProjectAtUpToDateComputed;

  @override
  bool get isEndProjectAtUpToDate => (_$isEndProjectAtUpToDateComputed ??=
          Computed<bool>(() => super.isEndProjectAtUpToDate,
              name: '_FinalizationStepStoreBase.isEndProjectAtUpToDate'))
      .value;

  late final _$_currentRepresentativeAtom = Atom(
      name: '_FinalizationStepStoreBase._currentRepresentative',
      context: context);

  @override
  Representative? get _currentRepresentative {
    _$_currentRepresentativeAtom.reportRead();
    return super._currentRepresentative;
  }

  @override
  set _currentRepresentative(Representative? value) {
    _$_currentRepresentativeAtom
        .reportWrite(value, super._currentRepresentative, () {
      super._currentRepresentative = value;
    });
  }

  late final _$installAtAtom =
      Atom(name: '_FinalizationStepStoreBase.installAt', context: context);

  @override
  DateTime? get installAt {
    _$installAtAtom.reportRead();
    return super.installAt;
  }

  @override
  set installAt(DateTime? value) {
    _$installAtAtom.reportWrite(value, super.installAt, () {
      super.installAt = value;
    });
  }

  late final _$endProjectAtAtom =
      Atom(name: '_FinalizationStepStoreBase.endProjectAt', context: context);

  @override
  DateTime? get endProjectAt {
    _$endProjectAtAtom.reportRead();
    return super.endProjectAt;
  }

  @override
  set endProjectAt(DateTime? value) {
    _$endProjectAtAtom.reportWrite(value, super.endProjectAt, () {
      super.endProjectAt = value;
    });
  }

  late final _$selectedContactValuesAtom = Atom(
      name: '_FinalizationStepStoreBase.selectedContactValues',
      context: context);

  @override
  ObservableList<String> get selectedContactValues {
    _$selectedContactValuesAtom.reportRead();
    return super.selectedContactValues;
  }

  @override
  set selectedContactValues(ObservableList<String> value) {
    _$selectedContactValuesAtom.reportWrite(value, super.selectedContactValues,
        () {
      super.selectedContactValues = value;
    });
  }

  late final _$selectedRepValuesAtom = Atom(
      name: '_FinalizationStepStoreBase.selectedRepValues', context: context);

  @override
  ObservableList<String> get selectedRepValues {
    _$selectedRepValuesAtom.reportRead();
    return super.selectedRepValues;
  }

  @override
  set selectedRepValues(ObservableList<String> value) {
    _$selectedRepValuesAtom.reportWrite(value, super.selectedRepValues, () {
      super.selectedRepValues = value;
    });
  }

  late final _$keepOldStuffAtom =
      Atom(name: '_FinalizationStepStoreBase.keepOldStuff', context: context);

  @override
  bool get keepOldStuff {
    _$keepOldStuffAtom.reportRead();
    return super.keepOldStuff;
  }

  @override
  set keepOldStuff(bool value) {
    _$keepOldStuffAtom.reportWrite(value, super.keepOldStuff, () {
      super.keepOldStuff = value;
    });
  }

  late final _$selectedRepsAtom =
      Atom(name: '_FinalizationStepStoreBase.selectedReps', context: context);

  @override
  ObservableList<Representative> get selectedReps {
    _$selectedRepsAtom.reportRead();
    return super.selectedReps;
  }

  @override
  set selectedReps(ObservableList<Representative> value) {
    _$selectedRepsAtom.reportWrite(value, super.selectedReps, () {
      super.selectedReps = value;
    });
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_FinalizationStepStoreBase.loadData', context: context);

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  late final _$setSelectedContactValuesAsyncAction = AsyncAction(
      '_FinalizationStepStoreBase.setSelectedContactValues',
      context: context);

  @override
  Future<void> setSelectedContactValues(List<String> values) {
    return _$setSelectedContactValuesAsyncAction
        .run(() => super.setSelectedContactValues(values));
  }

  late final _$setSelectedRepValuesAsyncAction = AsyncAction(
      '_FinalizationStepStoreBase.setSelectedRepValues',
      context: context);

  @override
  Future<void> setSelectedRepValues(List<String> values) {
    return _$setSelectedRepValuesAsyncAction
        .run(() => super.setSelectedRepValues(values));
  }

  late final _$_FinalizationStepStoreBaseActionController =
      ActionController(name: '_FinalizationStepStoreBase', context: context);

  @override
  void updateCartData() {
    final _$actionInfo = _$_FinalizationStepStoreBaseActionController
        .startAction(name: '_FinalizationStepStoreBase.updateCartData');
    try {
      return super.updateCartData();
    } finally {
      _$_FinalizationStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKeepOldStuff(bool value) {
    final _$actionInfo = _$_FinalizationStepStoreBaseActionController
        .startAction(name: '_FinalizationStepStoreBase.setKeepOldStuff');
    try {
      return super.setKeepOldStuff(value);
    } finally {
      _$_FinalizationStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInstallationAt(DateTime value) {
    final _$actionInfo = _$_FinalizationStepStoreBaseActionController
        .startAction(name: '_FinalizationStepStoreBase.setInstallationAt');
    try {
      return super.setInstallationAt(value);
    } finally {
      _$_FinalizationStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndProjectAt(DateTime value) {
    final _$actionInfo = _$_FinalizationStepStoreBaseActionController
        .startAction(name: '_FinalizationStepStoreBase.setEndProjectAt');
    try {
      return super.setEndProjectAt(value);
    } finally {
      _$_FinalizationStepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
installAt: ${installAt},
endProjectAt: ${endProjectAt},
selectedContactValues: ${selectedContactValues},
selectedRepValues: ${selectedRepValues},
keepOldStuff: ${keepOldStuff},
selectedReps: ${selectedReps},
formattedInstallAt: ${formattedInstallAt},
formattedEndProjectAt: ${formattedEndProjectAt},
selectedContacts: ${selectedContacts},
isSubmittable: ${isSubmittable},
isInstallAtUpToDate: ${isInstallAtUpToDate},
canGenerateQuote: ${canGenerateQuote},
isEndProjectAtUpToDate: ${isEndProjectAtUpToDate}
    ''';
  }
}
