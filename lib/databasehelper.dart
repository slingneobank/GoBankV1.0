import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final _databaseName = 'image_urls.db';
  static final _databaseVersion = 1;

  static final table = 'image_urls';
  static final columnUrl = 'url';

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
        
        $columnUrl TEXT NOT NULL
      )
      ''');
  }

  Future<List<String>> getImageUrls() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    
    return List.generate(maps.length, (i) => maps[i][columnUrl] as String);
  }

  Future<void> insertImageUrl(String url) async {
    final db = await database;
    await db.insert(table, {columnUrl: url},
        conflictAlgorithm: ConflictAlgorithm.replace);
        
  }
}
