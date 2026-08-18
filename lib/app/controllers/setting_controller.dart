import 'dart:io';
import 'package:n4/app/data/services/database_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:n4/app/data/services/theme_service.dart';

class SettingController extends GetxController {
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = ThemeService.instance.themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    final newDarkMode = !isDarkMode.value;
    isDarkMode.value = newDarkMode;

    ThemeService.instance.themeMode =
        newDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void shareDatabase() {
    // SharePlus.instance
    //     .share(ShareParams(text: 'check out my website https://example.com'));
  }

  Future<void> exportDatabase() async {
    final databasesPath = await getDatabasesPath();

    final dbFile = File(
      p.join(databasesPath, 'manual.db'),
    );

    if (!await dbFile.exists()) {
      throw Exception('Database does not exist');
    }

    final tempDir = await getTemporaryDirectory();

    final exportFile = await dbFile.copy(
      p.join(tempDir.path, 'vocabulary.db'),
    );

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(exportFile.path),
        ],
        text: "Vocabulary Databse",
        subject: 'Vocabulary Database',
      ),
    );
  }

  void importDatabase() async {
    try {
      await DatabaseServices.instance.importDatabase();
    } catch (e) {
      if (e == DatabaseException) {}
    }
  }
}
