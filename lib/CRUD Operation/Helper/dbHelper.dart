import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
        category TEXT,
        img TEXT )''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future insertData(amount, isIncome, category, img)async{
    Database? db = await database;
    String sql = '''INSERT INTO finance(amount, isIncome, category, img) 
    VALUES(?, ?, ?, ?)''';
    List args = [amount,isIncome,category,img];
    await db!.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> viewAllData() async {
    Database? db = await database;
    String sql = '''SELECT * FROM finance''';
    return await db!.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> getSelectedData(int isIncome) async {
    Database? db = await database;
    String sql = '''SELECT * FROM finance WHERE isIncome = ?''';
    List args = [isIncome];
    return await db!.rawQuery(sql,args);
  }

  Future<void> deleteData(int id) async {
    Database? db = await database;
    String sql = '''DELETE FROM finance WHERE id = ?''';
    List args = [id];
    await db!.rawDelete(sql,args);
  }

  Future<void> updateData(amount, isIncome, category, img, id) async {
    Database? db = await database;
    String sql = '''UPDATE finance 
                  SET amount = ?, isIncome = ?, category = ?, img = ?
                  WHERE id = ?''';
    List args = [amount, isIncome, category, img, id];
    await db!.rawDelete(sql,args);
  }

}

