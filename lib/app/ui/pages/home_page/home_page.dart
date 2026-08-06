import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/card_button.dart';
import 'package:n4/app/ui/pages/review_page/review_page.dart';
import 'package:n4/app/ui/pages/setting_page/setting_page.dart';

import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var congrat = Vocabulary(0, 0, 'Congratulations!', '',
        'You have completed all the cards in this round.', '', '', '');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.secondaryContainer,
        toolbarHeight: 200,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "JLPT N4",
              style: Get.textTheme.headlineLarge,
            ),
            Text(
              "learn japanese with space repetition system learning.",
              style: Get.textTheme.titleSmall,
            ),
          ],
        ),
        
      ),
      body: Obx(() => [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                SizedBox(),
                Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cardButton2(
                        width: Get.width * 0.85,
                        text: "Vocabs",
                        icon: Icons.book,
                        onPressed: () {
                          Get.toNamed(AppRoutes.VOCAB_PAGE);
                        }),
                    cardButton2(
                        width: Get.width * 0.85,
                        text: "Kanji",
                        icon: Icons.book,
                        onPressed: () {
                          Get.toNamed(AppRoutes.VOCAB_PAGE);
                        }),
                    cardButton2(
                        width: Get.width * 0.85,
                        text: "Grammers",
                        icon: Icons.book,
                        onPressed: () {
                          Get.toNamed(AppRoutes.VOCAB_PAGE);
                        }),
                    cardButton2(
                        width: Get.width * 0.85,
                        text: "Old Questions",
                        icon: Icons.book,
                        onPressed: () {
                          Get.toNamed(AppRoutes.VOCAB_PAGE);
                        }),
                    // cardButton(text: "Kenji", icon: Icons.book),
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
