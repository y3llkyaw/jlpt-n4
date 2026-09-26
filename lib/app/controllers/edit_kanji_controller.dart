import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/home_controller.dart';
import 'package:n4/app/data/models/kanji.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class EditKanjiController extends GetxController {
  final kanji = Rxn<Kanji>();
  final okanji = Rxn<Kanji>();

  final TextEditingController kanjiTEC = TextEditingController();
  final TextEditingController kunyomiTEC = TextEditingController();
  final TextEditingController onyomiTEC = TextEditingController();
  final TextEditingController levelTEC = TextEditingController();
  final TextEditingController kanjiNumberTEC = TextEditingController();
  final TextEditingController meaningTEC = TextEditingController();
  final TextEditingController examplesTEC = TextEditingController();

  final relatedVocabs = <Vocabulary>[].obs;
  final searchedVocab = <Vocabulary>[].obs;

  final isEditing = false.obs;
  final isEdited = false.obs;

  bool get isNew => kanji.value?.id == null;

  @override
  void onInit() {
    final args = Get.arguments;
    _readArguments(args);
    _initializeKanji();
    super.onInit();
  }

  @override
  void onClose() {
    kanjiTEC.dispose();
    kunyomiTEC.dispose();
    onyomiTEC.dispose();
    levelTEC.dispose();
    kanjiNumberTEC.dispose();
    meaningTEC.dispose();
    examplesTEC.dispose();
    super.onClose();
  }

  void _readArguments(dynamic args) {
    if (args is List && args.isNotEmpty && args.first is Kanji) {
      final current = args.first as Kanji;
      kanji.value = current;
      isEditing.value = true;
      return;
    }

    kanji.value = Kanji(
      kanjiNumber: 1,
      kanji: '',
      level: 'N4',
      vocabularies: const [],
    );
    isEditing.value = false;
  }

  void _initializeKanji() {
    final current = kanji.value ?? Kanji(kanjiNumber: 1, kanji: '', level: 'N4');
    okanji.value = _copyKanji(current);

    kanjiTEC.text = current.kanji;
    kunyomiTEC.text = current.kunyomi ?? '';
    onyomiTEC.text = current.onyomi ?? '';
    levelTEC.text = current.level ?? '';
    kanjiNumberTEC.text = current.kanjiNumber.toString();
    meaningTEC.text = current.meaning ?? '';
    examplesTEC.text = current.examples ?? '';
    relatedVocabs.assignAll(current.vocabularies);
    checkEdited();
  }

  Kanji _copyKanji(Kanji value) {
    return Kanji(
      id: value.id,
      kanjiNumber: value.kanjiNumber,
      kanji: value.kanji,
      level: value.level,
      kunyomi: value.kunyomi,
      onyomi: value.onyomi,
      meaning: value.meaning,
      examples: value.examples,
      vocabularies: value.vocabularies.toList(),
    );
  }

  bool _relatedChanged() {
    final currentIds = relatedVocabs.map((item) => item.id).whereType<int>().toSet();
    final originalIds =
        (okanji.value?.vocabularies ?? []).map((item) => item.id).whereType<int>().toSet();
    return currentIds.length != originalIds.length ||
        currentIds.union(originalIds).length != currentIds.length;
  }

  void checkEdited() {
    final original = okanji.value;
    final current = kanji.value;

    if (current == null) {
      isEdited.value = false;
      return;
    }

    final currentNumber = int.tryParse(kanjiNumberTEC.text) ?? current.kanjiNumber;
    final currentLevel = levelTEC.text.trim();

    if (original == null) {
      isEdited.value = kanjiTEC.text.trim().isNotEmpty ||
          kunyomiTEC.text.trim().isNotEmpty ||
          onyomiTEC.text.trim().isNotEmpty ||
          currentNumber != 1 ||
          currentLevel.isNotEmpty ||
          meaningTEC.text.trim().isNotEmpty ||
          examplesTEC.text.trim().isNotEmpty ||
          relatedVocabs.isNotEmpty;
      return;
    }

    isEdited.value = original.kanji != kanjiTEC.text ||
        original.kunyomi != kunyomiTEC.text ||
        original.onyomi != onyomiTEC.text ||
        original.level != levelTEC.text ||
        original.kanjiNumber != currentNumber ||
        original.meaning != meaningTEC.text ||
        original.examples != examplesTEC.text ||
        _relatedChanged();

    log('checking kanji is edited ${isEdited.value}');
  }

  void onEdit() {
    final current = kanji.value ?? Kanji(kanjiNumber: 1, kanji: '');

    current.kanji = kanjiTEC.text;
    current.kanjiNumber = int.tryParse(kanjiNumberTEC.text) ?? current.kanjiNumber;
    current.level = levelTEC.text.trim().isEmpty ? null : levelTEC.text.trim();
    current.kunyomi = kunyomiTEC.text.trim().isEmpty ? null : kunyomiTEC.text.trim();
    current.onyomi = onyomiTEC.text.trim().isEmpty ? null : onyomiTEC.text.trim();
    current.meaning = meaningTEC.text.trim().isEmpty ? null : meaningTEC.text.trim();
    current.examples = examplesTEC.text.trim().isEmpty ? null : examplesTEC.text.trim();
    current.vocabularies = relatedVocabs.toList();

    kanji.value = current;
    checkEdited();
  }

  Future<void> saveKanji() async {
    final current = kanji.value ?? Kanji(kanjiNumber: 1, kanji: '');
    final updatedKanji = Kanji(
      id: current.id,
      kanjiNumber: int.tryParse(kanjiNumberTEC.text) ?? current.kanjiNumber,
      kanji: kanjiTEC.text.trim(),
      level: levelTEC.text.trim().isEmpty ? 'N4' : levelTEC.text.trim(),
      kunyomi: kunyomiTEC.text.trim().isEmpty ? null : kunyomiTEC.text.trim(),
      onyomi: onyomiTEC.text.trim().isEmpty ? null : onyomiTEC.text.trim(),
      meaning: meaningTEC.text.trim().isEmpty ? null : meaningTEC.text.trim(),
      examples: examplesTEC.text.trim().isEmpty ? null : examplesTEC.text.trim(),
      vocabularies: relatedVocabs.toList(),
    );

    final wasNew = updatedKanji.id == null;
    late final int savedId;

    if (wasNew) {
      savedId = await DatabaseServices.instance.insertKanji(updatedKanji);
      updatedKanji.id = savedId;
    } else {
      savedId = updatedKanji.id!;
      await DatabaseServices.instance.updateKanji(updatedKanji);
    }

    await DatabaseServices.instance.synchronizeKanjiVocabJunctions(
      savedId,
      updatedKanji.vocabularies
          .map((vocab) => vocab.id)
          .whereType<int>(),
    );

    kanji.value = updatedKanji;
    okanji.value = _copyKanji(updatedKanji);
    isEditing.value = true;
    checkEdited();
    Get.back();
  }

  Future<void> deleteKanji() async {
    final id = kanji.value?.id;
    if (id == null) {
      return;
    }

    await DatabaseServices.instance.deleteKanji(id);
    Get.back();
  }

  bool isSelected(Vocabulary vocab) {
    return relatedVocabs.any((item) => item.id == vocab.id);
  }

  void toggleRelatedVocab(Vocabulary vocab) {
    if (isSelected(vocab)) {
      relatedVocabs.removeWhere((item) => item.id == vocab.id);
    } else {
      relatedVocabs.add(vocab);
    }
    onEdit();
  }

  void searchVocab(String query) {
    final homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : null;

    final source = homeController?.vocabs ?? <Vocabulary>[];
    final normalized = query.trim().toLowerCase();

    if (normalized.isEmpty) {
      searchedVocab.assignAll(source);
      return;
    }

    searchedVocab.assignAll(
      source.where((vocab) {
        final kana = vocab.kana.toLowerCase();
        final meaning = vocab.meaning.toLowerCase();
        final kanjiText = vocab.kanji.toLowerCase();
        return kana.contains(normalized) ||
            meaning.contains(normalized) ||
            kanjiText.contains(normalized);
      }),
    );
  }
}
