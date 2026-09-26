import 'dart:developer';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/enums.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';
import 'package:n4/app/ui/utils/util.dart';

class LessondetailController extends GetxController {
  var vocabs = <Vocabulary>[].obs;
  var vocabsCopy = <Vocabulary>[].obs;
  var forgotList = <Vocabulary>[].obs;
  var knownList = <Vocabulary>[].obs;
  var viewVocabs = <Vocabulary>[].obs;
  var carouselSliderController = CarouselSliderController();
  var isPlaying = false.obs;

  final currentIndex = (-1).obs;

  var isListView = true.obs;
  var vocabFilter = VocabFilter.all.obs;
  var round = 1.obs;
  var isFinished = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final data = await DatabaseServices.instance
        .getVocabularyByChapterWithSameMeaning(Get.arguments);
    vocabs.value = data.toList();
    log(data.length.toString());
    vocabsCopy.value = vocabs.toList();
    viewVocabs.value = vocabs.toList();
  }

  Future<void> play() async {
    isPlaying.value = true;
    if (!isListView.value) {
      carouselSliderController.jumpToPage(0);

      for (final vocab in viewVocabs) {
        currentIndex.value = viewVocabs.indexOf(vocab);
        log('Current Index: ${currentIndex.value}, Vocab: ${vocab.kana}');
        if (!isPlaying.value) {
          break;
        }
        await speak(vocab);
        await carouselSliderController.nextPage();
      }
    } else {
      try {
        for (final vocab in viewVocabs) {
          currentIndex.value = viewVocabs.indexOf(vocab);
          log('Current Index: ${currentIndex.value}, Vocab: ${vocab.kana}');
          if (!isPlaying.value) {
            break;
          }
          await speak(vocab);
        }
      } finally {}
    }
    isPlaying.value = false;
    currentIndex.value = -1;
  }

  void stop() {
    isPlaying.value = false;
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
