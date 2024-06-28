import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

part 'note_drift_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NoteDriftDao extends AbstractDriftDao<Note, $NotesTable, AgencyDatabase>
    with _$NoteDriftDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  NoteDriftDao(AgencyDatabase db) : super(db, db.notes);

  SimpleSelectStatement<$NotesTable, Note> _queryByCustomerId(
      String customerId) {
    return (select(notes)
      ..where((tbl) => tbl.customerId.equals(customerId))
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)
      ]));
  }

  Stream<List<Note>> findByCustomerIdAsStream(String customerId) {
    return _queryByCustomerId(customerId).watch();
  }

  Future<List<Note>> findByCustomerId(String customerId) {
    return _queryByCustomerId(customerId).get();
  }
}
