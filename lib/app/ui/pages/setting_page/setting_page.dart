import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/setting_controller.dart';
import '../../../routes/app_routes.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preferences",
          ),
          Card(
            elevation: 0,
            child: Column(
              children: [
                Obx(
                  () => SwitchListTile(
                    secondary: Icon(Icons.light_mode_outlined),
                    title: Text(controller.isDarkMode.value
                        ? 'Dark mode'
                        : 'Light mode'),
                    value: controller.isDarkMode.value,
                    onChanged: (_) => controller.toggleTheme(),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    leading: Icon(CupertinoIcons.book),
                    title: Text("Change JLPT Level"),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Data Management",
          ),
          Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: Icon(Icons.add),
                  title: Text("Add New Vocabulary"),
                  onTap: () {
                    Get.toNamed(AppRoutes.EDITVOCAB);
                  },
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: Icon(Icons.add),
                  title: Text("Add New Kanji"),
                  onTap: () {
                    Get.toNamed(AppRoutes.EDIT_KANJI);
                  },
                ),
                InkWell(
                  onTap: () {
                    controller.importDatabase();
                  },
                  child: ListTile(
                    leading: Icon(Icons.file_open_sharp),
                    title: Text("Import Vocabulary"),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    controller.exportDatabase();
                  },
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text("Share your Database"),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "System",
          ),
          Card(
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                showLicensePage(context: context);
              },
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About this app"),
                subtitle: Text("version 1.0.1"),
              ),
            ),
          ),
          Center(
            child: Text("Developed by Ye Htet Kyaw"),
          ),
        ],
      ),
    );
  }
}
