import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'image_urls.db';
  static final _databaseVersion = 1;

  static final table = 'image_urls';
  static final columnLiveUrl = 'liveUrl';
  static final columnLocalUrl = 'localUrl';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnLiveUrl TEXT NOT NULL,
        $columnLocalUrl TEXT NOT NULL
      )
      ''');
  }

  Future<List<Map<String, dynamic>>> getImageUrls() async {
    final db = await database;
    return await db.query(table);
  }

  Future<void> insertImageUrl(String liveUrl, String localUrl) async {
    final db = await database;

    // Check if the URL already exists in the table
    final List<Map<String, dynamic>> existingUrls = await db.query(
      table,
      where: '$columnLiveUrl = ?',
      whereArgs: [liveUrl],
    );

    if (existingUrls.isEmpty) {
      // If the URL does not exist, insert it into the table
      await db.insert(table, {
        columnLiveUrl: liveUrl,
        columnLocalUrl: localUrl,
      });
    }
  }
}

// class DatabaseHelper {
//   static final _databaseName = 'image_urls.db';
//   static final _databaseVersion = 1;

//   static final table = 'image_urls';
//   static final columnUrl = 'url';

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }

//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final documentsDirectory = await getDatabasesPath();
//     final path = join(documentsDirectory, _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _createDatabase);
//   }

//   Future<void> _createDatabase(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $table (
        
//         $columnUrl TEXT NOT NULL
//       )
//       ''');
//   }

// Future<List<Map<String, dynamic>>> getImageUrls() async {
//     final db = await database;
//     return await db.query(table);
//   }

// Future<void> insertImageUrl(String url) async {
//   final db = await database;

//   // Check if the URL already exists in the table
//   final List<Map<String, dynamic>> existingUrls = await db.query(
//     table,
//     where: '$columnUrl = ?',
//     whereArgs: [url],
//   );

//   if (existingUrls.isEmpty) {
//     // If the URL does not exist, insert it into the table
//     await db.insert(table, {columnUrl: url},
//         conflictAlgorithm: ConflictAlgorithm.ignore);
//   }
// }




// }
