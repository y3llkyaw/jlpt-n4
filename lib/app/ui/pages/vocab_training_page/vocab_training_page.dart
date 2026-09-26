import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/vocab_training_controller.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/ui/global_widgets/swipe_card.dart';

class VocabTrainingPage extends GetView<VocabTrainingController> {
  const VocabTrainingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Chapter ${controller.vocabs.first.chapter}"),
            Text(
              "words ${controller.vocabs.length}",
              style: Get.textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.forgotVocabs.isEmpty
                      ? Text(
                          "Congradulations you know all Words !",
                          style: Get.textTheme.titleMedium,
                        )
                      : Text(
                          "Let's Review Forgotten Cards !",
                          style: Get.textTheme.titleMedium,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Badge.count(
                      count: controller.forgotVocabs.length,
                      child: FilledButton.icon(
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(TextStyle(
                            color: Get.theme.colorScheme.onErrorContainer,
                          )),
                          backgroundColor: WidgetStatePropertyAll(
                            Get.theme.colorScheme.errorContainer,
                          ),
                        ),
                        onPressed: () {
                          log("pressed ${controller.reviewVocabs.length}");
                          if (controller.forgotVocabs.isEmpty) {
                            controller.reviewVocabs.value =
                                controller.vocabs.toList();
                            controller.forgotVocabs.clear();
                            controller.knownVocabs.clear();
                          } else {
                            if (controller.forgotVocabs.length == 1) {
                              controller.addForget(
                                Vocabulary(
                                  chapter: -1,
                                  kana: "おめでとうございます。",
                                  kanji: "おめでとう",
                                  meaning: "Congradulation　🥳 !",
                                  partOfSpeech: "🥳",
                                ),
                              );
                            }
                            controller.reviewVocabs.value =
                                controller.forgotVocabs.toList();
                            controller.forgotVocabs.clear();
                          }
                          controller.resetSwiper();
                          controller.isFinished.value = false;
                        },
                        label: Text(controller.forgotVocabs.isEmpty
                            ? "Restart Reviewing Cards"
                            : "Review forgotten Cards"),
                        icon: Icon(Icons.repeat),
                      ),
                    ),
                  ),
                  controller.forgotVocabs.isEmpty
                      ? Center(
                          child: FilledButton.icon(
                            onPressed: () {
                              Get.back();
                            },
                            label: Text("Back To Lesson"),
                            icon: Icon(Icons.arrow_left),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Text("${controller.forgotVocabs.length}"),
                              Text("Forgotten Cards"),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Text("${controller.knownVocabs.length}"),
                              Text("Known Cards"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: CardSwiper(
                      key: ValueKey(controller.resetToken.value),
                      isLoop: false,
                      duration: Duration(milliseconds: 200),
                      controller: controller.cardSwiperController.value,
                      cardsCount: controller.reviewVocabs.length,
                      cardBuilder: (context, index, horizontalOffsetPercentage,
                          verticalOffsetPercentage) {
                        return SwipeCard(
                          index: index + 1,
                          key: ValueKey(controller.reviewVocabs[index].id),
                          vocab: controller.reviewVocabs[index],
                          isReverse: Get.arguments == null ? false : true,
                        );
                      },
                      allowedSwipeDirection: AllowedSwipeDirection.only(
                        left: true,
                        right: true,
                      ),
                      onSwipe: (previousIndex, currentIndex, direction) {
                        if (controller.reviewVocabs[previousIndex].chapter !=
                            -1) {
                          if (direction == CardSwiperDirection.right) {
                            controller.addKnown(
                                controller.reviewVocabs[previousIndex]);
                          }
                          if (direction == CardSwiperDirection.left) {
                            controller.addForget(
                                controller.reviewVocabs[previousIndex]);
                          }
                        }
                        return true;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Get.theme.colorScheme.error)),
                          onPressed: () {
                            controller.cardSwiperController.value
                                .swipe(CardSwiperDirection.left);
                          },
                          icon: Icon(Icons.close),
                        ),
                        IconButton.filled(
                          onPressed: () {
                            controller.cardSwiperController.value
                                .swipe(CardSwiperDirection.right);
                          },
                          icon: Icon(CupertinoIcons.heart_fill),
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
    );
  }
}
