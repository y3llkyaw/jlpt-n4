import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
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
          actions: [
            IconButton(
                onPressed: () {
                  controller.isListView.value = !controller.isListView.value;
                },
                icon: Icon(Icons.help_outline))
          ],
        ),
        body: Obx(
          () => controller.isListView.value
              ? ListView.builder(
                  itemCount: controller.vocabs.length,
                  itemBuilder: (context, index) {
                    return listCard(
                      controller.vocabs[index],
                      index,
                      controller.vocabs,
                    );
                  },
                )
              : controller.isFinished.value
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
                            AnimatedEmoji(
                              AnimatedEmojis.partyPopper,
                              size: 100,
                            ),
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
                          () => Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Chip(
                                label: Text("Forgot"),
                                avatar: CircleAvatar(
                                  backgroundColor:
                                      Get.theme.colorScheme.errorContainer,
                                  child: Text(
                                    controller.forgotList.length.toString(),
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              Chip(
                                label: Text("Remember"),
                                avatar: CircleAvatar(
                                  child: Text(
                                    controller.knownList.length.toString(),
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.swipe_left),
                            Text("Swipe Left: Forgot"),
                            Text("Swipe Right: Know"),
                            Icon(Icons.swipe_right),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.5,
                          child: Obx(
                            () => controller.vocabsCopy.isEmpty
                                ? Center(
                                    child: Text(
                                      "No cards left to review.",
                                      style: Get.textTheme.titleMedium,
                                    ),
                                  )
                                : CardSwiper(
                                    controller:
                                        controller.cardSwiperController.value,
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
                                      if (vocab.id == 0 ) {
                                        controller.showRestart();
                                      }
                                      if (direction ==
                                          CardSwiperDirection.left) {
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
                                            left: true, right: true),
                                    cardsCount: controller.vocabsCopy.isEmpty
                                        ? 1
                                        : controller.vocabsCopy.length,
                                    cardBuilder: (context,
                                        index,
                                        horizontalOffsetPercentage,
                                        verticalOffsetPercentage) {
                                      return Center(
                                        child: listCard(
                                            controller.vocabsCopy[index],
                                            index,
                                            controller.vocabsCopy),
                                      );
                                    },
                                  ),
                            // :CardSwiper(cardBuilder: ((context, index, horizontalOffsetPercentage, verticalOffsetPercentage) => Text("Hello")), cardsCount: 1)
                          ),
                        ),
                      ],
                    ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.note),
                    color: Get.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.smiley_fill),
                    color: Get.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shuffle),
                    color: Get.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
