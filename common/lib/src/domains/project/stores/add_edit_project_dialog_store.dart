import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' show GeoPoint;
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'add_edit_project_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class AddEditProjectDialogStoreInterface
    implements AbstractAddressStore {
  AddEditProjectDialogStoreInterface._(
    this.address,
    this.postalCode,
    this.city,
    this.isProPremise,
  );

  AddEditProjectDialogStoreParams get params;

  String address;

  String postalCode;

  String city;

  GeoPoint? location;

  Origin? meetingOrigin;

  OriginDetails? meetingOriginDetails;

  int? houseAge;

  bool isProPremise;

  bool get canSubmit;

  String get meetingOriginWithDetails;

  bool get isEditing;

  OrderType? get orderType;

  void setIsProPremise(bool value);

  void setHouseAge(int value);

  void setMeetingOrigin(Origin originValue, OriginDetails originDetailsValue);

  Future<void> addProject();

  void submit();

  Future<void> reset();

  void dispose();
}

// Params:----------------------------------------------------------------------
class AddEditProjectDialogStoreParams {
  const AddEditProjectDialogStoreParams({
    required this.order,
    required this.customerId,
    required this.customerViewStore,
  });

  final Order? order;
  final String customerId;
  final CustomerViewStoreInterface? customerViewStore;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class AddEditProjectDialogStore = _AddEditProjectDialogStoreBase
    with _$AddEditProjectDialogStore;

abstract class _AddEditProjectDialogStoreBase
    with Store
    implements AddEditProjectDialogStoreInterface {
  _AddEditProjectDialogStoreBase({required this.params}) {
    reset();
    initStreams();
  }

  // Params:--------------------------------------------------------------------
  @override
  final AddEditProjectDialogStoreParams params;

  // Other variables:-----------------------------------------------------------
  StreamSubscription<Map<String, AbstractBaseModel?>>?
      _currentFairAndRepresentativeSubscription;

  @observable
  Representative? _currentRepresentative;

  @observable
  Fair? _currentFair;

  // Services:------------------------------------------------------------------
  final OrderServiceInterface _orderService = getIt<OrderServiceInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final FairServiceInterface _fairService = getIt<FairServiceInterface>();
  late final AgencyServiceInterface _agencyService =
      getIt<AgencyServiceInterface>();
  late final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Services:------------------------------------------------------------------
  final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  String address = '';

  @override
  @observable
  String postalCode = '';

  @override
  @observable
  String city = '';

  @override
  @observable
  GeoPoint? location;

  @override
  @observable
  Origin? meetingOrigin;

  @override
  @observable
  OriginDetails? meetingOriginDetails;

  @override
  @observable
  int? houseAge;

  @override
  @observable
  bool isProPremise = false;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get canSubmit {
    if (isEditing) {
      return (address.isNotEmpty && address != params.order!.address) ||
          (postalCode.isNotEmpty && postalCode != params.order!.postalCode) ||
          (city.isNotEmpty && city != params.order!.city) ||
          (meetingOrigin != null && meetingOrigin != params.order!.origin) ||
          (meetingOriginDetails != null &&
              meetingOriginDetails != params.order!.originDetails) ||
          (houseAge != null && houseAge != params.order!.houseAge) ||
          (isProPremise != params.order!.isProPremise);
    } else {
      return address.isNotEmpty &&
          postalCode.isNotEmpty &&
          city.isNotEmpty &&
          meetingOrigin != null &&
          meetingOriginDetails != null &&
          houseAge != null &&
          houseAge! >= 0;
    }
  }

  @override
  @computed
  String get meetingOriginWithDetails {
    if (meetingOriginDetails != null) {
      return '${meetingOrigin!.label} - ${meetingOriginDetails!.label}';
    }
    return meetingOrigin != null ? meetingOrigin!.label : '';
  }

  @override
  @computed
  bool get isEditing => params.order != null;

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

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setIsProPremise(bool value) => isProPremise = value;

  @override
  @action
  void setHouseAge(int value) => houseAge = value;

  @override
  @action
  void setMeetingOrigin(Origin originValue, OriginDetails originDetailsValue) {
    meetingOrigin = originValue;
    meetingOriginDetails = originDetailsValue;
  }

  @override
  @action
  void setAddress(AddressDTO? addressDetails) {
    if (addressDetails == null) {
      return;
    }

    address = addressDetails.address;
    postalCode = addressDetails.postalCode;
    city = addressDetails.city;
    location = addressDetails.location;
  }

  @action
  void setPostalCode(String value) => postalCode = value;

  @action
  void setCity(String value) => city = value;

  @action
  void updateOrder() {
    bool canUpdate = false;
    if (params.order!.address1 != address) {
      params.order!.address1 = address;
      canUpdate = true;
    }
    if (params.order!.postalCode != postalCode) {
      params.order!.postalCode = postalCode;
      canUpdate = true;
    }
    if (params.order!.city != city) {
      params.order!.city = city;
      canUpdate = true;
    }
    if (params.order!.location != location) {
      params.order!.location = location;
      canUpdate = true;
    }
    if (params.order!.origin != meetingOrigin) {
      params.order!.origin = meetingOrigin;
      canUpdate = true;
    }
    if (params.order!.originDetails != meetingOriginDetails) {
      params.order!.originDetails = meetingOriginDetails;
      canUpdate = true;
    }
    if (params.order!.houseAge != houseAge) {
      params.order!.houseAge = houseAge;
      canUpdate = true;
    }
    if (params.order!.isProPremise != isProPremise) {
      params.order!.isProPremise = isProPremise;
      canUpdate = true;
    }
    if (canUpdate) {
      // should recreate envelope
      params.order!.setShouldRecreateEnvelope(true);
      _orderService.update(params.order!);
      if (params.order!.location == null) {
        _orderService.getLocation(params.order!);
      }
    }
  }

  @override
  @action
  Future<void> addProject() async {
    if (_currentRepresentative == null) {
      return;
    }
    Fair? fair = _currentFair;
    String agencyId = _currentRepresentative!.agencyId;
    String? fairId = _currentRepresentative!.hasFairAccess ? (fair?.id) : null;
    final String orderFormId =
        await _agencyService.getOrderFormIdAndIncrement(agencyId);

    // Project
    Order order = Order(
      id: _uuidUtils.generate(),
      agencyId: agencyId,
      customerId: params.customerId,
      fairId: fairId,
      address1: address,
      addressCode: 'FAC01',
      city: city,
      postalCode: postalCode,
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
      origin: meetingOrigin!,
      originDetails: meetingOriginDetails!,
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

    params.customerViewStore!.orders.insert(0, order);

    _orderService.create(order);

    if (order.location == null) {
      _orderService.getLocation(order);
    }
  }

  @override
  @action
  void submit() {
    if (isEditing) {
      updateOrder();
    } else {
      addProject();
    }
  }

  @override
  @action
  Future<void> reset() async {
    if (isEditing) {
      address = params.order!.address;
      postalCode = params.order!.postalCode;
      city = params.order!.city;
      meetingOrigin = params.order!.origin;
      meetingOriginDetails = params.order!.originDetails;
      houseAge = params.order!.houseAge;
      isProPremise = params.order!.isProPremise;
    } else {
      Customer? customer = await _customerService.getById(params.customerId);
      address = customer?.address ?? '';
      postalCode = customer?.addressPostalCode ?? '';
      city = customer?.addressCity ?? '';
      meetingOrigin = null;
      meetingOriginDetails = null;
      houseAge = 0;
      isProPremise = !(customer!.isIndividual);
    }
  }

  // Other methods:-------------------------------------------------------------
  StreamController<Map<String, AbstractBaseModel?>>
      _getCurrentFairAndRepresentativeAsStream() {
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

  void initStreams() {
    _currentFairAndRepresentativeSubscription?.cancel();
    _currentFairAndRepresentativeSubscription =
        _getCurrentFairAndRepresentativeAsStream().stream.listen((event) {
      _currentRepresentative = event['representative'] as Representative?;
      _currentFair = event['fair'] as Fair?;
    });
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _currentFairAndRepresentativeSubscription?.cancel();
  }
}
