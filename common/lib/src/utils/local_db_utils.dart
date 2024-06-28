import 'package:maple_common/maple_common.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

// Interface:-------------------------------------------------------------------
abstract class LocalDbUtilsInterface {
  LocalDbUtilsInterface._(this.store, this.dbFactory);

  final StoreRef store;

  Database? db;

  final DatabaseFactory dbFactory;

  Future<void> init();

  Future<T> get<T>(String key);

  Future<RecordSnapshot?> getRecord(String key);

  Future<void> put<T>(String key, T value);

  Future<void> delete(String key);
}

// Implementation:--------------------------------------------------------------
class LocalDbUtils with PrivateDirectoryMixin implements LocalDbUtilsInterface {
  // Services:------------------------------------------------------------------
  @override
  late final store = StoreRef.main();

  @override
  Database? db;

  @override
  late final DatabaseFactory dbFactory = databaseFactoryIo;

  // Methods:-------------------------------------------------------------------
  @override
  Future<void> init() async {
    if (db != null) {
      return;
    }
    // get the application documents directory
    var dir = await privateDirectory;
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    var dbPath = join(dir.path, 'databases/local.db');

    db = await dbFactory.openDatabase(dbPath);
  }

  @override
  Future<T> get<T>(String key) async {
    await init();
    return await store.record(key).get(db!) as T;
  }

  @override
  Future<RecordSnapshot?> getRecord(String key) async {
    await init();
    return await store.record(key).getSnapshot(db!);
  }

  @override
  Future<void> put<T>(String key, T value) async {
    await init();
    await store.record(key).put(db!, value);
  }

  @override
  Future<void> delete(String key) async {
    await init();
    await store.record(key).delete(db!);
  }
}
