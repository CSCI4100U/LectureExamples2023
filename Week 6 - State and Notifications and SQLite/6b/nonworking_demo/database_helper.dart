import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';

class DatabaseHelper {
  late Database _database;

  DatabaseHelper() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'user_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  Future<User?> getRecentUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isEmpty) return null;

    final user = User.fromMap(maps.last);
    return user;
  }

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      await _initDatabase();
      return _database;
    }
  }
}