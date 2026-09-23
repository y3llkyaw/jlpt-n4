import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:n4/app/data/models/kanji.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._init();
  static Database? _database;

  DatabaseServices._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('manual.db');
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

    return await openDatabase(
      path,
      version: 2,
      onUpgrade: (db, oldVersion, _) async {
        if (oldVersion < 2) {
          await _createSameMeaningTable(db);
        }
      },
    );
  }

  Future<void> _createSameMeaningTable(Database db) {
    return db.execute('''
      CREATE TABLE IF NOT EXISTS same_meaning (
        vocab_id1 INTEGER,
        vocab_id2 INTEGER,
        PRIMARY KEY (vocab_id1, vocab_id2),
        FOREIGN KEY (vocab_id1) REFERENCES vocabularies(id) ON DELETE CASCADE,
        FOREIGN KEY (vocab_id2) REFERENCES vocabularies(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> createKanjiVocabJunction(int kanjiId, int vocabId) async {
    final db = await database;
    await db.insert(
      'kanji_vocabulary',
      {'vocab_id': vocabId, 'kanji_id': kanjiId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> createVocabJunction(int vocabId, int vocabId2) async {
    final db = await database;
    await db.insert(
      'same_meaning',
      {'vocab_id1': vocabId, 'vocab_id2': vocabId2},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    await db.insert(
      'same_meaning',
      {'vocab_id1': vocabId2, 'vocab_id2': vocabId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> synchronizeVocabJunctions(
      int vocabId, Iterable<int> relatedVocabIds) async {
    final db = await database;
    final desiredIds =
        relatedVocabIds.where((relatedId) => relatedId != vocabId).toSet();

    await db.transaction((transaction) async {
      final existingRows = await transaction.query(
        'same_meaning',
        columns: ['vocab_id2'],
        where: 'vocab_id1 = ?',
        whereArgs: [vocabId],
      );
      final existingIds =
          existingRows.map((row) => row['vocab_id2'] as int).toSet();

      for (final relatedId in existingIds.difference(desiredIds)) {
        await transaction.delete(
          'same_meaning',
          where: 'vocab_id1 = ? AND vocab_id2 = ?',
          whereArgs: [vocabId, relatedId],
        );
        await transaction.delete(
          'same_meaning',
          where: 'vocab_id1 = ? AND vocab_id2 = ?',
          whereArgs: [relatedId, vocabId],
        );
      }

      for (final relatedId in desiredIds.difference(existingIds)) {
        await transaction.insert(
          'same_meaning',
          {'vocab_id1': vocabId, 'vocab_id2': relatedId},
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        await transaction.insert(
          'same_meaning',
          {'vocab_id1': relatedId, 'vocab_id2': vocabId},
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    });
  }

  Future<void> deleteVocabJunction(int vocabId, int vocabId2) async {
    final db = await database;
    await db.delete('same_meaning',
        where: 'vocab_id1 = ? AND vocab_id2 = ?',
        whereArgs: [vocabId, vocabId2]);
    await db.delete('same_meaning',
        where: 'vocab_id1 = ? AND vocab_id2 = ?',
        whereArgs: [vocabId2, vocabId]);
  }

  Future<void> deleteKanjiVocabJunction(int kanjiId, int vocabId) async {
    final db = await database;
    await db.delete('kanji_vocabulary',
        where: 'kanji_id = ? AND vocab_id = ?', whereArgs: [kanjiId, vocabId]);
  }

  // Future<List<Vocabulary>> getRelatedVocabs(int vocabId) async {
  //   final db = await instance.database;
  //   final List<Map<String, dynamic>> results = await db.rawQuery('''
  //   SELECT * FROM Vocabularies v
  //   JOIN same_meaning j ON j.vocab_id2 = v.id
  //   WHERE j.vocab_id1 = ?
  // ''', [vocabId]); // The variable replaces the '?' safely
  //   return results.map((e) => Vocabulary.fromMap(e)).toList();
  // }

  Future<List<Vocabulary>> getRelatedVocabsFromVocabs(int vocabId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT * FROM Vocabularies v
    JOIN same_meaning j ON j.vocab_id2 = v.id
    WHERE j.vocab_id1 = ?
  ''', [vocabId]); // The variable replaces the '?' safely
    return results.map((e) => Vocabulary.fromMap(e)).toList();
  }

  Future<List<Vocabulary>> getRelatedVocabsFromKanji(int vocabId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT * FROM Vocabularies v
    JOIN same_meaning j ON j.vocab_id2 = v.id
    WHERE j.vocab_id1 = ?
  ''', [vocabId]); // The variable replaces the '?' safely
    return results.map((e) => Vocabulary.fromMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getVocabulary() async {
    final db = await instance.database;
    return await db.query('vocabularies');
  }

  Future<List<Map<String, dynamic>>> getVocabularyByChapter(int chapter) async {
    final db = await instance.database;
    return await db.query('vocabularies',
        where: 'chapter = ?', whereArgs: [chapter], orderBy: "id");
  }

  Future<int> insertVocabulary(Vocabulary vocab) async {
    final db = await database;
    final data = vocab.toMap();
    data.remove('id');
    return await db.insert('vocabularies', data);
  }

  Future<int> updateVocabulary(Vocabulary vocab) async {
    final db = await database;

    return await db.update(
      'vocabularies',
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

  Future<List<Kanji>> getKanjis(String lvl) async {
    final db = await instance.database;
    final kanjiString = await db.query(
      'kanjis',
      where: 'level = ?',
      whereArgs: [lvl],
    );
    final kanjiList = kanjiString.map((e) => Kanji.fromMap(e)).toList();
    await Future.wait(kanjiList.map((kanji) async {
      kanji.vocabularies = await getRelatedVocabsFromKanji(kanji.id!);
    }));
    return kanjiList;
  }

  Future<void> importDatabase() async {
    // Pick .db file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db'],
    );

    if (result == null || result.files.single.path == null) {
      return; // User cancelled
    }

    final selectedFile = File(result.files.single.path!);

    // Open the selected database temporarily (read-only)
    final importedDb = await openDatabase(
      selectedFile.path,
      readOnly: true,
    );

    try {
      // Verify vocabularies table exists
      final tables = await importedDb.rawQuery('''
        SELECT name
        FROM sqlite_master
        WHERE type = 'table'
        AND name = 'vocabularies'
      ''');

      if (tables.isEmpty) {
        throw Exception('Invalid database: vocabularies table not found');
      }

      // Verify required columns
      final columns = await importedDb.rawQuery(
        'PRAGMA table_info(vocabularies)',
      );
      final columnNames = columns.map((c) => c['name'].toString()).toSet();

      const requiredColumns = {
        'id',
        'chapter',
        'kana',
        'kanji',
        'meaning',
        'part_of_speech',
        'note',
        'example',
      };

      if (!columnNames.containsAll(requiredColumns)) {
        throw Exception(
            'Invalid vocabulary database: missing required columns');
      }

      // Read all rows from the imported DB
      final importedVocs = await importedDb.query('vocabularies');

      // Get the current database and replace all vocabulary entries
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('vocabularies');
        for (final vocab in importedVocs) {
          await txn.insert(
            'vocabularies',
            vocab,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } finally {
      await importedDb.close();
    }
    Get.log('Vocabulary imported successfully');
  }

  Future<List<Vocabulary>> getVocabularyByChapterWithSameMeaning(
      int chapterNumber) async {
    final db = await DatabaseServices.instance.database;

    // 1. Get all vocabularies for the specific chapter
    final vocabMaps = await db.query(
      'vocabularies',
      where: 'chapter = ?',
      whereArgs: [chapterNumber],
    );

    if (vocabMaps.isEmpty) return [];
    final vocabularies = vocabMaps.map((e) => Vocabulary.fromMap(e)).toList();
    await Future.wait(vocabularies.map((vocab) async {
      vocab.sameMeaningVocabs = await getRelatedVocabsFromVocabs(vocab.id!);
    }));
    return vocabularies;
  }

  Future<void> test() async {
    final db = await database;
    final samemeaning = await db.query('same_meaning');
    print('Same Meaning Table: $samemeaning');
  }
}
