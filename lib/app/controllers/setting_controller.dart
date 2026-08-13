
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/services/theme_service.dart';

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
}