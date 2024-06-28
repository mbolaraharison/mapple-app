import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'services_browser_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ServicesBrowserStoreInterface {
  ServicesBrowserStoreInterface._(
    this.serviceFamilies,
    this.serviceSubFamilies,
    this.services,
  );

  // Variables
  ServiceFamily? serviceFamily;
  ServiceSubFamily? serviceSubFamily;
  ObservableList<ServiceFamily> serviceFamilies;
  ObservableList<ServiceSubFamily> serviceSubFamilies;
  ObservableList<Service> services;

  // Computed
  ObservableList<ServiceSubFamily> get serviceSubFamiliesFiltered;
  ObservableList<Service> get servicesFiltered;

  // Methods
  void setServiceFamily(ServiceFamily value);
  void setServiceSubFamily(ServiceSubFamily value);
  void dispose();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ServicesBrowserStore = _ServicesBrowserStoreBase
    with _$ServicesBrowserStore;

abstract class _ServicesBrowserStoreBase
    with Store
    implements ServicesBrowserStoreInterface {
  _ServicesBrowserStoreBase() {
    loadData();
  }
  // Stores:--------------------------------------------------------------------
  final ServiceFamilyServiceInterface _serviceFamilyService =
      getIt<ServiceFamilyServiceInterface>();
  final ServiceSubFamilyServiceInterface _serviceSubFamilyService =
      getIt<ServiceSubFamilyServiceInterface>();
  final ServiceServiceInterface _serviceService =
      getIt<ServiceServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  ServiceFamily? serviceFamily;

  @override
  @observable
  ServiceSubFamily? serviceSubFamily;

  @override
  @observable
  ObservableList<ServiceFamily> serviceFamilies =
      ObservableList<ServiceFamily>();

  @override
  @observable
  ObservableList<ServiceSubFamily> serviceSubFamilies =
      ObservableList<ServiceSubFamily>();

  @override
  @observable
  ObservableList<Service> services = ObservableList<Service>();

  // Subscriptions:--------------------------------------------------------------
  StreamSubscription<List<ServiceFamily>>? serviceFamiliesSubscription;
  StreamSubscription<List<ServiceSubFamily>>? serviceSubFamiliesSubscription;
  StreamSubscription<List<Service>>? servicesSubscription;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  ObservableList<ServiceSubFamily> get serviceSubFamiliesFiltered {
    if (serviceFamily == null) {
      return ObservableList.of([]);
    }
    return serviceSubFamilies
        .where((ServiceSubFamily serviceSubFamily) =>
            serviceSubFamily.familyId == serviceFamily!.id)
        .toList()
        .asObservable();
  }

  @override
  @computed
  ObservableList<Service> get servicesFiltered {
    if (serviceSubFamily == null) {
      return ObservableList.of([]);
    }
    return services
        .where((Service service) => service.subFamilyId == serviceSubFamily!.id)
        .toList()
        .asObservable();
  }

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setServiceFamily(ServiceFamily serviceFamily) {
    this.serviceFamily = serviceFamily;
  }

  @override
  @action
  void setServiceSubFamily(ServiceSubFamily serviceSubFamily) {
    this.serviceSubFamily = serviceSubFamily;
  }

  // Methods:-------------------------------------------------------------------
  @action
  Future<void> loadAndWatchServiceFamilies() async {
    // first load
    serviceFamilies = ObservableList.of(
        await _serviceFamilyService.getAllActiveAndOrderByPosition());
    // then watch
    serviceFamiliesSubscription?.cancel();
    serviceFamiliesSubscription = _serviceFamilyService
        .getAllActiveAndOrderByPositionAsStream()
        .listen((List<ServiceFamily> serviceFamilies) {
      this.serviceFamilies = serviceFamilies.asObservable();
    });
  }

  @action
  Future<void> loadAndWatchServiceSubFamilies() async {
    if (serviceFamily == null) {
      return;
    }
    // first load
    serviceSubFamilies = ObservableList.of(await _serviceSubFamilyService
        .getByFamilyId(serviceFamily!.id, eager: true));
    // then watch
    serviceSubFamiliesSubscription?.cancel();
    serviceSubFamiliesSubscription = _serviceSubFamilyService
        .getByFamilyIdAsStream(serviceFamily!.id, eager: true)
        .listen((List<ServiceSubFamily> serviceSubFamilies) {
      this.serviceSubFamilies = serviceSubFamilies.asObservable();
    });
  }

  @action
  Future<void> loadAndWatchServices() async {
    if (serviceFamily == null) {
      return;
    }
    // first load
    services = ObservableList.of(await _serviceService
        .getAllActiveByFamilyId(serviceFamily!.id, eager: true));
    // then watch
    servicesSubscription?.cancel();
    servicesSubscription = _serviceService
        .getAllActiveByFamilyIdAsStream(serviceFamily!.id, eager: true)
        .listen((List<Service> services) {
      this.services = services.asObservable();
    });
  }

  void watchServiceFamily() {
    reaction((_) => serviceFamily, (_) {
      loadAndWatchServiceSubFamilies();
      loadAndWatchServices();
      services = ObservableList.of([]);
    });
  }

  Future<void> loadData() async {
    loadAndWatchServiceFamilies();
    watchServiceFamily();
  }

  @override
  void dispose() {
    serviceFamiliesSubscription?.cancel();
    serviceSubFamiliesSubscription?.cancel();
    servicesSubscription?.cancel();
  }
}
