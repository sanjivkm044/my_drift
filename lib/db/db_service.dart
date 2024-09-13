import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:my_drift/db/db_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'db_service.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbdirectory = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbdirectory.path, 'db.sqflite'),);
      return NativeDatabase(file);
    },
  );
}

@DriftDatabase(tables: [User],daos: [UserDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  
}
