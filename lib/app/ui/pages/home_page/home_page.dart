import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/card_button.dart';

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
                  applicationIcon: Icon(Icons.face));
            },
            icon: Icon(Icons.help_outline),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cardButton(text: "Vocabs", icon: Icons.school),
              cardButton(text: "Kenji", icon: Icons.school),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 25,
              itemBuilder: ((context, index) {
                return ListTile(
                  onTap: () => Get.toNamed(AppRoutes.LESSONDETAIL,
                      arguments: 25 + index + 1),
                  title: Text("Lesson ${index + 1 + 25}"),
                );
              }),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 0, items: [
        BottomNavigationBarItem(icon: Icon(Icons.school), label: "Home"),
        BottomNavigationBarItem(
            icon: Badge(
              label: Text("1", style: Get.textTheme.labelMedium),
              isLabelVisible: true,
              child: Icon(Icons.reviews),
            ),
            label: "Review"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
      ]),
    );
  }
}
