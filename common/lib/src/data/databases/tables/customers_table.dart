import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Customer)
class Customers extends Table with DefaultTable {
  TextColumn get agencyId => text().references(Agencies, #id)();
  TextColumn get category => text()();
  BoolColumn get isActive => boolean()();
  TextColumn get name => text()();
  BoolColumn get isIndividual => boolean()();
  DateTimeColumn get customerSince => dateTime()();
  TextColumn get signingMethod => textEnum<SigningMethod>().nullable()();
  TextColumn get origin => textEnum<Origin>().nullable()();
  TextColumn get originDetails => textEnum<OriginDetails>().nullable()();
  TextColumn get taxSystem => textEnum<TaxSystem>()();
  TextColumn get paymentTerms => textEnum<PaymentTerms>()();
  TextColumn get representative1Id =>
      text().nullable().references(Representatives, #id)();
  TextColumn get representative2Id =>
      text().nullable().references(Representatives, #id)();
  TextColumn get addressCode => text()();
  TextColumn get addressLabel => text()();
  TextColumn get addressAddress1 => text()();
  TextColumn get addressAddress2 => text()();
  TextColumn get addressPostalCode => text()();
  TextColumn get addressCity => text()();
  TextColumn get addressCountry => text()();
  BoolColumn get addressIsDefault => boolean()();
  TextColumn get syncStatus => textEnum<SyncStatus>()();
  IntColumn get quoteFormNextIncrement => integer()();
  TextColumn get location => text().map(const GeoPointConverter()).nullable()();
  BoolColumn get locationAlreadyFetched => boolean()();
  TextColumn get searchableName => text()();
  TextColumn get searchableAddress => text()();

  @override
  Set<Column> get primaryKey => {id};
}
