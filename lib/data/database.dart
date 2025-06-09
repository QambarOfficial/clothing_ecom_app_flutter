import 'package:hive_flutter/hive_flutter.dart';

class AddressStorage {
  static final AddressStorage _instance = AddressStorage._internal();

  factory AddressStorage() => _instance;

  AddressStorage._internal();

  final Box _box = Hive.box('addresses');

  Future<bool> hasAddresses() async {
    return _box.isNotEmpty;
  }

  /// Returns the Hive key assigned to this entry
  Future<int> addAddress({
    required String street,
    required String city,
    required String state,
    required String zip,
  }) async {
    final Map<String, String> data = {
      'street': street,
      'city': city,
      'state': state,
      'zip': zip,
    };
    // box.add auto-increments a 32-bit int key
    int key = await _box.add(data);
    return key;
  }

  Future<void> deleteAddress(int key) async {
    await _box.delete(key);
  }

  Future<List<Map<String, dynamic>>> getAllAddresses() async {
    final List<Map<String, dynamic>> addresses = [];
    for (var key in _box.keys.cast<int>()) {
      final value = _box.get(key);
      if (value is Map) {
        addresses.add({'id': key, ...Map<String, dynamic>.from(value)});
      }
    }
    return addresses;
  }

  Future<void> close() async {
    await _box.close();
  }
}

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;
//
//   DatabaseHelper._init();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('addresses.db');
//     return _database!;
//   }
//
//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//
//     return await openDatabase(path, version: 1, onCreate: (db, version) {
//       return db.execute(
//         '''
//         CREATE TABLE addresses(
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           street TEXT NOT NULL,
//           city TEXT NOT NULL,
//           state TEXT NOT NULL,
//           zip TEXT NOT NULL
//         )
//         ''',
//       );
//     });
//   }
//
//   Future<bool> hasAddresses() async {
//     final db = await database;
//     final result = await db.query('addresses');
//     return result.isNotEmpty;
//   }
//
//   Future<int> addAddress(
//       String street, String city, String state, String zip) async {
//     final db = await database; // Ensure the database is initialized and opened
//     return await db.insert('addresses',
//         {'street': street, 'city': city, 'state': state, 'zip': zip});
//   }
//
//   Future<int> deleteAddress(int id) async {
//     final db = await instance.database;
//     return await db.delete('addresses', where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<List<Map<String, dynamic>>> getAllAddresses() async {
//     final db = await database;
//     final List<Map<String, dynamic>> addresses = await db.query('addresses');
//     return addresses;
//   }
//
//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
