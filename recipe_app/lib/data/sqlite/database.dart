import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static const String _dbName = 'favs.sqlite';

  static Future<Database> connectDB() async {
    final dbPath = join(await getDatabasesPath(), _dbName);

    if (await databaseExists(dbPath)) {
      print("database exists");
    } else {
      ByteData data = await rootBundle.load(join('lib/database/$_dbName'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(
        bytes,
        flush: true,
      );
      print("Database copied");
    }
    var db = await openDatabase(dbPath);
    var a = await db.rawQuery("SELECT * from favs");
    return db;
  }
}
