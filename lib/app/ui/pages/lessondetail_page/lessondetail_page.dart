import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/data/models/enums.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/list_card.dart';

class LessondetailPage extends GetView<LessondetailController> {
  const LessondetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 200,
      //   centerTitle: true,
      //   title: Column(
      //     spacing: 10,
      //     children: [
      //       Row(
      //         spacing: 10,
      //         children: [
      //           IconButton(
      //             onPressed: () {
      //               Get.back();
      //             },
      //             icon: Icon(Icons.arrow_back),
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Obx(() => Text("Chapter ${controller.vocabs.first.chapter}",
      //                   style: Get.textTheme.titleLarge)),
      //               Obx(() => Text("words ${controller.vocabs.length}",
      //                   style: Get.textTheme.bodyMedium)),
      //             ],
      //           ),
      //           Spacer(),
      //           FilledButton.icon(
      //             onPressed: () {
      //               Get.toNamed(AppRoutes.VOCAB_TRAINING);
      //             },
      //             label: Text("Quiz"),
      //             icon: Icon(Icons.quiz),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: 200,
              toolbarHeight: 75,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chapter ${controller.vocabs.isNotEmpty ? controller.vocabs.first.chapter : 0}",
                        // style: Get.textTheme.titleMedium,
                      ),
                      Text(
                        "words ${controller.vocabs.length}",
                        style: Get.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.VOCAB_TRAINING);
                    },
                    label: Text("Quiz"),
                    icon: Icon(Icons.quiz),
                  )
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 12, right: 12),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    children: VocabFilter.values
                        .map(
                          (e) => ChoiceChip(
                            onSelected: (value) {
                              controller.changeFilter(e);
                            },
                            label: Text("${e.name.capitalize}"),
                            selected: controller.vocabFilter.value == e,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final currentVocab = controller.viewVocabs[index];
                  return ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(
                      currentVocab.kana,
                      style: Get.textTheme.titleMedium,
                    ),
                    subtitle: Text(currentVocab.meaning),
                  );
                },
                childCount: controller.viewVocabs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
