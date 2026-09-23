import 'dart:developer';

import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/enums.dart';
import 'package:n4/app/data/models/kanji.dart';
import 'package:n4/app/data/services/database_services.dart';

class KanjiBrowseController extends GetxController {
  final kanjis = <Kanji>[].obs;
  final viewKanjis = <Kanji>[].obs;

  final level = LevelFilter.N5.obs;

  final searchedKanji = <Kanji>[].obs;
  final suggestiondKanji = <Kanji>[].obs;

  final index = 0.obs;
  final kvgData = Rxn<KvgData>();

  @override
  void onInit() async {
    kanjis.value = await DatabaseServices.instance.getKanjis("N4");
    changeFilter(LevelFilter.All);
    super.onInit();
  }

  void changeFilter(LevelFilter filter) {
    if (filter == LevelFilter.All) {
      viewKanjis.value = kanjis;
      return;
    }
    level.value = filter;
    viewKanjis.value =
        kanjis.where((element) => element.level == filter.name).toList();
  }

  void search(String kanji) {
    searchedKanji.value = kanjis.where((e) {
      return e.kanji == kanji ||
          e.kunyomi!.replaceAll("（", "").replaceAll("）", "").contains(kanji) ||
          e.onyomi!.contains(kanji);
    }).toList();
    if (searchedKanji.isNotEmpty) {
      log("search result : ${searchedKanji.first.kanji} ");
    }
  }
}
