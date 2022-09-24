import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static late DatabaseHelper _databasrHelper;
  factory DatabaseHelper() {
    if (_database == null) {
      _databasrHelper = DatabaseHelper.internal();
      return _databasrHelper;
    } else {
      return _databasrHelper;
    }
  }
  DatabaseHelper.internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await initilazeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  istenenial(String givencity, String giventime) async {
    List<Map> deneme = [];
    var db = await _getDatabase();
    var ilcedb = await db.query("submdata");
    print("bekle be adam");
    for (var a = 0; a < ilcedb.length; a++) {
      if (ilcedb[a]["field3"] == givencity) {
        if (ilcedb[a]["field4"] == giventime) {
          deneme.add(ilcedb[a]);
          print(ilcedb[a]);
        }
      }
    }
    print("deneme      $deneme");
    if (deneme.isEmpty) {
      deneme.add({
        "field1": "",
        "field2": "",
        "field3": "    There is not any outage ",
        "field4": ""
      });
    }
    return deneme;
  }
}

Future<Database> initilazeDatabase() async {
  Database _db;
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "gdzdeneme.db");

// Check if the database exists
  var exists = await databaseExists(path);

  if (!exists) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");
    print("olusucak path $path");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "gdzdeneme.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }

// open the database
  _db = await openDatabase(path, readOnly: true);
  return _db;
}
