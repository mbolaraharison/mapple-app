// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_browser_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServicesBrowserStore on _ServicesBrowserStoreBase, Store {
  Computed<ObservableList<ServiceSubFamily>>?
      _$serviceSubFamiliesFilteredComputed;

  @override
  ObservableList<ServiceSubFamily> get serviceSubFamiliesFiltered =>
      (_$serviceSubFamiliesFilteredComputed ??=
              Computed<ObservableList<ServiceSubFamily>>(
                  () => super.serviceSubFamiliesFiltered,
                  name: '_ServicesBrowserStoreBase.serviceSubFamiliesFiltered'))
          .value;
  Computed<ObservableList<Service>>? _$servicesFilteredComputed;

  @override
  ObservableList<Service> get servicesFiltered =>
      (_$servicesFilteredComputed ??= Computed<ObservableList<Service>>(
              () => super.servicesFiltered,
              name: '_ServicesBrowserStoreBase.servicesFiltered'))
          .value;

  late final _$serviceFamilyAtom =
      Atom(name: '_ServicesBrowserStoreBase.serviceFamily', context: context);

  @override
  ServiceFamily? get serviceFamily {
    _$serviceFamilyAtom.reportRead();
    return super.serviceFamily;
  }

  @override
  set serviceFamily(ServiceFamily? value) {
    _$serviceFamilyAtom.reportWrite(value, super.serviceFamily, () {
      super.serviceFamily = value;
    });
  }

  late final _$serviceSubFamilyAtom = Atom(
      name: '_ServicesBrowserStoreBase.serviceSubFamily', context: context);

  @override
  ServiceSubFamily? get serviceSubFamily {
    _$serviceSubFamilyAtom.reportRead();
    return super.serviceSubFamily;
  }

  @override
  set serviceSubFamily(ServiceSubFamily? value) {
    _$serviceSubFamilyAtom.reportWrite(value, super.serviceSubFamily, () {
      super.serviceSubFamily = value;
    });
  }

  late final _$serviceFamiliesAtom =
      Atom(name: '_ServicesBrowserStoreBase.serviceFamilies', context: context);

  @override
  ObservableList<ServiceFamily> get serviceFamilies {
    _$serviceFamiliesAtom.reportRead();
    return super.serviceFamilies;
  }

  @override
  set serviceFamilies(ObservableList<ServiceFamily> value) {
    _$serviceFamiliesAtom.reportWrite(value, super.serviceFamilies, () {
      super.serviceFamilies = value;
    });
  }

  late final _$serviceSubFamiliesAtom = Atom(
      name: '_ServicesBrowserStoreBase.serviceSubFamilies', context: context);

  @override
  ObservableList<ServiceSubFamily> get serviceSubFamilies {
    _$serviceSubFamiliesAtom.reportRead();
    return super.serviceSubFamilies;
  }

  @override
  set serviceSubFamilies(ObservableList<ServiceSubFamily> value) {
    _$serviceSubFamiliesAtom.reportWrite(value, super.serviceSubFamilies, () {
      super.serviceSubFamilies = value;
    });
  }

  late final _$servicesAtom =
      Atom(name: '_ServicesBrowserStoreBase.services', context: context);

  @override
  ObservableList<Service> get services {
    _$servicesAtom.reportRead();
    return super.services;
  }

  @override
  set services(ObservableList<Service> value) {
    _$servicesAtom.reportWrite(value, super.services, () {
      super.services = value;
    });
  }

  late final _$loadAndWatchServiceFamiliesAsyncAction = AsyncAction(
      '_ServicesBrowserStoreBase.loadAndWatchServiceFamilies',
      context: context);

  @override
  Future<void> loadAndWatchServiceFamilies() {
    return _$loadAndWatchServiceFamiliesAsyncAction
        .run(() => super.loadAndWatchServiceFamilies());
  }

  late final _$loadAndWatchServiceSubFamiliesAsyncAction = AsyncAction(
      '_ServicesBrowserStoreBase.loadAndWatchServiceSubFamilies',
      context: context);

  @override
  Future<void> loadAndWatchServiceSubFamilies() {
    return _$loadAndWatchServiceSubFamiliesAsyncAction
        .run(() => super.loadAndWatchServiceSubFamilies());
  }

  late final _$loadAndWatchServicesAsyncAction = AsyncAction(
      '_ServicesBrowserStoreBase.loadAndWatchServices',
      context: context);

  @override
  Future<void> loadAndWatchServices() {
    return _$loadAndWatchServicesAsyncAction
        .run(() => super.loadAndWatchServices());
  }

  late final _$_ServicesBrowserStoreBaseActionController =
      ActionController(name: '_ServicesBrowserStoreBase', context: context);

  @override
  void setServiceFamily(ServiceFamily serviceFamily) {
    final _$actionInfo = _$_ServicesBrowserStoreBaseActionController
        .startAction(name: '_ServicesBrowserStoreBase.setServiceFamily');
    try {
      return super.setServiceFamily(serviceFamily);
    } finally {
      _$_ServicesBrowserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setServiceSubFamily(ServiceSubFamily serviceSubFamily) {
    final _$actionInfo = _$_ServicesBrowserStoreBaseActionController
        .startAction(name: '_ServicesBrowserStoreBase.setServiceSubFamily');
    try {
      return super.setServiceSubFamily(serviceSubFamily);
    } finally {
      _$_ServicesBrowserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
serviceFamily: ${serviceFamily},
serviceSubFamily: ${serviceSubFamily},
serviceFamilies: ${serviceFamilies},
serviceSubFamilies: ${serviceSubFamilies},
services: ${services},
serviceSubFamiliesFiltered: ${serviceSubFamiliesFiltered},
servicesFiltered: ${servicesFiltered}
    ''';
  }
}
