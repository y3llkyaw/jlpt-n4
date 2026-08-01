import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/card_button.dart';
import 'package:n4/app/ui/pages/review_page/review_page.dart';
import 'package:n4/app/ui/pages/setting_page/setting_page.dart';

import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JLPT N4"),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationVersion: "1.0",
                applicationName: "JLPT N4",
                applicationIcon: Icon(Icons.face),
              );
            },
            icon: Icon(Icons.help_outline),
          )
        ],
      ),
      body: Obx(() => [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    cardButton(
                        text: "Vocabs",
                        icon: Icons.book,
                        onPressed: () {
                          Get.toNamed(AppRoutes.VOCAB_PAGE);
                        }),
                    cardButton(text: "Kenji", icon: Icons.book),
                  ],
                ),
              ],
            ),
            ReviewPage(),
            SettingPage(),
          ][controller.index.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) => controller.changeIndex(value),
          currentIndex: controller.index.value,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.school), label: "Home"),
            BottomNavigationBarItem(
                icon: Badge(
                  label: Text("1", style: Get.textTheme.labelMedium),
                  isLabelVisible: true,
                  child: Icon(Icons.reviews),
                ),
                label: "Review"),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
