import 'package:bloc_database_app/models/expenses.dart';
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

    await db.execute('''CREATE TABLE $expensesDB,(
      ${ExpensesFields.id} $idType,
      ${ExpensesFields.amount} $integerType,
      ${ExpensesFields.date} $textType,
    )''');
  }

  //----------------------------------------------------
  Future<Expenses> insertExpenses(Expenses expenses) async {
    final db = await instance.database;
    final id = await db.insert(expensesDB, expenses.toJson());
    return expenses.copy(id: id);
  }

  //----------------------------------------------------
  Future close() async {
    final db = await instance.database;

    db.close();
  }

  //---------------------------------------------
  Future<List<Expenses>> readAllExpenses() async {
    final db = await instance.database;

    const orderBy = '${ExpensesFields.date} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(expensesDB, orderBy: orderBy);

    return result.map((json) => Expenses.fromJson(json)).toList();
  }
}
