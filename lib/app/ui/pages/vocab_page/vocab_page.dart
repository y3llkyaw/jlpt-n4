import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/routes/app_routes.dart';
import '../../../controllers/vocab_page_controller.dart';

class VocabPage extends GetView<VocabPageController> {
  const VocabPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vocabulary"),
      ),
      body: ListView.builder(
        itemCount: 25,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.play_lesson_rounded),
                onTap: () => Get.toNamed(AppRoutes.LESSONDETAIL,
                    arguments: 25 + index + 1),
                title: Text(
                  "Lesson ${index + 1}",
                  style: Get.textTheme.titleMedium,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(),
            ],
          );
        }),
      ),
    );
  }
}
