// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_autocomplete_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressAutocompleteFormStore on _AddressAutocompleteFormStore, Store {
  late final _$predictionsAtom =
      Atom(name: '_AddressAutocompleteFormStore.predictions', context: context);

  @override
  List<AutocompletePrediction> get predictions {
    _$predictionsAtom.reportRead();
    return super.predictions;
  }

  @override
  set predictions(List<AutocompletePrediction> value) {
    _$predictionsAtom.reportWrite(value, super.predictions, () {
      super.predictions = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AddressAutocompleteFormStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$manualModeAtom =
      Atom(name: '_AddressAutocompleteFormStore.manualMode', context: context);

  @override
  bool get manualMode {
    _$manualModeAtom.reportRead();
    return super.manualMode;
  }

  @override
  set manualMode(bool value) {
    _$manualModeAtom.reportWrite(value, super.manualMode, () {
      super.manualMode = value;
    });
  }

  late final _$searchAsyncAction =
      AsyncAction('_AddressAutocompleteFormStore.search', context: context);

  @override
  Future<void> search(String query) {
    return _$searchAsyncAction.run(() => super.search(query));
  }

  late final _$selectAsyncAction =
      AsyncAction('_AddressAutocompleteFormStore.select', context: context);

  @override
  Future<AddressDTO?> select(AutocompletePrediction prediction) {
    return _$selectAsyncAction.run(() => super.select(prediction));
  }

  late final _$_AddressAutocompleteFormStoreActionController =
      ActionController(name: '_AddressAutocompleteFormStore', context: context);

  @override
  void backToAutoMode(String query) {
    final _$actionInfo = _$_AddressAutocompleteFormStoreActionController
        .startAction(name: '_AddressAutocompleteFormStore.backToAutoMode');
    try {
      return super.backToAutoMode(query);
    } finally {
      _$_AddressAutocompleteFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
predictions: ${predictions},
isLoading: ${isLoading},
manualMode: ${manualMode}
    ''';
  }
}
