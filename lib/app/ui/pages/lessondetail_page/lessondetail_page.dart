import 'dart:developer';

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
                IconButton(
                  onPressed: () async {
                    if (controller.isPlaying.value) {
                      controller.stop();
                    } else {
                      await controller.play();
                    }
                  },
                  icon: Icon(controller.isPlaying.value
                      ? Icons.stop
                      : Icons.play_arrow),
                ),
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
                    }),
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
                  return Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Get.theme.colorScheme.primary.withAlpha(50),
                          ),
                        ),
                        color: index == controller.currentIndex.value
                            ? Get.theme.colorScheme.primaryContainer
                                .withAlpha(100)
                            : null,
                      ),
                      child: ExpansionTile(
                        shape: Border(
                          top: BorderSide(
                            color: Get.theme.colorScheme.primary.withAlpha(0),
                          ),
                          bottom: BorderSide(
                            color: Get.theme.colorScheme.primary.withAlpha(0),
                          ),
                        ),
                        splashColor:
                            Get.theme.colorScheme.primary.withAlpha(50),
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
                                speak(currentVocab);
                              },
                              icon: Obx(
                                () => Icon(
                                  Icons.speaker,
                                  color: index == controller.currentIndex.value
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        children: [
                          currentVocab.kanji != ''
                              ? ListTile(
                                  onTap: () {
                                    log("Note: ${currentVocab.kanji}");
                                  },
                                  leading: Text(""),
                                  title: Text("Kanji"),
                                  subtitle: Text(currentVocab.kanji),
                                )
                              : SizedBox.shrink(),
                          currentVocab.note != null && currentVocab.note != ""
                              ? ListTile(
                                  onTap: () {
                                    log("Note: ${currentVocab.note}");
                                  },
                                  leading: Text(""),
                                  title: Text("Note"),
                                  subtitle: Text(currentVocab.note ?? ""),
                                )
                              : SizedBox.shrink(),
                          currentVocab.example != null &&
                                  currentVocab.example != ""
                              ? ListTile(
                                  leading: Text(""),
                                  title: Text("Example"),
                                  subtitle: Text(currentVocab.example ?? ""),
                                )
                              : SizedBox.shrink(),
                          currentVocab.sameMeaningVocabs.isEmpty
                              ? SizedBox.shrink()
                              : Text(
                                  "Same Meaning Vocabularies",
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: currentVocab.sameMeaningVocabs
                                .map((e) => Chip(
                                      label: Text(e.kana),
                                    ))
                                .toList(),
                          ),
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.EDITVOCAB,
                                      arguments: [currentVocab,controller.viewVocabs]);
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ],
                      ),
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
