import 'dart:io';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initializeDB();
    return _database;
  }

  static Future<Database> initializeDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "places.db");
    return await sql.openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE places ("
            "id TEXT PRIMARY KEY,"
            "title TEXT,"
            "image TEXT,"
            "loc_lat REAL,"
            "loc_lng REAL,"
            "address TEXT"
            ")");
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    var db = await DBHelper.database;
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    var db = await DBHelper.database;
    return db.query(table);
  }
}
