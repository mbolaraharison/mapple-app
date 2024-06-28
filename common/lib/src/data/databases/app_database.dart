import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:maple_common/maple_common.dart';
import 'package:maple_common/src/data/databases/tables/parameters_table.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

const String appDatabasePath = 'databases/app_database.sqlite';

@DriftDatabase(
  tables: [
    Parameters,
  ],
)
class AppDatabase extends _$AppDatabase with PrivateDirectoryMixin {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Static:--------------------------------------------------------------------
  static Future<AppDatabase> createDatabase() async {
    final dbFolder = await PrivateDirectoryMixin.getPrivateDirectory();
    final file = File(p.join(dbFolder.path, appDatabasePath));
    // Delete the database file.
    if (await file.exists()) {
      await file.delete();
    }

    final database = AppDatabase();
    await database.executor.ensureOpen(database);
    return database;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await PrivateDirectoryMixin.getPrivateDirectory();
    final file = File(p.join(dbFolder.path, appDatabasePath));
    return NativeDatabase.createInBackground(file);
  });
}
