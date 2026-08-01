import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class EditvocabController extends GetxController {
  final vocab = Rxn<Vocabulary>();
  TextEditingController kana = TextEditingController();
  TextEditingController kanji = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController chapter = TextEditingController();
  TextEditingController meaing = TextEditingController();
  TextEditingController example = TextEditingController();
  var isEdited = false.obs;
  var type = "".obs;

  @override
  void onInit() {
    vocab.value = Get.arguments[0];

    chapter.text = vocab.value!.chapter.toString();
    kana.text = vocab.value!.kana;
    kanji.text = vocab.value!.kanji;
    note.text = vocab.value!.note;
    meaing.text = vocab.value!.meaning;
    type.value = vocab.value!.partOfSpeech;
    example.text = vocab.value!.example;

    super.onInit();
  }

  void onChange() {
    Get.log("changed");
    Vocabulary changedVocab = Vocabulary(
        Get.arguments[0].id,
        int.parse(chapter.text),
        kana.text,
        kanji.text,
        meaing.text,
        type.string,
        note.text,
        example.text);

    if (changedVocab != Get.arguments[0]) {
      isEdited.value = true;
    } else {
      isEdited.value = false;
    }
  }

  void saveVocab() async {
    Vocabulary updatedVocab = Vocabulary(
        Get.arguments[0].id,
        int.parse(chapter.text),
        kana.text,
        kanji.text,
        meaing.text,
        type.string,
        note.text,
        example.text);
    Get.arguments[1][Get.arguments[2]] = updatedVocab;
    await DatabaseServices.instance.updateVocabulary(updatedVocab);
    Get.back();
  }

  void printVocab() {
    Get.log(vocab.value!.id.toString());
  }
}
