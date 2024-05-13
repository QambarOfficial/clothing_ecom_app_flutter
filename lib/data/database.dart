import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('addresses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE addresses(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          street TEXT NOT NULL,
          city TEXT NOT NULL,
          state TEXT NOT NULL,
          zip TEXT NOT NULL
        )
        ''',
      );
    });
  }

  Future<bool> hasAddresses() async {
    final db = await database;
    final result = await db.query('addresses');
    return result.isNotEmpty;
  }

  Future<int> addAddress(
      String street, String city, String state, String zip) async {
    final db = await database; // Ensure the database is initialized and opened
    return await db.insert('addresses',
        {'street': street, 'city': city, 'state': state, 'zip': zip});
  }

  Future<int> deleteAddress(int id) async {
    final db = await instance.database;
    return await db.delete('addresses', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllAddresses() async {
    final db = await database;
    final List<Map<String, dynamic>> addresses = await db.query('addresses');
    return addresses;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
