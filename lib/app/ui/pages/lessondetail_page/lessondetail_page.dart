import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/data/models/enums.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/utils/util.dart';

class LessondetailPage extends GetView<LessondetailController> {
  const LessondetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Helo"),
    );
    double height = appBar.preferredSize.height;

    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: height * 2.5,
              toolbarHeight: 75,
              centerTitle: true,
              actions: [
                PopupMenuButton(
                    icon: Icon(Icons.quiz),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            Get.toNamed(AppRoutes.VOCAB_TRAINING);
                          },
                          child: Row(
                            spacing: 10,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.quiz),
                              Text("JP-MM"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            Get.toNamed(AppRoutes.VOCAB_TRAINING,
                                arguments: [true]);
                          },
                          child: Row(
                            spacing: 10,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.quiz),
                              Text("MM-JP"),
                            ],
                          ),
                        ),
                      ];
                    })
              ],
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Chapter ${controller.vocabs.isNotEmpty ? controller.vocabs.first.chapter : 0}",
                    // style: Get.textTheme.titleMedium,
                  ),
                  Text(
                    "words ${controller.vocabs.length}",
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
              flexibleSpace: SafeArea(
                child: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(top: height, bottom: 10, left: 10),
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
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(currentVocab.meaning),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.EDITVOCAB,
                                arguments: [currentVocab]);
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
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
