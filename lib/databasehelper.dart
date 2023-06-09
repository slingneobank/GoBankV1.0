import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'image_urls.db';
  static const _databaseVersion = 1;

  static const table = 'image_urls';
  static const banner= 'banner_urls';

  static const BannerLiveurl='bannerliveurl';
  static const BannerLocalurl='bannerlocalurl';

  static const columnLiveUrl = 'liveUrl';
  static const columnLocalUrl = 'localUrl';

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

      await db.execute('''
      CREATE TABLE $banner (
        $BannerLiveurl TEXT NOT NULL,
        $BannerLocalurl TEXT NOT NULL
      )
      ''');
  }

  

  Future<List<Map<String, dynamic>>> getImageUrls() async {
    final db = await database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> getbannerImageUrls() async {
    final db = await database;
    return await db.query(banner);
  }


// Future<List<Map<String, dynamic>>> getbannerImageUrls() async {
//   final db = await database;
//   final List<Map<String, dynamic>> allRows = await db.query(banner);
//   final List<Map<String, dynamic>> filteredRows = [];
  
//   for (final row in allRows) {
//     if (row[BannerLiveurl] == '') {
//       filteredRows.add(row);
//     }
//   }
  
//   return filteredRows;
// }



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


  Future<void> insertbannerImageUrl(String liveurlbanner, String localurlbanner) async {
    final db = await database;

    // Check if the URL already exists in the table
    final List<Map<String, dynamic>> existingUrls = await db.query(
      banner,
      where: '$BannerLiveurl = ?',
      whereArgs: [liveurlbanner],
    );

    if (existingUrls.isEmpty) {
      // If the URL does not exist, insert it into the table
      await db.insert(banner, {
        BannerLiveurl: liveurlbanner,
        BannerLocalurl: localurlbanner,
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
