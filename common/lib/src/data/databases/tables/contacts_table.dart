import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

@UseRowClass(Contact)
class Contacts extends Table with DefaultTable {
  TextColumn get customerId => text().references(Customers, #id)();
  TextColumn get agencyId => text().references(Agencies, #id)();
  TextColumn get civility => textEnum<Civility>()();
  TextColumn get email => text()();
  TextColumn get lastName => text()();
  TextColumn get firstName => text()();
  TextColumn get phone => text()();
  TextColumn get mobilePhone => text()();
  BoolColumn get isDefault => boolean()();
  TextColumn get sageId => text()();
  TextColumn get searchableEmail => text()();
  TextColumn get searchablePhone => text()();
  TextColumn get searchablePhoneWithCode => text()();
  TextColumn get searchableMobilePhone => text()();
  TextColumn get searchableMobilePhoneWithCode => text()();

  @override
  Set<Column> get primaryKey => {id};
}
