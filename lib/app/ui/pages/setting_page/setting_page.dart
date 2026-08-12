import 'package:animated_emoji/animated_emoji.dart';
import 'package:animated_emoji/emoji.dart';
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
        children: [
          Obx(
            () => SwitchListTile(
              secondary: Icon(Icons.light_mode_outlined),
              title: Text(controller.isDarkMode.value ? 'Dark mode' : 'Light mode'),
              value: controller.isDarkMode.value,
              onChanged: (_) => controller.toggleTheme(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add Vocabulary"),
            onTap: () {
              Get.toNamed(AppRoutes.EDITVOCAB);
            },
          ),
          ListTile(
            leading: Icon(Icons.import_export),
            title: Text("Import Database"),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share Your Database with Friends"),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("About this app"),
            ),
          ),
        ],
      ),
    );
  }
}
