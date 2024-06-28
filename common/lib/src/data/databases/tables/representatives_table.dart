import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Representative)
class Representatives extends Table with DefaultTable {
  TextColumn get sageId => text()();
  TextColumn get agencyId => text().references(Agencies, #id)();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  IntColumn get profileCode => integer()();
  TextColumn get profileLabel => text()();
  BoolColumn get isActive => boolean()();
  BoolColumn get canAccessCRM => boolean()();
  BoolColumn get canAccessFair => boolean()();
  BoolColumn get isDirectSale => boolean()();
  TextColumn get appVersion => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  BoolColumn get probationaryPeriodValidation =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get corporateVehicle =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get twoMonthsWith3540BookedMeetings =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get firstIntroductionBeforeMentor =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get twoMonthsWith15OpportunityRequests =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get aloneOnFirstSale =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get firstSaleAtFair =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get aloneOn4FundingSales =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get twoMonthsWith20KTurnover =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get aloneOnFirstAdditionalSale =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get aloneOn30KOrMoreTurnoverInOneMonth =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get soldTwoProductsInOneSale =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
