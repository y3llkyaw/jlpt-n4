import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class HomeController extends GetxController {
  final index = 0.obs;
  final vocabs = <Vocabulary>[].obs;
  final randomVocab = Rxn<Vocabulary>();
  final kanjiSVG = "".obs;
  @override
  void onInit() async {
    final data = await DatabaseServices.instance.getVocabulary();
    vocabs.value = data.map((e) => Vocabulary.fromMap(e)).toList();
    final random = Random();
    String emoji = '駅';
    int codePoint = emoji.runes.first;

    randomVocab.value = vocabs[random.nextInt(vocabs.length)];
    kanjiSVG.value = await rootBundle
        .loadString('assets/kanji/0${codePoint.toRadixString(16)}.svg');
    super.onInit();
  }

  void changeIndex(int value) {
    index.value = value;
  }

  void randomRefresh() {
    final random = Random();
    randomVocab.value = vocabs[random.nextInt(vocabs.length)];
  }
}
