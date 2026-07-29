import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/ui/global_widgets/list_card.dart';

class LessondetailPage extends GetView<LessondetailController> {
  const LessondetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lessons ${Get.arguments}"),
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.vocabs.length,
                itemBuilder: (context, index) {
                  // return ExpansionTile(
                  //   leading: Text("# ${index + 1}"),
                  //   title: Text(
                  //     controller.vocabs[index].kana,
                  //     style: Get.textTheme.titleLarge!.copyWith(
                  //         color: Get.theme.colorScheme.primary,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(controller.vocabs[index].meaning),
                  //     ),
                  //   ],
                  // );
                  return listCard(controller.vocabs[index],index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
