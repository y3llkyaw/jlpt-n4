import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/kanji.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';
import 'package:n4/app/ui/utils/util.dart';

class HomeController extends GetxController {
  final index = 0.obs;
  final vocabs = <Vocabulary>[].obs;
  final kanjis = <Kanji>[].obs;

  final randomVocab = Rxn<Vocabulary>();
  final randomKanji = Rxn<Kanji>();

  final kvg = Rxn<KvgData>();
  final _random = Random();

  @override
  void onInit() async {
    final data = await DatabaseServices.instance.getVocabulary();

    kanjis.value = await DatabaseServices.instance.getKanjis();
    vocabs.value = data.map((e) => Vocabulary.fromMap(e)).toList();

    randomVocab.value = vocabs[_random.nextInt(vocabs.length)];
    randomKanji.value = kanjis[_random.nextInt(kanjis.length)];

    loadKanji();

    super.onInit();
  }

  void changeIndex(int value) {
    index.value = value;
  }

  void randomRefresh() {
    randomVocab.value = vocabs[_random.nextInt(vocabs.length)];
    randomKanji.value = kanjis[_random.nextInt(kanjis.length)];
    print(randomKanji.value?.kanji ?? "");
    loadKanji();
  }

  void loadKanji() async {
    String kanji = randomKanji.value?.kanji ?? "駅";
    final kanjiSVG = await loadKanjiSVG(kanji);

    const parser = KanjiParser();
    kvg.value = parser.parse(kanjiSVG);
  }
}
