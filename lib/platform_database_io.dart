import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactoryFfi, sqfliteFfiInit;

Future<void> initializeDatabasePlatformImpl() async {
  if (defaultTargetPlatform != TargetPlatform.windows) return;

  // CONNECTION: Use SQLite FFI for Windows desktop persistence.
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final localAppData = Platform.environment['LOCALAPPDATA'];
  if (localAppData == null || localAppData.isEmpty) {
    throw StateError('LOCALAPPDATA is not available on this Windows device.');
  }
  await databaseFactory.setDatabasesPath(
    p.join(localAppData, 'MyStudyPlanner', 'databases'),
  );
}
