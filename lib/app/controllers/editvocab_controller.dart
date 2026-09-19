import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/home_controller.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class EditvocabController extends GetxController {
  final vocab = Rxn<Vocabulary>();
  final original = Rxn<Vocabulary>();

  List<Vocabulary>? sourceList;
  int? sourceIndex;
  final kana = TextEditingController();
  final kanji = TextEditingController();
  final note = TextEditingController();
  final chapter = TextEditingController();
  final meaning = TextEditingController();
  final example = TextEditingController();
  final RxList<Vocabulary> sameMeaningList = <Vocabulary>[].obs;
  final _vocabDetailController = Get.find<LessondetailController>();

  final vocabList = <Vocabulary>[].obs;
  final searchedVocab = <Vocabulary>[].obs;

  final isEdited = false.obs;
  final type = 'Noun'.obs;

  bool get isNew => vocab.value?.id == null;

  @override
  void onClose() {
    kana.dispose();
    kanji.dispose();
    note.dispose();
    chapter.dispose();
    meaning.dispose();
    example.dispose();
    super.onClose();
  }

  Set<int> _relationIds(Iterable<Vocabulary> relations) {
    return relations.map((relation) => relation.id).whereType<int>().toSet();
  }

  @override
  void onInit() {
    super.onInit();
    final homeController = Get.find<HomeController>();
    vocabList.value = homeController.vocabs.toList();

    final args = Get.arguments;
    _readArguments(args);

    _loadVocabulary(vocab.value!);
  }

  void _readArguments(dynamic args) {
    if (args is List && args.isNotEmpty && args.first is Vocabulary) {
      vocab.value = args.first as Vocabulary;

      if (args.length >= 3) {
        if (args[1] is List && args[2] is int) {
          sourceList = (args[1] as List).cast<Vocabulary>();
          sourceIndex = args[2] as int;
        } else if (args[1] is int && args[2] is List) {
          sourceIndex = args[1] as int;
          sourceList = (args[2] as List).cast<Vocabulary>();
        }
      }
      return;
    }

    vocab.value = Vocabulary(
      chapter: 1,
      kana: '',
      kanji: '',
      meaning: '',
      partOfSpeech: 'Noun',
      example: '',
      note: '',
    );
  }

  void checkSameMeaningEdited() {
    onChange();
  }

  void _loadVocabulary(Vocabulary value) {
    chapter.text = value.chapter.toString();
    kana.text = value.kana;
    kanji.text = value.kanji;
    note.text = value.note ?? '';
    meaning.text = value.meaning;
    type.value = value.partOfSpeech.isNotEmpty ? value.partOfSpeech : 'Noun';
    example.text = value.example ?? '';
    sameMeaningList.assignAll(value.sameMeaningVocabs);
    original.value = _copyVocabulary(value);
  }

  Vocabulary _copyVocabulary(Vocabulary value) {
    return Vocabulary(
      id: value.id,
      chapter: value.chapter,
      kana: value.kana,
      kanji: value.kanji,
      meaning: value.meaning,
      partOfSpeech: value.partOfSpeech,
      note: value.note,
      example: value.example,
      sameMeaningVocabs: value.sameMeaningVocabs.toList(),
    );
  }

  Vocabulary _currentVocabulary() {
    return Vocabulary(
      id: vocab.value?.id,
      chapter: int.tryParse(chapter.text) ?? 1,
      kana: kana.text,
      kanji: kanji.text,
      meaning: meaning.text,
      partOfSpeech: type.string.isNotEmpty ? type.string : 'Noun',
      note: note.text,
      example: example.text,
      sameMeaningVocabs: sameMeaningList.toList(),
    );
  }

  bool _sameMeaningChanged() {
    final currentIds = _relationIds(sameMeaningList);
    final originalIds = _relationIds(original.value?.sameMeaningVocabs ?? []);
    return !currentIds.containsAll(originalIds) ||
        !originalIds.containsAll(currentIds);
  }

  void onChange() {
    final current = _currentVocabulary();

    if (isNew) {
      isEdited.value = current.kana.isNotEmpty ||
          current.kanji.isNotEmpty ||
          current.meaning.isNotEmpty ||
          current.note?.isNotEmpty == true ||
          current.example?.isNotEmpty == true ||
          current.chapter != 1 ||
          current.partOfSpeech != 'Noun' ||
          _sameMeaningChanged();
    } else {
      isEdited.value = current.chapter != original.value?.chapter ||
          current.kana != original.value?.kana ||
          current.kanji != original.value?.kanji ||
          current.meaning != original.value?.meaning ||
          current.partOfSpeech != original.value?.partOfSpeech ||
          current.note != original.value?.note ||
          current.example != original.value?.example ||
          _sameMeaningChanged();
    }
  }

  Future<void> saveVocab() async {
    final wasNew = isNew;
    final updatedVocab = _currentVocabulary();

    late final int savedId;
    if (wasNew) {
      savedId = await DatabaseServices.instance.insertVocabulary(updatedVocab);
      updatedVocab.id = savedId;
    } else {
      savedId = updatedVocab.id!;
      await DatabaseServices.instance.updateVocabulary(updatedVocab);
    }

    await DatabaseServices.instance.synchronizeVocabJunctions(
      savedId,
      updatedVocab.sameMeaningVocabs
          .map((relatedVocab) => relatedVocab.id)
          .whereType<int>(),
    );

    if (!wasNew) {
      _updateSourceList(updatedVocab);
    }

    Get.back();
  }

  void _updateSourceList(Vocabulary updatedVocab) {
    if (sourceList == null) return;

    final indexView = _vocabDetailController.viewVocabs.indexOf(updatedVocab);
    final indexSource = _vocabDetailController.vocabs.indexOf(updatedVocab);

    if (indexView != -1) {
      _vocabDetailController.viewVocabs[indexView] = updatedVocab;
    }
    if (indexSource != -1) {
      _vocabDetailController.vocabs[indexSource] = updatedVocab;
    }

    if (sourceIndex != null) {
      sourceList![sourceIndex!] = updatedVocab;
      return;
    }
  }

  Future<void> deleteVocab() async {
    final id = vocab.value?.id;

    if (id == null) {
      return;
    }
    await DatabaseServices.instance.deleteVocabulary(id);
    if (sourceList != null) {
      sourceList!.removeWhere((item) => item.id == id);
    }
  }

  void toggleAddSameMeaning(Vocabulary vocab) {
    if (sameMeaningList.contains(vocab)) {
      sameMeaningList.remove(vocab);
    } else {
      sameMeaningList.add(vocab);
    }
    onChange();
  }

  bool isSelected(Vocabulary vocab) {
    return sameMeaningList.contains(vocab);
  }

  void searchVocab(String query) {
    if (query.isEmpty) {
      searchedVocab.value = [];
    } else {
      searchedVocab.value = vocabList
          .where((vocab) =>
              vocab.kana.toLowerCase().contains(query.toLowerCase()) ||
              vocab.meaning.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
