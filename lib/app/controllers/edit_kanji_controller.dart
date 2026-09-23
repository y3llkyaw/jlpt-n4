import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/kanji.dart';
import 'package:n4/app/data/models/vocabulary.dart';

class EditKanjiController extends GetxController {
  final kanji = Rxn<Kanji>();
  final okanji = Rxn<Kanji>();

  final TextEditingController kanjiTEC = TextEditingController();
  final TextEditingController kunyomiTEC = TextEditingController();
  final TextEditingController onyomiTEC = TextEditingController();
  final TextEditingController meaningTEC = TextEditingController();
  final TextEditingController examplesTEC = TextEditingController();
  final relatedVocabs = <Vocabulary>[].obs;

  final isEditing = false.obs;
  final originalKanjiList = [].obs;
  final isEdited = false.obs;

  @override
  void onInit() {
    isEditing.value = Get.arguments.isNotEmpty;

    if (isEditing.value) {
      okanji.value = Get.arguments[0];
      kanji.value = Get.arguments[0];
    }
    checkEdited();
    _initailzeKanji();
    super.onInit();
  }

  void checkEdited() {
    final original = okanji.value;
    final current = kanji.value;

    isEdited.value = original == null ||
        current == null ||
        original.kanji != current.kanji ||
        original.onyomi != current.onyomi ||
        original.kunyomi != current.kunyomi ||
        original.meaning != current.meaning ||
        original.examples != current.examples ||
        original.kanjiNumber != current.kanjiNumber ||
        original.level != current.level;

    log("checking vocab is Edited ${isEdited.value}");
  }

  void _initailzeKanji() {
    kanjiTEC.text = kanji.value!.kanji;
    onyomiTEC.text = kanji.value!.onyomi ?? '';
    kunyomiTEC.text = kanji.value!.kunyomi ?? '';
    meaningTEC.text = kanji.value!.meaning ?? '';
    examplesTEC.text = kanji.value!.examples ?? '';
    relatedVocabs.value = kanji.value!.vocabularies;
  }

  void onEdit() {
    log("Editing Kanji");
    kanji.value!.kanji = kanjiTEC.text;
    kanji.value!.onyomi = onyomiTEC.text;
    kanji.value!.kunyomi = kunyomiTEC.text;
    kanji.value!.meaning = meaningTEC.text;
    kanji.value!.examples = examplesTEC.text;
    kanji.value!.vocabularies = relatedVocabs;
    checkEdited();
  }
}
