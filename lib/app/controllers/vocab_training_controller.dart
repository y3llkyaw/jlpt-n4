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

  @override
  void onInit() {
    vocabs.value = Get.find<LessondetailController>().vocabs.toList();
    vocabs.shuffle();
    reviewVocabs.value = vocabs.toList();

    super.onInit();
  }

  void forget(Vocabulary vocab) {
    forgotVocabs.add(vocab);
  }

  void known(Vocabulary vocab) {
    knownVocabs.add(vocab);
  }

  void finsied() {
    isFinished.value = true;
  }
}
