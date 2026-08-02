import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._init();
  static Database? _database;

  DatabaseServices._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mina1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Check if the database exists
    final exists = await databaseExists(path);

    if (!exists) {
      // If it doesn't exist, copy it from the assets folder
      Get.log("**** Creating a copy of the database from assets...");

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
      Get.log("Database already exists.");
    }

    // Open the database
    return await openDatabase(path, version: 1);
  }

  Future<List<Map<String, dynamic>>> getVocabulary() async {
    final db = await instance.database;
    return await db.query('vocabulary');
  }

  Future<List<Map<String, dynamic>>> getVocabularyByChapter(int chapter) async {
    final db = await instance.database;
    return await db.query('vocabulary',
        where: 'chapter = ?', whereArgs: [chapter], orderBy: "id");
  }

  Future<int> insertVocabulary(Vocabulary vocab) async {
    final db = await database;
    final data = vocab.toMap();
    data.remove('id');
    return await db.insert('vocabulary', data);
  }

  Future<int> updateVocabulary(Vocabulary vocab) async {
    final db = await database;

    return await db.update(
      'vocabulary',
      {
        'chapter': vocab.chapter,
        'kana': vocab.kana,
        'kanji': vocab.kanji,
        'meaning': vocab.meaning,
        'part_of_speech': vocab.partOfSpeech,
        'note': vocab.note,
        'example': vocab.example,
      },
      where: 'id = ?',
      whereArgs: [vocab.id],
    );
  }

  Future<int> deleteVocabulary(int id) async {
    final db = await database;
    return await db.delete(
      'vocabulary',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
