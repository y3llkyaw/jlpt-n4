import 'package:animated_emoji/animated_emoji.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: AnimatedEmoji(
              AnimatedEmojis.gear,
              size: 50,
            ),
          ),
          Spacer(),
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
