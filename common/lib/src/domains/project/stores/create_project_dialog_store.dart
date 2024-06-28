import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' show GeoPoint;
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'create_project_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CreateProjectDialogStoreInterface
    implements AbstractAddressStore {
  CreateProjectDialogStoreInterface._(
    this.customerType,
    this.customerName,
    this.customerAddress,
    this.customerPostalCode,
    this.customerCity,
    this.isProPremise,
    this.contacts,
  );

  // Variables:-----------------------------------------------------------------
  CustomerType customerType;
  String customerName;
  String customerAddress;
  String customerPostalCode;
  String customerCity;
  Origin? customerOrigin;
  OriginDetails? customerOriginDetails;
  int? houseAge;
  bool isProPremise;
  ObservableList<Contact> contacts;
  GeoPoint? location;
  ContactFormStoreInterface get contactFormStore;

  // Computed:------------------------------------------------------------------
  bool get createCustomerIsValid;
  bool get contactsListIsValid;
  OrderType? get orderType;
  List<Map<String, String>> get contactsData;

  // Methods:-------------------------------------------------------------------
  void setOrigin(Origin origin, OriginDetails originDetails);
  void submitContactForm();
  void addContact();
  void updateContact();
  void removeContact();
  void setHouseAge(int? age);
  void setIsProPremise(bool isProPremise);
  Future<Order> createProject();
  void dispose();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CreateProjectDialogStore = _CreateProjectDialogStoreBase
    with _$CreateProjectDialogStore;

abstract class _CreateProjectDialogStoreBase
    with Store
    implements CreateProjectDialogStoreInterface {
  _CreateProjectDialogStoreBase() {
    _initStreams();
  }
  // Services:------------------------------------------------------------------
  @override
  late final contactFormStore = getIt<ContactFormStoreInterface>();
  late final OrderServiceInterface _orderService =
      getIt<OrderServiceInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final FairServiceInterface _fairService = getIt<FairServiceInterface>();
  late final AgencyServiceInterface _agencyService =
      getIt<AgencyServiceInterface>();
  late final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();
  final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Variables:-----------------------------------------------------------------
  late final String _customerId = _uuidUtils.generate();

  // Other variables:-----------------------------------------------------------
  StreamSubscription? _currentStreamSubscription;

  @observable
  Representative? _currentRepresentative;

  @observable
  Fair? _currentFair;

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  CustomerType customerType = CustomerType.individual;

  @override
  @observable
  String customerName = '';

  @override
  @observable
  String customerAddress = '';

  @override
  @observable
  String customerPostalCode = '';

  @override
  @observable
  String customerCity = '';

  @override
  @observable
  Origin? customerOrigin;

  @override
  @observable
  OriginDetails? customerOriginDetails;

  @override
  @observable
  int? houseAge;

  @override
  @observable
  bool isProPremise = false;

  @override
  @observable
  ObservableList<Contact> contacts = ObservableList<Contact>();

  @override
  @observable
  GeoPoint? location;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get createCustomerIsValid =>
      customerName.isNotEmpty &&
      customerAddress.isNotEmpty &&
      customerPostalCode.isNotEmpty &&
      customerCity.isNotEmpty &&
      customerOrigin != null &&
      customerOriginDetails != null;

  @override
  @computed
  bool get contactsListIsValid => contacts.isNotEmpty;

  @override
  @computed
  OrderType? get orderType {
    if (_currentRepresentative == null) {
      return OrderType.VAD;
    }
    if (_currentRepresentative!.isDirectSale == true) {
      return OrderType.VAD;
    } else if (_currentRepresentative!.hasFairAccess == true) {
      return OrderType.FOI;
    }
    return OrderType.MAG;
  }

  @override
  @computed
  List<Map<String, String>> get contactsData {
    return contacts.map((contact) {
      return {
        'address': customerAddress,
        'postalCode': customerPostalCode,
        'city': customerCity,
        'phone': contact.phone,
        'mobilePhone': contact.mobilePhone,
        'email': contact.email,
      };
    }).toList();
  }

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setOrigin(Origin origin, OriginDetails originDetails) {
    customerOrigin = origin;
    customerOriginDetails = originDetails;
  }

  @override
  @action
  void submitContactForm() {
    if (contactFormStore.isCreating) {
      addContact();
    } else {
      updateContact();
    }
    contactFormStore.reset();
  }

  @override
  @action
  void addContact() {
    String agencyId = _currentRepresentative!.agencyId;
    contacts.add(contactFormStore.toContact(
      customerId: _customerId,
      agencyId: agencyId,
    ));
  }

  @override
  @action
  void updateContact() {
    String agencyId = _currentRepresentative!.agencyId;

    Contact contact = contactFormStore.toContact(
      customerId: _customerId,
      agencyId: agencyId,
    );
    int index = contacts.indexWhere((element) => element.id == contact.id);
    contacts[index] = contact;
  }

  @override
  @action
  void removeContact() {
    if (contactFormStore.id == null) {
      return;
    }
    contacts.removeWhere((element) => element.id == contactFormStore.id);
  }

  @override
  @action
  void setAddress(AddressDTO? addressDetails) {
    if (addressDetails == null) {
      return;
    }

    customerAddress = addressDetails.address;
    customerPostalCode = addressDetails.postalCode;
    customerCity = addressDetails.city;
    location = addressDetails.location;
  }

  @override
  @action
  void setHouseAge(int? age) {
    houseAge = age;
  }

  @override
  @action
  void setIsProPremise(bool isProPremise) {
    this.isProPremise = isProPremise;
  }

  @override
  @action
  Future<Order> createProject() async {
    String representative1Id = _currentRepresentative!.id;
    final String orderFormId = await _agencyService
        .getOrderFormIdAndIncrement(_currentRepresentative!.agencyId);
    String? fairId =
        _currentRepresentative!.hasFairAccess ? (_currentFair?.id) : null;

    Customer customer = Customer(
      id: _customerId,
      agencyId: _currentRepresentative!.agencyId,
      category: 'C',
      isActive: true,
      name: customerName.toCapitalizedWords(),
      isIndividual: customerType == CustomerType.individual,
      customerSince: DateTime.now(),
      signingMethod: SigningMethod.E,
      origin: customerOrigin!,
      originDetails: customerOriginDetails!,
      taxSystem: TaxSystem.FRA,
      paymentTerms: PaymentTerms.CB,
      representative1Id: representative1Id,
      representative2Id: null,
      addressCode: 'FAC01',
      addressLabel: '',
      addressAddress1: customerAddress,
      addressAddress2: '',
      addressPostalCode: customerPostalCode,
      addressCity: customerCity,
      addressCountry: 'FR',
      addressIsDefault: true,
      syncStatus: SyncStatus.NOT_READY,
    );
    await _customerService.create(customer);

    // Project
    Order order = Order(
      id: _uuidUtils.generate(),
      agencyId: _currentRepresentative!.agencyId,
      customerId: customer.id,
      fairId: fairId,
      address1: customerAddress,
      addressCode: 'FAC01',
      city: customerCity,
      postalCode: customerPostalCode,
      amountHT: 0,
      amountTTC: 0,
      creditAmount: 0,
      creditTotalCost: 0,
      depositAmount: 0,
      fundingStatus: FundingStatus.A,
      insuranceType: InsuranceType.none,
      monthlyPaymentAmount: 0,
      monthlyPaymentsCount: 0,
      nominalRate: 0,
      orderFormId: orderFormId,
      orderType: orderType!,
      origin: customerOrigin!,
      originDetails: customerOriginDetails!,
      paymentTerms: PaymentTerms.CB,
      deferment: Deferment.thirtyDays,
      signingMethod: SigningMethod.E,
      status: OrderStatus.Z,
      cartStatus: CartStatus.order,
      apr: 0,
      intermediatePaymentAmount: 0,
      envelopeAlreadySigned: false,
      envelopeRecipientIds: [],
      envelopeSignedRecipientIds: [],
      contacts: [],
      syncStatus: SyncStatus.NOT_READY,
      houseAge: houseAge,
      isProPremise: isProPremise,
      location: location,
    );

    await _orderService.create(order);

    if (order.location == null) {
      _orderService.getLocation(order);
    }

    for (var contact in contacts) {
      _contactService.create(contact);
    }

    return order;
  }

  // Other methods:-------------------------------------------------------------------
  StreamController<Map<String, AbstractBaseModel?>>
      _getCurrentRepresentativeAndFairAsStream() {
    return getIt<StreamUtilsInterface>()
        .combine<AbstractBaseModel?, Map<String, AbstractBaseModel?>>([
      _representativeService.getCurrentAsStream(),
      _fairService.getCurrentAsStream()
    ], (List<AbstractBaseModel?> data) {
      return {
        'representative': data[0] as Representative?,
        'fair': data[1] as Fair?,
      };
    });
  }

  void _initStreams() {
    _currentStreamSubscription?.cancel();
    _currentStreamSubscription =
        _getCurrentRepresentativeAndFairAsStream().stream.listen((event) {
      _currentRepresentative = event['representative'] as Representative?;
      _currentFair = event['fair'] as Fair?;
    });
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _currentStreamSubscription?.cancel();
  }
}
