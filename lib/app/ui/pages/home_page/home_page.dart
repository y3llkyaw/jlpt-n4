import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/card_button.dart';
import 'package:n4/app/ui/global_widgets/list_card.dart';
import 'package:n4/app/ui/global_widgets/word_of_the_day.dart';
import 'package:n4/app/ui/pages/review_page/review_page.dart';
import 'package:n4/app/ui/pages/setting_page/setting_page.dart';

import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var congrat =
        Vocabulary(0, 0, 'Congratulations!', '', 'fjalsdjf', '', '', '');
    return Scaffold(
      body: SafeArea(
        child: Obx(() => [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(
                          "Featuring Cards",
                          style: Get.textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Learning Category",
                          style: Get.textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(AppRoutes.VOCAB_PAGE);
                        },
                        shape: Border(
                          bottom: BorderSide(
                              color: Get.theme.colorScheme.outlineVariant),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        leading: CircleAvatar(child: Icon(Icons.book)),
                        title: Text(
                          "Vocabulary",
                          style: Get.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                            "learn Vocabulary and take a quiz. It will be in review session when the time is right"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                      ListTile(
                        onTap: () {},
                        shape: Border(
                          bottom: BorderSide(
                              color: Get.theme.colorScheme.outlineVariant),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        leading: CircleAvatar(child: Icon(Icons.brush)),
                        title: Text(
                          "Kanji",
                          style: Get.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                            "learn Vocabulary and take a quiz. It will be in review session when the time is right"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              ),
              ReviewPage(),
              SettingPage(),
            ][controller.index.value]),
      ),
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
