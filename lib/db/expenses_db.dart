import 'package:bloc_database_app/models/expenses.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static final ExpensesDatabase instance = ExpensesDatabase._init();

  static Database? _database;

  ExpensesDatabase._init();
  //---------------------------------------------
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('expenses.db');
    return _database!;
  }

  //----------------------------------------------------
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  //----------------------------------------------------
  Future _createDb(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $expensesDB (
      ${ExpensesFields.id} $idType,
      ${ExpensesFields.amount} $integerType,
      ${ExpensesFields.date} $textType
    )''');
  }

  //----------------------------------------------------
  Future<Expenses> insertExpenses(Expenses expenses) async {
    final db = await instance.database;
    final id = await db.insert(expensesDB, expenses.toJson());
    if (kDebugMode) {
      print("insertExpenses:id:$id");
    }
    return expenses.copy(id: id);
  }

  //----------------------------------------------------
  Future close() async {
    final db = await instance.database;
    await db.close();
  }

  //---------------------------------------------
  Future<List<Expenses>> readAllExpenses(DateTime dateTime) async {
    final db = await instance.database;

    const where =
        'strftime("%m", ${ExpensesFields.date}) = ? AND strftime("%Y", ${ExpensesFields.date}) = ?';
    const orderBy = '${ExpensesFields.date} ASC';
    //   final result = await db.rawQuery('''
    //   SELECT * FROM $expensesDB
    //   WHERE strftime('%m', ${ExpensesFields.date}) = ?
    //   AND strftime('%Y', ${ExpensesFields.date}) = ?
    // ''', ['4', '2024']);

    final result = await db.query(
      expensesDB,
      orderBy: orderBy,
      where: where,
      whereArgs: ['${dateTime.month}'.padLeft(2, '0'), '${dateTime.year}'],
    );
    if (kDebugMode) {
      print("readAllExpenses:result:$result");
    }

    return result.map((json) => Expenses.fromJson(json)).toList();
  }
}
