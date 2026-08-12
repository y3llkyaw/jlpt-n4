
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/services/theme_service.dart';

class SettingController extends GetxController {
  final _storage = GetStorage();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();

    final savedMode = _storage.read('is_dark_mode');
    isDarkMode.value = savedMode ?? Get.isDarkMode;

    final themeMode = isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    ThemeService.instance.themeMode = themeMode;
  }

  void toggleTheme() {
    final newDarkMode = !isDarkMode.value;
    isDarkMode.value = newDarkMode;
    _storage.write('is_dark_mode', newDarkMode);

    ThemeService.instance.themeMode =
        newDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}