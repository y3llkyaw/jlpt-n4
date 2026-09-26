import 'dart:developer';

import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/data/models/vocabulary.dart';

class VocabTrainingController extends GetxController {
  final vocabs = <Vocabulary>[].obs;
  final cardSwiperController = CardSwiperController().obs;

  final forgotVocabs = <Vocabulary>[].obs;
  final knownVocabs = <Vocabulary>[].obs;
  final reviewVocabs = <Vocabulary>[].obs;

  final isFinished = false.obs;
  final resetToken = 0.obs;

  @override
  void onInit() {
    vocabs.value = Get.find<LessondetailController>().vocabs.toList();
    vocabs.shuffle();
    reviewVocabs.value = vocabs.toList();

    super.onInit();
  }

  void resetSwiper() {
    cardSwiperController.value = CardSwiperController();
    resetToken.value++;
  }

  void addForget(Vocabulary vocab) {
    forgotVocabs.add(vocab);
    log("${vocab.kana} added to Forgotten list");
    logVocabs();
  }

  void addKnown(Vocabulary vocab) {
    knownVocabs.add(vocab);
    log("${vocab.kana} added to Known list");
    logVocabs();
  }

  void finsied() {
    isFinished.value = true;
  }

  void logVocabs() {
    log(knownVocabs.map((e) => e.kana).toList().join(","),
        name: "known-vocabs-list");
    log(forgotVocabs.map((e) => e.kana).toList().join(","),
        name: "forgot-vocabs-list");
  }
}
