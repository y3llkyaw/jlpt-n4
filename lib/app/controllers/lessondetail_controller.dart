import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class LessondetailController extends GetxController {
  var vocabs = <Vocabulary>[].obs;
  var vocabsCopy = <Vocabulary>[].obs;
  var forgotList = <Vocabulary>[].obs;
  var knownList = <Vocabulary>[].obs;
  var isListView = true.obs;
  var cardSwiperController = CardSwiperController().obs;
  var round = 1.obs;
  var isFinished = false.obs;

  @override
  void onInit() async {
    super.onInit();

    final data =
        await DatabaseServices.instance.getVocabularyByChapter(Get.arguments);
    vocabs.value = data.map((e) => Vocabulary.fromMap(e)).toList();
    vocabsCopy.value = vocabs.toList();
  }

  void addForgotVocab(Vocabulary vocab) {
    forgotList.add(vocab);
  }

  void addKnownVocab(Vocabulary vocab) {
    knownList.add(vocab);
  }

  void finishedRound() {
    round.value++;

    if (forgotList.isEmpty) {
      showRestart();
      return;
    }
    if (forgotList.length == 1) {
      var congrat = Vocabulary(0, 0, 'Congratulations!', '',
          'You have completed all the cards in this round.', '', '', '');

      forgotList.add(congrat);
    }
    Get.log("Forgot list length: ${forgotList.length}");
    vocabsCopy.value = forgotList.toList();
    forgotList.clear();
  }

  void resetReview() {
    round.value = 1;
    knownList.clear();
    forgotList.clear();
    vocabsCopy.value = vocabs.toList();
    isFinished.value = false;
    cardSwiperController.value = CardSwiperController();
  }

  void showRestart() {
    isFinished.value = true;
    knownList.clear();
    forgotList.clear();
    vocabsCopy.value = vocabs.toList();
  }
}
