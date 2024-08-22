import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future get database async => _db ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'finance.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE finance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        isIncome INTEGER NOT NULL,
        category TEXT)''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future insertData()async{
    Database? db = await database;
    String sql = '''INSERT INTO finance(amount, isIncome, category) 
    VALUES(250, 50, "Shirt")''';
    await db!.rawInsert(sql);
  }

}

