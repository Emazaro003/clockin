import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        matricula TEXT NOT NULL,
        tipoUsuario TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('user', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserByMatricula(String matricula) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'matricula = ?',
      whereArgs: [matricula],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<int> deleteUserByMatricula(String matricula) async {
    Database db = await database;
    return await db.delete(
      'user',
      where: 'matricula = ?',
      whereArgs: [matricula],
    );
  }

  Future<void> deleteAllUsers() async {
    Database db = await database;
    await db.delete('user');
  }

  Future<Map<String, dynamic>> isLoggedIn() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return {};
  }
}
