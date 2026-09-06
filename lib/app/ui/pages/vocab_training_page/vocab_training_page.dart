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
          () => controller.isFinished.value
              ? Column(
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
                          onPressed: () {
                            if (controller.forgotVocabs.isEmpty) {
                              // No forgotten cards, nothing to reset
                              controller.reviewVocabs.value =
                                  controller.vocabs.toList();
                              controller.forgotVocabs.clear();
                              controller.knownVocabs.clear();
                              controller.cardSwiperController.value =
                                  CardSwiperController();
                              controller.isFinished.value = false;
                            } else {
                              // Move forgotten cards back to review stack and reset swiper
                              controller.reviewVocabs.value =
                                  controller.forgotVocabs.toList();
                              controller.forgotVocabs.clear();
                              controller.cardSwiperController.value =
                                  CardSwiperController();
                              controller.isFinished.value = false;
                            }
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
                )
              : Column(
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
                        isLoop: false,
                        duration: Duration(milliseconds: 200),
                        controller: controller.cardSwiperController.value,
                        cardsCount: controller.reviewVocabs.length,
                        cardBuilder: (context,
                            index,
                            horizontalOffsetPercentage,
                            verticalOffsetPercentage) {
                          return SwipeCard(
                            index: index + 1,
                            key: ValueKey(controller.reviewVocabs[index].id),
                            vocab: controller.vocabs[index],
                            isReverse: Get.arguments == null ? false : true,
                          );
                        },
                        allowedSwipeDirection: AllowedSwipeDirection.only(
                          left: true,
                          right: true,
                        ),
                        onSwipe: (previousIndex, currentIndex, direction) {
                          if (currentIndex == null) {
                            if (controller.forgotVocabs.length == 1) {
                              var congrat = Vocabulary(
                                id: 0,
                                chapter: 0,
                                kana: 'Congratulations!',
                                kanji: '',
                                meaning:
                                    'You have completed all the cards in this round.',
                                partOfSpeech: '',
                                example: '',
                                note: '',
                              );
                              controller.forgotVocabs.add(congrat);
                            }
                            controller.isFinished.value = true;
                            return false;
                          }
                          if (direction == CardSwiperDirection.right) {
                            controller.knownVocabs
                                .add(controller.reviewVocabs[currentIndex]);
                          }
                          if (direction == CardSwiperDirection.left) {
                            controller.forgotVocabs
                                .add(controller.reviewVocabs[currentIndex]);
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
        ),
      ),
    );
  }
}
