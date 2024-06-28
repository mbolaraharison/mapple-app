import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'customer_drift_dao.g.dart';

@DriftAccessor(tables: [Customers])
class CustomerDriftDao
    extends AbstractDriftDao<Customer, $CustomersTable, AgencyDatabase>
    with _$CustomerDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  CustomerDriftDao(AgencyDatabase db) : super(db, db.customers);

  Stream<List<Customer>> getAllAsStream() {
    return _querySearch().watch();
  }

  Future<List<Customer>> search(String query) async {
    return _querySearch(query: query).get();
  }

  Stream<List<Customer>> searchAsStream(String query) {
    return _querySearch(query: query).watch();
  }

  Stream<List<Customer>> findByRepresentativeIdAsStream(String representativeId,
      {String? search}) {
    return _querySearch(
            representativeId: representativeId,
            query: search,
            isOnlyRepresentativeId: true)
        .watch();
  }

  Stream<List<Customer>> findByOtherOrderRepresentativeIdAsStream(
      String representativeId,
      {String? search}) {
    return _querySearch(
            representativeId: representativeId,
            query: search,
            isOnlyRepresentativeId: false)
        .watch();
  }

  Selectable<Customer> _querySearch(
      {String? query,
      String? representativeId,
      bool isOnlyRepresentativeId = true}) {
    final customerQuery = select(customers, distinct: true).join([
      leftOuterJoin(db.orders, db.orders.customerId.equalsExp(customers.id),
          useColumns: false)
    ]);

    if (representativeId != null) {
      isOnlyRepresentativeId
          ? customerQuery.where((customers.id.isInQuery(
              _customerIdByRepresentativeIdStatement(representativeId))))
          : customerQuery.where((customers.id.isNotInQuery(
              _customerIdByRepresentativeIdStatement(representativeId))));
    }

    if (query != null) {
      customerQuery.where(
          customers.searchableName.contains(query.toSearchable()) |
              customers.searchableAddress.contains(query.toSearchable()));
    }

    customerQuery
      ..groupBy([customers.id])
      ..orderBy([
        OrderingTerm(
            expression: db.orders.envelopeSignedAt.max(),
            mode: OrderingMode.desc)
      ]);

    return customerQuery.map((row) => row.readTable(customers));
  }

  Selectable<Customer> _queryByAddressOrByPhoneOrByEmail(
      List<Map<String, String>> queries) {
    List<String> fullAddresses = queries
        .map((query) =>
            '${query['address']}, ${query['postalCode']}, ${query['city']}'
                .toSearchable()
                .trim())
        .toList();
    List<String> formattedPhones = queries
        .map((query) => getIt<PhoneUtilsInterface>().format(query['phone']!))
        .toList();
    List<String> formattedPhonesWithCode = queries
        .map((query) =>
            getIt<PhoneUtilsInterface>().formatWithCode(query['phone']!))
        .toList();
    List<String> formattedMobilePhones = queries
        .map((query) =>
            getIt<PhoneUtilsInterface>().format(query['mobilePhone']!))
        .toList();
    List<String> formattedMobilePhonesWithCode = queries
        .map((query) =>
            getIt<PhoneUtilsInterface>().formatWithCode(query['mobilePhone']!))
        .toList();
    List<String> emails =
        queries.map((e) => e['email']!.toSearchable().trim()).toList();

    // all attributes should be trimmed before passing to the query
    return db.customersByAddressOrByPhoneOrByEmail(
        fullAddresses: fullAddresses,
        emails: emails,
        formattedPhones: formattedPhones,
        formattedMobilePhones: formattedMobilePhones,
        formattedPhonesWithCode: formattedPhonesWithCode,
        formattedMobilePhonesWithCode: formattedMobilePhonesWithCode);
  }

  Future<List<Customer>> searchByAddressOrByPhoneOrByEmail(
      List<Map<String, String>> queries) async {
    return _queryByAddressOrByPhoneOrByEmail(queries).get();
  }

  Stream<List<Customer>> searchByAddressOrByPhoneOrByEmailAsStream(
      List<Map<String, String>> queries) {
    return _queryByAddressOrByPhoneOrByEmail(queries).watch();
  }

  SimpleSelectStatement<$CustomersTable, Customer>
      _queryBySearchByRepresentativeId(String query, String representativeId) {
    return (select(customers)
      ..join([
        innerJoin(
            db.orders, db.orders.customerId.isValue(customers.id as String))
      ])
      ..where((tbl) =>
          (tbl.searchableName.contains(query.toSearchable()) |
              tbl.searchableAddress.contains(query.toSearchable())) &
          (db.orders.representative1Id.isValue(representativeId) |
              db.orders.representative2Id.isValue(representativeId) |
              db.orders.representative3Id.isValue(representativeId))))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.name, mode: OrderingMode.asc),
      ]);
  }

  Stream<List<Customer>> searchByRepresentativeIdAsStream(
      String query, String representativeId) {
    return _queryBySearchByRepresentativeId(query, representativeId).watch();
  }

  SimpleSelectStatement<$CustomersTable, Customer>
      _queryBySearchByOtherOrderRepresentativeId(
          String query, String representativeId) {
    return (select(customers)
      ..join(
          [innerJoin(db.orders, db.orders.customerId.equalsExp(customers.id))])
      ..where((tbl) =>
          (tbl.searchableName.contains(query.toSearchable()) |
              tbl.searchableAddress.contains(query.toSearchable())) &
          (db.orders.representative1Id.isNotValue(representativeId) &
              db.orders.representative2Id.isNotValue(representativeId) &
              db.orders.representative3Id.isNotValue(representativeId))))
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.name, mode: OrderingMode.asc),
      ]);
  }

  Stream<List<Customer>> searchByOtherOrderRepresentativeIdAsStream(
      String query, String representativeId) {
    return _queryBySearchByOtherOrderRepresentativeId(query, representativeId)
        .watch();
  }

  // This statement will return a list of customers.id that belong to the given representative
  JoinedSelectStatement<HasResultSet, dynamic>
      _customerIdByRepresentativeIdStatement(String representativeId) {
    return ((selectOnly(customers, distinct: true).join([
      innerJoin(db.orders, db.orders.customerId.equalsExp(customers.id),
          useColumns: false)
    ]))
      ..addColumns([customers.id]))
      ..where((customers.representative1Id.isValue(representativeId) |
          customers.representative2Id.isValue(representativeId) |
          db.orders.representative1Id.isValue(representativeId) |
          db.orders.representative2Id.isValue(representativeId) |
          db.orders.representative3Id.isValue(representativeId)))
      ..orderBy(
          [OrderingTerm(expression: customers.name, mode: OrderingMode.asc)]);
  }
}
