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
                shape: Border(
                  bottom:
                      BorderSide(color: Get.theme.colorScheme.outlineVariant),
                ),
                leading: CircleAvatar(
                  child: Icon(Icons.book_rounded),
                ),
                onTap: () => Get.toNamed(AppRoutes.LESSONDETAIL,
                    arguments: 25 + index + 1),
                title: Text(
                  "Lesson ${index + 1 + 25}",
                  style: Get.textTheme.titleMedium,
                ),
                subtitle: Text("words 42."),
                trailing: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.43,
                    ),
                    Text(
                      "43",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
