import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/services/database_services.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/kanji_card.dart';
import 'package:n4/app/ui/global_widgets/word_of_the_day.dart';
import 'package:n4/app/ui/pages/review_page/review_page.dart';
import 'package:n4/app/ui/pages/setting_page/setting_page.dart';
import 'package:n4/app/ui/utils/util.dart';

import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nihon GO"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() => [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          "Stats",
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: Card(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.35,
                                    height: Get.width * 0.35,
                                    child: PieChart(
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            showTitle: false,
                                            value: 10,
                                            color: Colors.green,
                                          ),
                                          PieChartSectionData(
                                            showTitle: false,
                                            value: 30,
                                            color: Colors.lightGreen,
                                          ),
                                          PieChartSectionData(
                                            showTitle: false,
                                            value: 10,
                                            color: Colors.amber,
                                          ),
                                          PieChartSectionData(
                                            showTitle: false,
                                            value: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text("Stats")
                                ],
                              ),
                              Column(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    spacing: 20,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.green,
                                      ),
                                      Text("Well Known")
                                    ],
                                  ),
                                  Row(
                                    spacing: 20,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.lightGreen,
                                      ),
                                      Text("Familier")
                                    ],
                                  ),
                                  Row(
                                    spacing: 20,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.amber,
                                      ),
                                      Text("Just Learned")
                                    ],
                                  ),
                                  Row(
                                    spacing: 20,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.grey,
                                      ),
                                      Text("Unlearned")
                                    ],
                                  ),
                                  SizedBox(),
                                  FilledButton.tonalIcon(
                                    icon: Icon(Icons.bar_chart),
                                    onPressed: () async {
                                      await DatabaseServices.instance.test();
                                    },
                                    label: Text("Detail"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Daily Kanji and Vocab",
                          style: Get.textTheme.bodyLarge,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            controller.randomRefresh();
                          },
                          child: Text("refresh"),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  speak(controller.randomVocab.value!);
                                },
                                child: WordOfTheDay(
                                  vocab: controller.randomVocab.value,
                                ),
                              ),
                              Obx(
                                () => controller.kvg.value == null
                                    ? Card(
                                        child: Container(
                                          height: Get.width * 0.4,
                                          width: Get.width * 0.4,
                                        ),
                                      )
                                    : Obx(
                                        () => KanjiCard(
                                          kvg: controller.kvg.value!,
                                          kanji: controller.randomKanji.value!,
                                        ),
                                      ),
                              )
                            ],
                          ),
                          ListTile(
                            title: Text(
                              "Learning Category",
                              style: Get.textTheme.bodyLarge,
                            ),
                          ),
                          Card(
                            elevation: 0,
                            child: Column(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    Get.toNamed(AppRoutes.VOCAB_PAGE);
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        child: Icon(Icons.translate)),
                                    title: Text("Vocabulary"),
                                    subtitle:
                                        Text("learn vocabs and take a quiz."),
                                    trailing: Icon(Icons.chevron_right),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () async {
                                    Get.toNamed(AppRoutes.KANJI_BROWSE);
                                  },
                                  child: ListTile(
                                    leading:
                                        CircleAvatar(child: Icon(Icons.brush)),
                                    title: Text("Kanji"),
                                    subtitle:
                                        Text("learn kanji and take a quiz."),
                                    trailing: Icon(Icons.chevron_right),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Badge(
                  label: Text("1",
                      style: Get.textTheme.labelMedium!
                          .copyWith(color: Get.theme.colorScheme.onError)),
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
