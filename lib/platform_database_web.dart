import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> initializeDatabasePlatformImpl() async {
  // CONNECTION: Use SQLite/WASM and IndexedDB without a generated worker.
  databaseFactory = databaseFactoryFfiWebNoWebWorker;
}
