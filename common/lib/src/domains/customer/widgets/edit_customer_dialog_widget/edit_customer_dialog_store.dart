import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'edit_customer_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class EditCustomerDialogStoreInterface {
  EditCustomerDialogStoreInterface._(
    this.customer,
    this.name,
    this.customerType,
    this.address,
    this.postalCode,
    this.city,
    this.origin,
    this.originDetails,
  );

  // Params
  EditCustomerDialogStoreParams get params;

  // Variables
  Customer customer;
  String name;
  CustomerType customerType;
  String address;
  String postalCode;
  String city;
  Origin? origin;
  OriginDetails? originDetails;

  // Computed
  String get originWithDetails;

  // Methods
  void setName(String value);
  void setOrigin(Origin originValue, OriginDetails originDetailsValue);
  void setAddress(String value);
  void setPostalCode(String value);
  void setCity(String value);
  void setCustomerType(CustomerType value);
  Future<void> updateCustomer();
  void reset();
}

// Params:----------------------------------------------------------------------
class EditCustomerDialogStoreParams {
  const EditCustomerDialogStoreParams({
    required this.customer,
  });

  final Customer customer;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class EditCustomerDialogStore = _EditCustomerDialogStoreBase
    with _$EditCustomerDialogStore;

abstract class _EditCustomerDialogStoreBase
    with Store
    implements EditCustomerDialogStoreInterface {
  _EditCustomerDialogStoreBase({required this.params})
      : customer = params.customer {
    init();
  }

  // Params:--------------------------------------------------------------------
  @override
  final EditCustomerDialogStoreParams params;

  // Services:-------------------------------------------------------------------
  final OrderServiceInterface _orderService = getIt<OrderServiceInterface>();
  final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  Customer customer;

  @override
  @observable
  String name = '';

  @override
  @observable
  CustomerType customerType = CustomerType.individual;

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
  Origin? origin;

  @override
  @observable
  OriginDetails? originDetails;

  // Computed:-------------------------------------------------------------------
  @override
  @computed
  String get originWithDetails {
    if (originDetails != null) {
      return '${origin!.label} - ${originDetails!.label}';
    }
    return origin != null ? origin!.label : '';
  }

  @override
  @action
  void setName(String value) => name = value;

  @override
  @action
  void setOrigin(Origin originValue, OriginDetails originDetailsValue) {
    origin = originValue;
    originDetails = originDetailsValue;
  }

  @override
  @action
  void setAddress(String value) => address = value;

  @override
  @action
  void setPostalCode(String value) => postalCode = value;

  @override
  @action
  void setCity(String value) => city = value;

  @override
  @action
  void setCustomerType(CustomerType value) => customerType = value;

  @override
  @action
  Future<void> updateCustomer() async {
    bool hasChanged = false;
    if (customer.name != name) {
      customer.setName = name;
      hasChanged = true;
    }
    if (customer.isIndividual != (customerType == CustomerType.individual)) {
      customer.isIndividual = customerType == CustomerType.individual;
      hasChanged = true;
    }
    if (customer.addressAddress1 != address) {
      customer.addressAddress1 = address;
      hasChanged = true;
    }
    if (customer.addressPostalCode != postalCode) {
      customer.addressPostalCode = postalCode;
      hasChanged = true;
    }
    if (customer.addressCity != city) {
      customer.addressCity = city;
      hasChanged = true;
    }
    if (customer.origin != origin) {
      customer.origin = origin;
      hasChanged = true;
    }
    if (customer.originDetails != originDetails) {
      customer.originDetails = originDetails;
      hasChanged = true;
    }
    if (!hasChanged) {
      return;
    }
    customer.syncStatus = customer.syncStatus == SyncStatus.OK
        ? SyncStatus.READY_FOR_UPDATE
        : customer.syncStatus;
    _customerService.update(customer);
    // Search all non-sent orders of the customer and set should recreate envelope to true
    List<Order> orders = await _orderService.getByCustomerIdByStatus(
      customer.id,
      OrderStatus.Z,
      eager: true,
    );
    for (Order order in orders) {
      order.setShouldRecreateEnvelope(true);

      await _orderService.update(order);
    }
  }

  void init() {
    name = customer.name;
    customerType = customer.isIndividual
        ? CustomerType.individual
        : CustomerType.professional;
    address = customer.addressAddress1;
    postalCode = customer.addressPostalCode;
    city = customer.addressCity;
    origin = customer.origin;
    originDetails = customer.originDetails;
  }

  @override
  @action
  void reset() {
    name = customer.name;
    customerType = customer.isIndividual
        ? CustomerType.individual
        : CustomerType.professional;
    address = customer.addressAddress1;
    postalCode = customer.addressPostalCode;
    city = customer.addressCity;
    origin = customer.origin;
    originDetails = customer.originDetails;
  }
}
