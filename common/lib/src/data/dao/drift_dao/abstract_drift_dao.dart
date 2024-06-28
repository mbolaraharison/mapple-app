import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';

abstract class AbstractDriftDao<T, R extends Table, D extends GeneratedDatabase>
    extends DatabaseAccessor<D> {
  final R table;
  final D db;

  AbstractDriftDao(this.db, this.table) : super(db);

  // Query methods:-------------------------------------------------------------
  Future<T?> findById(String id) =>
      (select(table as ResultSetImplementation<HasResultSet, T>)
            ..where((t) => (t as dynamic).id.equals(id)))
          .getSingleOrNull();

  SimpleSelectStatement<R, T> _queryByIds(List<String> ids) {
    return (select(table as ResultSetImplementation<R, T>)
      ..where((t) => (t as dynamic).id.isIn(ids)));
  }

  Future<List<T>> findByIds(List<String> ids) {
    return _queryByIds(ids).get();
  }

  Future<List<T>> findAllByAgencyIdOrNullAgencyId(String agencyId) {
    return Future.value([]);
  }

  Stream<T?> findByIdAsStream(String id) =>
      (select(table as ResultSetImplementation<HasResultSet, T>)
            ..where((t) => (t as dynamic).id.equals(id)))
          .watchSingleOrNull();

  Stream<List<T>> findByIdsAsStream(List<String> ids) {
    return _queryByIds(ids).watch();
  }

  Future<T?> findFirst() =>
      (select(table as ResultSetImplementation<HasResultSet, T>)..limit(1))
          .getSingleOrNull();

  Future<List<T>> findAll() =>
      select(table as ResultSetImplementation<HasResultSet, T>).get();

  Stream<T?> findFirstAsStream() =>
      (select(table as ResultSetImplementation<HasResultSet, T>)..limit(1))
          .watchSingleOrNull();

  Stream<List<T>> findAllAsStream() =>
      select(table as ResultSetImplementation<HasResultSet, T>).watch();

  // Write methods:-------------------------------------------------------------
  Future<void> daoCreate(T model) =>
      into(table as TableInfo<Table, T>).insert(model as dynamic);

  Batch daoBatchCreate(Batch b, T model) {
    b.insert(table as TableInfo<Table, T>, model as dynamic);
    return b;
  }

  Batch daoBatchCreateOrUpdate(Batch b, T model) {
    b.insert(table as TableInfo<Table, T>, model as dynamic,
        mode: InsertMode.insertOrReplace);
    return b;
  }

  Batch daoBatchUpdate(Batch b, T model) {
    b.update(
      table as TableInfo<Table, T>,
      model as dynamic,
      where: (table) => (table as dynamic).id.equals((model as dynamic).id),
    );
    return b;
  }

  Batch daoBatchDelete(Batch b, T model) {
    b.delete(table as TableInfo<Table, T>, model as dynamic);
    return b;
  }

  Future<void> daoCreateOrUpdate(T model) => into(table as TableInfo<Table, T>)
      .insert(model as Insertable<T>, mode: InsertMode.insertOrReplace);

  Future<void> daoCreateOrUpdateAll(List<T> models) => batch((batch) {
        batch.insertAll(
            table as TableInfo<Table, T>, models as List<Insertable<T>>,
            mode: InsertMode.insertOrReplace);
      });

  Future<bool> daoUpdate(T model) =>
      update(table as TableInfo<Table, T>).replace(model as Insertable<T>);

  Future<void> daoDelete(T model) =>
      delete(table as TableInfo<Table, T>).delete(model as Insertable<T>);

  Future<void> daoSoftDelete(T model) {
    if (model is AbstractIsSoftDeletable) {
      model.delete();
      return daoUpdate(model);
    }
    return Future.value();
  }

  Future<void> daoDeleteAll() => delete(table as TableInfo<Table, T>).go();
}
