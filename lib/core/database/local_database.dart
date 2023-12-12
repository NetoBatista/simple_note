import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase instance = LocalDatabase._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    return await openDatabase(
      'simple_note.db',
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createDatabase(db);
  }

  Future<void> _createDatabase(Database db) async {
    await db.execute(
      '''
      CREATE TABLE note (
        id INTEGER PRIMARY KEY, 
        title TEXT, 
        content TEXT,
        date INTEGER
      )
      ''',
    );
  }
}
