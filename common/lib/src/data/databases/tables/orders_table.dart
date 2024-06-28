import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Order)
class Orders extends Table with DefaultTable {
  TextColumn get agencyId => text().references(Agencies, #id)();
  TextColumn get customerId => text().references(Customers, #id)();
  TextColumn get fairId => text().nullable().references(Fairs, #id)();
  TextColumn get representative1Id =>
      text().nullable().references(Representatives, #id)();
  TextColumn get representative2Id =>
      text().nullable().references(Representatives, #id)();
  TextColumn get representative3Id =>
      text().nullable().references(Representatives, #id)();
  TextColumn get address1 => text()();
  TextColumn get address2 => text().nullable()();
  TextColumn get addressCode => text()();
  TextColumn get city => text()();
  TextColumn get postalCode => text()();
  RealColumn get amountHT => real()();
  RealColumn get amountTTC => real()();
  IntColumn get intermediatePaymentPercentage => integer().nullable()();
  RealColumn get creditAmount => real()();
  RealColumn get creditTotalCost => real()();
  RealColumn get depositAmount => real()();
  TextColumn get fundingStatus => textEnum<FundingStatus>().nullable()();
  TextColumn get insuranceType => textEnum<InsuranceType>()();
  RealColumn get monthlyPaymentAmount => real()();
  IntColumn get monthlyPaymentsCount => integer()();
  RealColumn get nominalRate => real()();
  TextColumn get orderFormId => text()();
  TextColumn get orderType => textEnum<OrderType>()();
  TextColumn get origin => textEnum<Origin>().nullable()();
  TextColumn get originDetails => textEnum<OriginDetails>().nullable()();
  TextColumn get paymentTerms => textEnum<PaymentTerms>()();
  DateTimeColumn get installAt => dateTime().nullable()();
  DateTimeColumn get endProjectAt => dateTime().nullable()();
  TextColumn get deferment => textEnum<Deferment>()();
  TextColumn get signingMethod => textEnum<SigningMethod>().nullable()();
  TextColumn get status => textEnum<OrderStatus>()();
  TextColumn get cartStatus => textEnum<CartStatus>()();
  IntColumn get signatureStep => integer()();
  RealColumn get apr => real()();
  RealColumn get intermediatePaymentAmount => real().nullable()();
  BoolColumn get keepOldStuff => boolean()();
  IntColumn get houseAge => integer().nullable()();
  BoolColumn get isProPremise => boolean()();
  TextColumn get envelopeId => text().nullable()();
  BoolColumn get envelopeAlreadySigned => boolean()();
  TextColumn get envelopeRecipientIds =>
      text().map(const ListStringConverter())();
  TextColumn get envelopeSignedRecipientIds =>
      text().map(const ListStringConverter())();
  DateTimeColumn get envelopeSignedAt => dateTime().nullable()();
  BoolColumn get shouldRecreateEnvelope => boolean()();
  TextColumn get location => text().map(const GeoPointConverter()).nullable()();
  BoolColumn get locationAlreadyFetched => boolean()();
  TextColumn get syncStatus => textEnum<SyncStatus>()();
  BoolColumn get isCashPayment => boolean().nullable()();
  BoolColumn get isFinancingPayment => boolean().nullable()();
  TextColumn get cashPaymentMethod =>
      textEnum<CashPaymentMethod>().nullable()();
  TextColumn get financingPaymentMethod =>
      textEnum<FinancingPaymentMethod>().nullable()();
  TextColumn get orderFormFileDataId =>
      text().nullable().references(FileDatas, #id)();
  TextColumn get termsDocumentFileDataId =>
      text().nullable().references(FileDatas, #id)();
  TextColumn get vatCertificateFileDataId =>
      text().nullable().references(FileDatas, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
