import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';

class Customer extends AbstractBaseModel implements Insertable<Customer> {
  Customer({
    required super.id,
    required this.agencyId,
    required this.category,
    required this.isActive,
    required this.name,
    required this.isIndividual,
    required this.customerSince,
    required this.signingMethod,
    required this.origin,
    required this.originDetails,
    required this.taxSystem,
    required this.paymentTerms,
    required this.representative1Id,
    this.representative2Id,
    required this.addressCode,
    required this.addressLabel,
    required this.addressAddress1,
    required this.addressAddress2,
    required this.addressPostalCode,
    required this.addressCity,
    required this.addressCountry,
    required this.addressIsDefault,
    required this.syncStatus,
    this.quoteFormNextIncrement = 1,
    this.location,
    this.locationAlreadyFetched = false,
    super.createdAt,
    super.updatedAt,
  }) {
    searchableName = name.toSearchable();
    searchableAddress = formattedAddress.toSearchable().trim();
  }

  // Variables:-----------------------------------------------------------------
  final String agencyId;
  final String category;
  final bool isActive;
  String name;
  bool isIndividual;
  final DateTime customerSince;
  final SigningMethod? signingMethod;
  Origin? origin;
  OriginDetails? originDetails;
  final TaxSystem taxSystem;
  final PaymentTerms paymentTerms;
  final String? representative1Id;
  final String? representative2Id;
  final String addressCode;
  final String addressLabel;
  String addressAddress1;
  final String addressAddress2;
  String addressPostalCode;
  String addressCity;
  final String addressCountry;
  final bool addressIsDefault;
  SyncStatus syncStatus;
  final int quoteFormNextIncrement;
  // Location
  GeoPoint? location;
  bool locationAlreadyFetched;
  // Search fields
  late String searchableName;
  late String searchableAddress;

  List<Contact> contacts = [];
  List<Order> orders = [];

  // Getters:-------------------------------------------------------------------
  String get initials {
    return getIt<StringUtilsInterface>().getInitialsFromName(name);
  }

  CustomerType get customerType =>
      isIndividual ? CustomerType.individual : CustomerType.professional;

  String get formattedName => name.toUpperCase();

  String get typeKey => customerType.labelKey;

  Color get typeColor => customerType.activeColor;

  String get address {
    if (addressAddress1.isNotEmpty) {
      return addressAddress1;
    }
    return addressAddress2;
  }

  String get formattedAddress => '$address, $addressPostalCode, $addressCity';

