import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' show GeoPoint;
import 'package:geolocator/geolocator.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'customer_view_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerViewStoreInterface {
  CustomerViewStoreInterface._(
    this.customer,
    this.isLoading,
    this.contacts,
    this.orders,
    this.notes,
    this.services,
    this.distanceToCustomerAddress,
    this.search,
  );

  // Variables
  CustomerViewStoreParams get params;
  Customer customer;
  bool isLoading;
  int? selectedTab;
  ObservableList<Contact> contacts;
  ObservableList<Order> orders;
  ObservableList<Note> notes;
  ObservableList<Service> services;
  double distanceToCustomerAddress;
  String search;

  // Computed
  String get formattedDistanceToCustomerAddress;
  String get searchableSearch;
  Stream<List<FileData>> get filteredQuoteFileDataStream;
  Stream<List<FileData>> get filteredNormalFileDataStream;

  // Methods
  void setSearch(String value);
  dispose();
}

// Params:----------------------------------------------------------------------
class CustomerViewStoreParams {
  const CustomerViewStoreParams({
    required this.customer,
  });

  final Customer customer;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CustomerViewStore = _CustomerViewStoreBase with _$CustomerViewStore;

abstract class _CustomerViewStoreBase
    with Store
    implements CustomerViewStoreInterface {
  _CustomerViewStoreBase({required this.params}) : customer = params.customer {
    init();
  }
  // Params:--------------------------------------------------------------------
  @override
  final CustomerViewStoreParams params;

  // Dependencies:--------------------------------------------------------------
  final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();
  final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();
  final OrderServiceInterface _orderService = getIt<OrderServiceInterface>();
  final NoteServiceInterface _noteService = getIt<NoteServiceInterface>();
  final LocationUtilsInterface _addressUtils = getIt<LocationUtilsInterface>();
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  Customer customer;

  @override
  @observable
  bool isLoading = false;

  @override
  @observable
  int? selectedTab = 0;

  @override
  @observable
  ObservableList<Contact> contacts = ObservableList<Contact>();

  @override
  @observable
  ObservableList<Order> orders = ObservableList<Order>();

  @override
  @observable
  ObservableList<Note> notes = ObservableList<Note>();

  @override
  @observable
  ObservableList<Service> services = ObservableList<Service>();

  @override
  @observable
  double distanceToCustomerAddress = 0;

  @override
  @observable
  String search = '';

  // Subscriptions:-------------------------------------------------------------
  StreamSubscription<Customer?>? customerSubscription;
  StreamSubscription<List<Contact>>? contactsSubscription;
  StreamSubscription<List<Order>>? ordersSubscription;
  StreamSubscription<List<Note>>? notesSubscription;
  StreamSubscription<List<FileData>>? fileDataSubscription;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  String get formattedDistanceToCustomerAddress {
    if (distanceToCustomerAddress <= 1000) {
      return '${distanceToCustomerAddress.toStringAsFixed(0)} m';
    } else {
      return '${(distanceToCustomerAddress / 1000).toStringAsFixed(1)} km';
    }
  }

  @override
  @computed
  String get searchableSearch => '%${search.toSearchable()}%';

  @override
  @computed
  Stream<List<FileData>> get filteredQuoteFileDataStream {
    return _fileDataService.searchByCustomerIdByTypeAsStream(
        searchableSearch, customer.id, FileDataType.quote);
  }

  @override
  @computed
  Stream<List<FileData>> get filteredNormalFileDataStream {
    return _fileDataService.searchByCustomerIdByTypeAsStream(
        searchableSearch, customer.id, FileDataType.normal,
        eager: true);
  }

  // Actions:-------------------------------------------------------------------
  @action
  void watchCustomer() {
    // get and watch distance
    getDistanceToCustomerAddress();
    // watch customer
    customerSubscription?.cancel();
    customerSubscription = _customerService
        .getByIdAsStream(customer.id, eager: true)
        .listen((customer) {
      if (customer != null) {
        this.customer = customer;
      }
    });
  }

  @action
  Future<void> loadAndWatchContacts() async {
    // first load
    contacts = ObservableList<Contact>.of(customer.contacts);
    // then watch
    contactsSubscription?.cancel();
    contactsSubscription = _contactService
        .getByCustomerIdAsStream(customer.id, eager: true)
        .listen((contacts) {
      this.contacts = ObservableList<Contact>.of(contacts);
    });
  }

  @action
  Future<void> loadAndWatchOrders() async {
    // first load
    orders = ObservableList<Order>.of(
        await _orderService.getByCustomerId(customer.id, eager: true));
    // then watch
    ordersSubscription?.cancel();
    ordersSubscription = _orderService
        .getByCustomerIdAsStream(customer.id, eager: true)
        .listen((orders) {
      this.orders = ObservableList<Order>.of(orders);
    });
  }

  @action
  Future<void> loadAndWatchNotes() async {
    // first load
    notes = ObservableList<Note>.of(
        await _noteService.getByCustomerId(customer.id, eager: true));
    // then watch
    notesSubscription?.cancel();
    notesSubscription = _noteService
        .getByCustomerIdAsStream(customer.id, eager: true)
        .listen((notes) {
      this.notes = ObservableList<Note>.of(notes);
    });
  }

  @action
  Future<void> getDistanceToCustomerAddress() async {
    if (customer.location == null && customer.locationAlreadyFetched == true) {
      distanceToCustomerAddress = 0;
      return;
    }

    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    final customerLocation = await _customerService.computeLocation(customer);

    if (customerLocation == null) {
      distanceToCustomerAddress = 0;
      return;
    }

    distanceToCustomerAddress =
        await _addressUtils.getDistanceBetweenTwoLocations(
      GeoPoint(currentPosition.latitude, currentPosition.longitude),
      customerLocation,
    );
  }

  @action
  Future<void> init() async {
    isLoading = true;
    // watch customer
    watchCustomer();
    // load contacts
    await loadAndWatchContacts();
    // load orders
    await loadAndWatchOrders();
    // load notes
    await loadAndWatchNotes();
    isLoading = false;
  }

  @action
  void setSelectedTab(int? index) {
    selectedTab = index;
  }

  @override
  @action
  void setSearch(String value) {
    search = value;
  }

  @override
  void dispose() {
    customerSubscription?.cancel();
    contactsSubscription?.cancel();
    ordersSubscription?.cancel();
    notesSubscription?.cancel();
    fileDataSubscription?.cancel();
    _fileDataService.removeRemoteFilesFromFileSystem();
  }
}
