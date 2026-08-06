import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/list_card.dart';

class LessondetailPage extends GetView<LessondetailController> {
  const LessondetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        centerTitle: true,
        title: Column(
          spacing: 20,
          children: [
            Obx(() => Text("Total Vocabs ${controller.vocabs.length}")),
            ElevatedButton.icon(
              label: Text("Take The Quiz"),
              onPressed: () {
                Get.toNamed(AppRoutes.VOCAB_TRAINING);
              },
              icon: Icon(Icons.help_outline),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          spacing: 50,
          children: [
            SizedBox(),
            SizedBox(),
            SizedBox(),
            SizedBox(
              height: Get.height * 0.35,
              child: Obx(
                () => CardSwiper(
                  allowedSwipeDirection: AllowedSwipeDirection.only(
                    left: true,
                    right: true,
                  ),
                  isLoop: true,
                  cardBuilder: (context, index, horizontalOffsetPercentage,
                          verticalOffsetPercentage) =>
                      listCard(
                    controller.vocabs[index],
                    index,
                    controller.vocabs,
                    isBack: true,
                  ),
                  cardsCount: controller.vocabs.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
