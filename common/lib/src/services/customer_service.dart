import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_place/google_place.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerServiceInterface {
  Future<void> create(Customer item, {bool applyToFirestore = true});

  Stream<List<Customer>> getAllAsStream();

  Future<Customer?> getById(String id,
      {bool eager = false, List<Type> flow = const []});

  Stream<Customer?> getByIdAsStream(String id, {bool eager = false});

  Stream<List<Customer>> getByRepresentativeIdAsStream(String representativeId,
      {String? search});

  Stream<List<Customer>> getByOtherOrderRepresentativeIdAsStream(
      String representativeId,
      {String? search});

  Future<int> getQuoteFormIdAndIncrement(String id);

  Stream<List<Customer>> searchAsStream(String query);

  Future<List<Customer>> searchByAddressOrByPhoneOrByEmail(
      List<Map<String, String>> queries);

  Stream<List<Customer>> searchByAddressOrByPhoneOrByEmailAsStream(
      List<Map<String, String>> queries);

  Stream<List<Customer>> searchByRepresentativeIdAsStream(
      String query, String representativeId);

  Stream<List<Customer>> searchByOtherOrderRepresentativeIdAsStream(
      String query, String representativeId);

  Future<GeoPoint?> computeLocation(Customer customer);

  Future<void> update(Customer item, {bool applyToFirestore = true});

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class CustomerService
    extends AbstractModelService<Customer, $CustomersTable, AgencyDatabase>
    implements CustomerServiceInterface {
  CustomerService()
      : super(getIt<CustomerDriftDao>(), getIt<CustomerFirestoreDao>());
  // Dependencies:--------------------------------------------------------------
  late final GooglePlace _googlePlace = getIt<GooglePlace>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<Customer?> getById(String id,
      {bool eager = false, List<Type> flow = const []}) async {
    Customer? customer = await super.getById(id);
    if (eager) {
      await customer?.loadData(eager: eager, flow: flow);
    }
    return customer;
  }

  @override
  Stream<Customer?> getByIdAsStream(String id,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<Customer?> customerStream = super.getByIdAsStream(id);
    if (eager) {
      customerStream = customerStream.asyncMap((customer) async {
        await customer?.loadData(eager: eager, flow: flow);
        return customer;
      });
    }
    return customerStream;
  }

  @override
  Stream<List<Customer>> getAllAsStream() {
    return (localDao as CustomerDriftDao).getAllAsStream();
  }

  Future<List<Customer>> search(String query) async {
    return Future.value((localDao as CustomerDriftDao).search(query));
  }

  @override
  Stream<List<Customer>> searchAsStream(String query) {
    return (localDao as CustomerDriftDao).searchAsStream(query);
  }

  @override
  Stream<List<Customer>> getByRepresentativeIdAsStream(String representativeId,
      {String? search}) {
    return (localDao as CustomerDriftDao)
        .findByRepresentativeIdAsStream(representativeId, search: search);
  }

  @override
  Future<List<Customer>> searchByAddressOrByPhoneOrByEmail(
      List<Map<String, String>> queries) async {
    return Future.value((localDao as CustomerDriftDao)
        .searchByAddressOrByPhoneOrByEmail(queries));
  }

  @override
  Stream<List<Customer>> searchByAddressOrByPhoneOrByEmailAsStream(
      List<Map<String, String>> queries) {
    return (localDao as CustomerDriftDao)
        .searchByAddressOrByPhoneOrByEmailAsStream(queries);
  }

  @override
  Stream<List<Customer>> searchByRepresentativeIdAsStream(
      String query, String representativeId) {
    return (localDao as CustomerDriftDao)
        .searchByRepresentativeIdAsStream(query, representativeId);
  }

  @override
  Stream<List<Customer>> searchByOtherOrderRepresentativeIdAsStream(
      String query, String representativeId) {
    return (localDao as CustomerDriftDao)
        .searchByOtherOrderRepresentativeIdAsStream(query, representativeId);
  }

  @override
  Stream<List<Customer>> getByOtherOrderRepresentativeIdAsStream(
      String representativeId,
      {String? search}) {
    return (localDao as CustomerDriftDao)
        .findByOtherOrderRepresentativeIdAsStream(representativeId,
            search: search);
  }

  @override
  Future<int> getQuoteFormIdAndIncrement(String id) async {
    DocumentReference<Customer> customerRef = remoteDao.collection.doc(id);
    return await (remoteDao as CustomerFirestoreDao)
        .getQuoteFormNumberAndIncrement(customerRef);
  }

  @override
  Future<GeoPoint?> computeLocation(Customer customer) async {
    if (customer.location != null) {
      return customer.location;
    }

    var resultAddress = await _googlePlace.search.getFindPlace(
      customer.formattedAddress,
      InputType.TextQuery,
      language: 'fr',
    );

    // Address not found
    if (resultAddress == null || resultAddress.candidates == null) {
      customer.locationAlreadyFetched = true;
      await update(customer);
      return null;
    }

    final DetailsResponse? responseAddress =
        await _googlePlace.details.get(resultAddress.candidates![0].placeId!);

    // Address not found
    if (responseAddress == null || responseAddress.result == null) {
      customer.locationAlreadyFetched = true;
      await update(customer);
      return null;
    }

    final location = GeoPoint(
      responseAddress.result!.geometry!.location!.lat!,
      responseAddress.result!.geometry!.location!.lng!,
    );
    customer.location = location;
    customer.locationAlreadyFetched = true;
    await update(customer);

    return location;
  }
}