  String get originWithDetails {
    if (originDetails != null) {
      return '${origin!.label} - ${originDetails!.label}';
    }
    return origin != null ? origin!.label : '';
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadContacts(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Customer)) {
      flow.add(Customer);
    } else {
      return;
    }
    contacts = await getIt<ContactServiceInterface>()
        .getByCustomerId(id, eager: eager, flow: flow);
  }

  Future<void> loadOrders(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Customer)) {
      flow.add(Customer);
    } else {
      return;
    }
    orders = await getIt<OrderServiceInterface>()
        .getByCustomerId(id, eager: eager, flow: flow);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadContacts(eager: eager, flow: flow);
    await loadOrders(eager: eager, flow: flow);
  }

  bool isCustomerOfRepresentative(String representativeId) {
    for (final order in orders) {
      if (order.representative1Id == representativeId) {
        return true;
      }
      if (order.representative2Id == representativeId) {
        return true;
      }
      if (order.representative3Id == representativeId) {
        return true;
      }
    }
    return false;
  }

  set setName(String newName) {
    name = newName;
    searchableName = name.toSearchable();
  }

  // Base methods:--------------------------------------------------------------
  factory Customer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Customer(
      id: snapshot.id,
      agencyId: data?['agencyId'] as String,
      category: data?['category'] as String,
      isActive: data?['isActive'] as bool,
      name: data?['name'] as String,
      isIndividual: data?['isIndividual'] as bool,
      customerSince: (data?['customerSince'] as Timestamp).toDate(),
      signingMethod: data?['signingMethod'] != null
          ? SigningMethod.values.firstWhere(
              (e) => e.name == data?['signingMethod'],
            )
          : null,
      origin: data?['origin'] != null
          ? Origin.values.firstWhere(
              (e) => e.name == data?['origin'],
            )
          : null,
      originDetails: data?['originDetails'] != null
          ? OriginDetails.values.firstWhere(
              (e) => e.name == data?['originDetails'],
            )
          : null,
      taxSystem: TaxSystem.values.firstWhere(
        (e) => e.name == data?['taxSystem'],
      ),
      paymentTerms: PaymentTerms.values.firstWhere(
        (e) => e.name == data?['paymentTerms'],
      ),
      representative1Id: data?['representative1Id'] as String?,
      representative2Id: data?['representative2Id'] as String?,
      addressCode: data?['addressCode'] as String,
      addressLabel: data?['addressLabel'] as String,
      addressAddress1: data?['addressAddress1'] as String,
      addressAddress2: data?['addressAddress2'] as String,
      addressPostalCode: data?['addressPostalCode'] as String,
      addressCity: data?['addressCity'] as String,
      addressCountry: data?['addressCountry'] as String,
      addressIsDefault: data?['addressIsDefault'] as bool,
      syncStatus: SyncStatus.values.firstWhere(
        (e) => e.name == data?['syncStatus'],
      ),
      quoteFormNextIncrement: data?['quoteFormNextIncrement'] ?? 1,
      location: data?['location'] as GeoPoint?,
      locationAlreadyFetched: data?['locationAlreadyFetched'] ?? false,
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'agencyId': agencyId,
      'category': category,
      'isActive': isActive,
      'name': name,
      'isIndividual': isIndividual,
      'customerSince': customerSince,
      'signingMethod': signingMethod?.name,
      'origin': origin?.name,
      'originDetails': originDetails?.name,
      'taxSystem': taxSystem.name,
      'paymentTerms': paymentTerms.name,
      'representative1Id': representative1Id,
      'representative2Id': representative2Id,
      'addressCode': addressCode,
      'addressLabel': addressLabel,
      'addressAddress1': addressAddress1,
      'addressAddress2': addressAddress2,
      'addressPostalCode': addressPostalCode,
      'addressCity': addressCity,
      'addressCountry': addressCountry,
      'addressIsDefault': addressIsDefault,
      'syncStatus': syncStatus.name,
      'quoteFormNextIncrement': quoteFormNextIncrement,
      'location': location,
      'locationAlreadyFetched': locationAlreadyFetched,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Customer copyWith({
    String? id,
    String? agencyId,
    String? category,
    bool? isActive,
    String? name,
    bool? isIndividual,
    DateTime? customerSince,
    SigningMethod? signingMethod,
    Origin? origin,
    OriginDetails? originDetails,
    TaxSystem? taxSystem,
    PaymentTerms? paymentTerms,
    String? representative1Id,
    String? representative2Id,
    String? addressCode,
    String? addressLabel,
    String? addressAddress1,
    String? addressAddress2,
    String? addressPostalCode,
    String? addressCity,
    String? addressCountry,
    bool? addressIsDefault,
    SyncStatus? syncStatus,
    int? quoteFormNextIncrement,
    GeoPoint? location,
    bool? locationAlreadyFetched,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      agencyId: agencyId ?? this.agencyId,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      name: name ?? this.name,
      isIndividual: isIndividual ?? this.isIndividual,
      customerSince: customerSince ?? this.customerSince,
      signingMethod: signingMethod ?? this.signingMethod,
      origin: origin ?? this.origin,
      originDetails: originDetails ?? this.originDetails,
      taxSystem: taxSystem ?? this.taxSystem,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      representative1Id: representative1Id ?? this.representative1Id,
      representative2Id: representative2Id ?? this.representative2Id,
      addressCode: addressCode ?? this.addressCode,
      addressLabel: addressLabel ?? this.addressLabel,
      addressAddress1: addressAddress1 ?? this.addressAddress1,
      addressAddress2: addressAddress2 ?? this.addressAddress2,
      addressPostalCode: addressPostalCode ?? this.addressPostalCode,
      addressCity: addressCity ?? this.addressCity,
      addressCountry: addressCountry ?? this.addressCountry,
      addressIsDefault: addressIsDefault ?? this.addressIsDefault,
      syncStatus: syncStatus ?? this.syncStatus,
      quoteFormNextIncrement:
          quoteFormNextIncrement ?? this.quoteFormNextIncrement,
      location: location ?? this.location,
      locationAlreadyFetched:
          locationAlreadyFetched ?? this.locationAlreadyFetched,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    late GeoPointConverter geoPointConverter = const GeoPointConverter();

    return {
      'id': Variable<String>(id),
      'agency_id': Variable<String>(agencyId),
      'category': Variable<String>(category),
      'is_active': Variable<bool>(isActive),
      'name': Variable<String>(name),
      'is_individual': Variable<bool>(isIndividual),
      'customer_since': Variable<DateTime>(customerSince),
      'signing_method': Variable<String>(signingMethod?.name),
      'origin': Variable<String>(origin?.name),
      'origin_details': Variable<String>(originDetails?.name),
      'tax_system': Variable<String>(taxSystem.name),
      'payment_terms': Variable<String>(paymentTerms.name),
      'representative1_id':
          Variable<String>(stringUtils.valueIfNotEmpty(representative1Id)),
      'representative2_id':
          Variable<String>(stringUtils.valueIfNotEmpty(representative2Id)),
      'address_code': Variable<String>(addressCode),
      'address_label': Variable<String>(addressLabel),
      'address_address1': Variable<String>(addressAddress1),
      'address_address2': Variable<String>(addressAddress2),
      'address_postal_code': Variable<String>(addressPostalCode),
      'address_city': Variable<String>(addressCity),
      'address_country': Variable<String>(addressCountry),
      'address_is_default': Variable<bool>(addressIsDefault),
      'sync_status': Variable<String>(syncStatus.name),
      'quote_form_next_increment': Variable<int>(quoteFormNextIncrement),
      'location': Variable<String>(
          location != null ? geoPointConverter.toSql(location!) : null),
      'location_already_fetched': Variable<bool>(locationAlreadyFetched),
      'searchable_name': Variable<String>(searchableName),
      'searchable_address': Variable<String>(searchableAddress),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.agencyId == agencyId &&
        other.category == category &&
        other.isActive == isActive &&
        other.name == name &&
        other.isIndividual == isIndividual &&
        other.customerSince == customerSince &&
        other.signingMethod == signingMethod &&
        other.origin == origin &&
        other.originDetails == originDetails &&
        other.taxSystem == taxSystem &&
        other.paymentTerms == paymentTerms &&
        other.representative1Id == representative1Id &&
        other.representative2Id == representative2Id &&
        other.addressCode == addressCode &&
        other.addressLabel == addressLabel &&
        other.addressAddress1 == addressAddress1 &&
        other.addressAddress2 == addressAddress2 &&
        other.addressPostalCode == addressPostalCode &&
        other.addressCity == addressCity &&
        other.addressCountry == addressCountry &&
        other.addressIsDefault == addressIsDefault &&
        other.syncStatus == syncStatus &&
        other.quoteFormNextIncrement == quoteFormNextIncrement &&
        other.location == location &&
        other.locationAlreadyFetched == locationAlreadyFetched &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
