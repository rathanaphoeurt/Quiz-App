import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'quiz.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE QuizHistory (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT,
      score INTEGER,
      date TEXT,
      time TEXT,
      questions TEXT
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      ALTER TABLE QuizHistory ADD COLUMN time TEXT
      ''');
    }
  }

  Future<int> insertHistory(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('QuizHistory', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await database;
    return await db.query('QuizHistory', orderBy: "date DESC, time DESC");
  }

  Future<int> deleteHistory(int id) async {
    Database db = await database;
    return await db.delete('QuizHistory', where: 'id = ?', whereArgs: [id]);
  }
}
