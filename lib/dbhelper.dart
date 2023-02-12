// ignore_for_file: prefer_const_declarations

// import 'dart:html';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:crypt/crypt.dart';

class DatabaseHelper {
  static final _databaseName = "FamilyMeet2.db";
  static final _databaseVersion = 1;

  static final table = 'event';
  static final tableUser = 'users';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnDescription = 'description';
  static final columnDate = 'date';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database as Database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database as Database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(String name, String description, DateTime date) async {
    Database db = await instance.database;
    return await db.insert(table,
        {'name': name, 'description': description, "date": date.toString()});
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future _CreateTableUser(Database db) async {
    await db.execute('''
          CREATE TABLE $tableUser (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            "email" TEXT NOT NULL,
            "password" TEXT NOT NULL
          )
          ''');
  }

  Future<bool> verifyUser(
      Database db, String password, String email, String Name) async {
    // final h = Crypt(hashString);
    db.query(tableUser, where: "$columnName = $Name OR email = $email");
    return true;
  }

  Future<int> insertUser(String name, String password, String email) async {
    Database db = await instance.database;
    return await db
        .insert(table, {'name': name, 'email': email, "password": password});
  }
}
