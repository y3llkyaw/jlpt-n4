import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class EditvocabController extends GetxController {
  final vocab = Rxn<Vocabulary>();
  final original = Rxn<Vocabulary>();
  List<Vocabulary>? sourceList;
  int? sourceIndex;
  TextEditingController kana = TextEditingController();
  TextEditingController kanji = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController chapter = TextEditingController();
  TextEditingController meaing = TextEditingController();
  TextEditingController example = TextEditingController();
  var isEdited = false.obs;
  var type = "Noun".obs;

  bool get isNew => vocab.value?.id == null;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is List && args.isNotEmpty && args[0] is Vocabulary) {
      vocab.value = args[0] as Vocabulary;
      if (args.length >= 3) {
        if (args[1] is List && args[2] is int) {
          sourceList = (args[1] as List).cast<Vocabulary>();
          sourceIndex = args[2] as int;
        } else if (args[1] is int && args[2] is List) {
          sourceList = (args[2] as List).cast<Vocabulary>();
          sourceIndex = args[1] as int;
        }
      }
    } else {
      vocab.value = Vocabulary(null, 1, '', '', '', 'Noun', '', '');
    }
    original.value = Vocabulary(
      vocab.value!.id,
      vocab.value!.chapter,
      vocab.value!.kana,
      vocab.value!.kanji,
      vocab.value!.meaning,
      vocab.value!.partOfSpeech,
      vocab.value!.note,
      vocab.value!.example,
    );

    chapter.text = vocab.value!.chapter.toString();
    kana.text = vocab.value!.kana;
    kanji.text = vocab.value!.kanji;
    note.text = vocab.value?.note ?? '';
    meaing.text = vocab.value!.meaning;
    type.value = vocab.value!.partOfSpeech.isNotEmpty
        ? vocab.value!.partOfSpeech
        : 'Noun';
    example.text = vocab.value?.example ?? '';
  }

  void onChange() {
    Get.log('changed');
    final current = Vocabulary(
      vocab.value?.id,
      int.tryParse(chapter.text) ?? 1,
      kana.text,
      kanji.text,
      meaing.text,
      type.string.isNotEmpty ? type.string : 'Noun',
      note.text,
      example.text,
    );

    if (isNew) {
      isEdited.value = current.kana.isNotEmpty ||
          current.kanji.isNotEmpty ||
          current.meaning.isNotEmpty ||
          current.note != null ||
          current.example != null ||
          current.chapter != 1 ||
          current.partOfSpeech.isNotEmpty;
    } else {
      isEdited.value = current != original.value;
    }
  }

  Future<void> saveVocab() async {
    final updatedVocab = Vocabulary(
      vocab.value?.id,
      int.tryParse(chapter.text) ?? 1,
      kana.text,
      kanji.text,
      meaing.text,
      type.string.isNotEmpty ? type.string : 'Noun',
      note.text,
      example.text,
    );

    if (isNew) {
      await DatabaseServices.instance.insertVocabulary(updatedVocab);
    } else {
      await DatabaseServices.instance.updateVocabulary(updatedVocab);
      if (sourceList != null && sourceIndex != null) {
        sourceList![sourceIndex!] = updatedVocab;
      } else if (sourceList != null) {
        final updateIndex =
            sourceList!.indexWhere((item) => item.id == updatedVocab.id);
        if (updateIndex != -1) {
          sourceList![updateIndex] = updatedVocab;
        }
      }
    }

    Get.back();
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
}
