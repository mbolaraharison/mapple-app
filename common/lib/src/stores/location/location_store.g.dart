// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationStore on _LocationStoreBase, Store {
  Computed<bool>? _$locationIsEnabledComputed;

  @override
  bool get locationIsEnabled => (_$locationIsEnabledComputed ??= Computed<bool>(
          () => super.locationIsEnabled,
          name: '_LocationStoreBase.locationIsEnabled'))
      .value;

  late final _$serviceEnabledAtom =
      Atom(name: '_LocationStoreBase.serviceEnabled', context: context);

  @override
  bool get serviceEnabled {
    _$serviceEnabledAtom.reportRead();
    return super.serviceEnabled;
  }

  @override
  set serviceEnabled(bool value) {
    _$serviceEnabledAtom.reportWrite(value, super.serviceEnabled, () {
      super.serviceEnabled = value;
    });
  }

  late final _$currentLocationAtom =
      Atom(name: '_LocationStoreBase.currentLocation', context: context);

  @override
  LocationData? get currentLocation {
    _$currentLocationAtom.reportRead();
    return super.currentLocation;
  }

  @override
  set currentLocation(LocationData? value) {
    _$currentLocationAtom.reportWrite(value, super.currentLocation, () {
      super.currentLocation = value;
    });
  }

  late final _$permissionGrantedAtom =
      Atom(name: '_LocationStoreBase.permissionGranted', context: context);

  @override
  PermissionStatus? get permissionGranted {
    _$permissionGrantedAtom.reportRead();
    return super.permissionGranted;
  }

  @override
  set permissionGranted(PermissionStatus? value) {
    _$permissionGrantedAtom.reportWrite(value, super.permissionGranted, () {
      super.permissionGranted = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_LocationStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$getCurrentLocationAsyncAction =
      AsyncAction('_LocationStoreBase.getCurrentLocation', context: context);

  @override
  Future<void> getCurrentLocation() {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation());
  }

  @override
  String toString() {
    return '''
serviceEnabled: ${serviceEnabled},
currentLocation: ${currentLocation},
permissionGranted: ${permissionGranted},
locationIsEnabled: ${locationIsEnabled}
    ''';
  }
}
