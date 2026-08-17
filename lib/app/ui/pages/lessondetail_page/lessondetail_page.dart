import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/data/models/enums.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/list_card.dart';
import 'package:n4/app/ui/utils/util.dart';

class LessondetailPage extends GetView<LessondetailController> {
  const LessondetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: Text("Helo"),);
    double height = appBar.preferredSize.height;

    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: height*2.5,
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
              flexibleSpace: SafeArea(
                child: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(top: height,bottom: 10, left: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10,
                        children: VocabFilter.values
                            .map(
                              (e) => ChoiceChip(
                                // shape: ,
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
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final currentVocab = controller.viewVocabs[index];
                  return ListTile(
                    onTap: () {
                      speak(currentVocab);
                    },
                    leading: Text("${index + 1}"),
                    title: Text(
                      currentVocab.kana == ''
                          ? currentVocab.kanji
                          : currentVocab.kana,
                      style: Get.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
