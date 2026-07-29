import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._init();
  static Database? _database;

  DatabaseServices._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('n4_vocabulary.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Check if the database exists
    final exists = await databaseExists(path);

    if (!exists) {
      // If it doesn't exist, copy it from the assets folder
      print("Creating a copy of the database from assets...");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from assets
      ByteData data = await rootBundle.load(join("assets/data/", filePath));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and save the file
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Database already exists.");
    }

    // Open the database
    return await openDatabase(path, version: 1);
  }

  // Fetch all vocabulary
  Future<List<Map<String, dynamic>>> getVocabulary() async {
    final db = await instance.database;
    return await db.query('n4_vocabulary');
  }

  // Fetch vocabulary for a specific chapter (e.g., chapter 1)
  Future<List<Map<String, dynamic>>> getVocabularyByChapter(int chapter) async {
    final db = await instance.database;
    return await db.query(
      'n4_vocabulary',
      where: 'chapter = ?',
      whereArgs: [chapter],
      orderBy: "id"
    );
  }
}
