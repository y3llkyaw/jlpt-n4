import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/ui/global_widgets/list_card.dart';

class VocabTrainingPage extends GetView<VocabTrainingPage> {
  const VocabTrainingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LessondetailController());
    final CardSwiperController cardSwiperController = CardSwiperController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() => Text("Chapter ${controller.vocabs.first.chapter}")),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isFinished.value
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Congratulations!\nYou have known all vocabulary.",
                          style: Get.textTheme.titleMedium!.copyWith(
                            color: Get.theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.repeat_rounded,
                            color: Get.theme.colorScheme.onSecondary,
                          ),
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Get.theme.colorScheme.primary),
                          ),
                          onPressed: () {
                            controller.resetReview();
                          },
                          label: Text(
                            "Restart ?",
                            style: Get.textTheme.titleMedium!.copyWith(
                              color: Get.theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          // icon: Icon(Icons.arrow_back),
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Get.theme.colorScheme.secondary),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          label: Text(
                            "Go Back",
                            style: Get.textTheme.titleMedium!.copyWith(
                              color: Get.theme.colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.round.value == 1
                          ? "Round 1"
                          : "Round ${controller.round.value} [Forgotten Cards]",
                      style: Get.textTheme.titleLarge!.copyWith(
                        color: Get.theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => _swipehint(
                        knownCount: controller.knownList.length,
                        forgotCount: controller.forgotList.length,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.5,
                      child: Obx(
                        () {
                          Get.log(
                              "Vocabs Copy Length: shuffle ${controller.vocabsCopy.length}");

                          return controller.vocabsCopy.isEmpty
                              ? Center(
                                  child: Text(
                                    "No cards left to review.",
                                    style: Get.textTheme.titleMedium,
                                  ),
                                )
                              : CardSwiper(
                                  duration: Duration(milliseconds: 500),
                                  controller: cardSwiperController,
                                  showBackCardOnUndo: false,
                                  onEnd: () {
                                    controller.finishedRound();
                                  },
                                  onSwipe: (previousIndex, currentIndex,
                                      direction) async {
                                    final cards = controller.vocabsCopy;
                                    if (cards.isEmpty ||
                                        previousIndex >= cards.length) {
                                      return false;
                                    }

                                    final vocab = cards[previousIndex];
                                    Get.log(
                                      "Current Vocabs${vocab.kana} ",
                                    );
                                    if (vocab.id == 0) {
                                      controller.showRestart();
                                    }
                                    if (direction == CardSwiperDirection.left) {
                                      controller.addKnownVocab(vocab);
                                    } else if (direction ==
                                        CardSwiperDirection.right) {
                                      controller.addForgotVocab(vocab);
                                    }
                                    return true;
                                  },
                                  isLoop: true,
                                  allowedSwipeDirection:
                                      AllowedSwipeDirection.only(
                                    left: true,
                                    right: true,
                                  ),
                                  cardsCount: controller.vocabsCopy.isEmpty
                                      ? 1
                                      : controller.vocabsCopy.length,
                                  cardBuilder: (context,
                                      index,
                                      horizontalOffsetPercentage,
                                      verticalOffsetPercentage) {
                                    return Center(
                                      child: FlipCard(
                                        key: ValueKey(
                                            'vocab-card-${controller.vocabsCopy[index].id ?? index}-${controller.vocabsCopy[index].kana}-${controller.vocabsCopy[index].meaning}'),
                                        direction: FlipDirection.VERTICAL,
                                        front: listCard(
                                          controller.vocabsCopy[index],
                                          index,
                                          controller.vocabsCopy,
                                        ),
                                        back: listCard(
                                          controller.vocabsCopy[index],
                                          index,
                                          controller.vocabsCopy,
                                          isBack: true,
                                        ),
                                      ),
                                    );
                                  },
                                );
                        },
                        // :CardSwiper(cardBuilder: ((context, index, horizontalOffsetPercentage, verticalOffsetPercentage) => Text("Hello")), cardsCount: 1)
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FilledButton.icon(
                              onPressed: () {},
                              label: Text("show Answer"),
                            ),
                            FilledButton.icon(
                              onPressed: () {
                                cardSwiperController
                                    .swipe(CardSwiperDirection.left);
                              },
                              label: Text("Known"),
                              icon: Icon(CupertinoIcons.left_chevron),
                            ),
                            FilledButton.icon(
                              iconAlignment: IconAlignment.end,
                              onPressed: () {
                                cardSwiperController
                                    .swipe(CardSwiperDirection.right);
                              },
                              label: Text("Forgot"),
                              icon: Icon(CupertinoIcons.right_chevron),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
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

Widget _swipehint({int knownCount = 0, int forgotCount = 0}) {
  return Row(
    spacing: 20,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          AnimatedContainer(
            padding: EdgeInsets.all(5),
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Get.theme.colorScheme.primaryContainer,
            ),
            child: Center(
              child: Text(
                "$knownCount",
                style: Get.textTheme.titleMedium!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            spacing: 10,
            children: [
              Icon(Icons.swipe_right),
              Text(
                "Known",
                style: Get.textTheme.titleMedium!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        children: [
          AnimatedContainer(
            padding: EdgeInsets.all(5),
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Get.theme.colorScheme.errorContainer,
            ),
            child: Center(
              child: Text(
                "$forgotCount",
                style: Get.textTheme.titleMedium!.copyWith(
                  color: Get.theme.colorScheme.onErrorContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            spacing: 10,
            children: [
              Text(
                "Forgot",
                style: Get.textTheme.titleMedium!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.swipe_right),
            ],
          ),
        ],
      ),
    ],
  );
}
