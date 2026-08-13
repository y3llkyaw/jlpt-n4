import 'dart:developer';

import 'package:get/get.dart';
import 'package:n4/app/data/models/enums.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class LessondetailController extends GetxController {
  var vocabs = <Vocabulary>[].obs;
  var vocabsCopy = <Vocabulary>[].obs;
  var forgotList = <Vocabulary>[].obs;
  var knownList = <Vocabulary>[].obs;
  var viewVocabs = <Vocabulary>[].obs;

  var isListView = true.obs;
  var vocabFilter = VocabFilter.all.obs;
  var round = 1.obs;
  var isFinished = false.obs;
  var congrat = Vocabulary(0, 0, 'Congratulations!', '',
      'You have completed all the cards in this round.', '', '', '');

  @override
  void onInit() async {
    super.onInit();
    vocabs.value = [congrat, congrat];

    final data =
        await DatabaseServices.instance.getVocabularyByChapter(Get.arguments);
    vocabs.value = data.map((e) => Vocabulary.fromMap(e)).toList();

    log(data.length.toString());
    vocabsCopy.value = vocabs.toList();
    viewVocabs.value = vocabs.toList();
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
    knownList.clear();
    viewVocabs.value = _filterVocabs();
  }

  void resetReview() {
    round.value = 1;
    knownList.clear();
    forgotList.clear();
    vocabsCopy.value = vocabs.toList();
    Get.log("Finished! Shuffle the review.");
    vocabs.shuffle();
    viewVocabs.value = _filterVocabs();
    isFinished.value = false;
  }

  void showRestart() {
    round.value = 1;
    isFinished.value = true;
    knownList.clear();
    forgotList.clear();
    vocabsCopy.value = vocabs.toList();
    Get.log("Finished! Shuffle the review.");
    vocabs.shuffle();
    viewVocabs.value = _filterVocabs();
  }

  void changeFilter(VocabFilter filter) {
    vocabFilter.value = filter;
    viewVocabs.value = _filterVocabs();
  }

  List<Vocabulary> _filterVocabs() {
    final currentFilter = vocabFilter.value;

    if (currentFilter == VocabFilter.all) {
      return vocabs.toList();
    }

    return vocabs.where((vocab) {
      final partOfSpeech = vocab.partOfSpeech.toLowerCase();

      switch (currentFilter) {
        case VocabFilter.noun:
          return partOfSpeech.contains('noun');
        case VocabFilter.verb:
          return partOfSpeech.contains('verb');
        case VocabFilter.iAdj:
          return partOfSpeech.toLowerCase().contains('iadj');
        case VocabFilter.naAdj:
          return partOfSpeech.toLowerCase().contains('naadji');
        case VocabFilter.speaking:
          return partOfSpeech.contains('speaking');
        case VocabFilter.suffix:
          return partOfSpeech.contains('suffix');
        case VocabFilter.all:
          return true;
      }
    }).toList();
  }
}
