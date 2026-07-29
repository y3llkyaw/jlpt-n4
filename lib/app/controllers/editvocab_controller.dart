import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';

class EditvocabController extends GetxController {
  final vocab = Rxn<Vocabulary>();
  TextEditingController kana = TextEditingController();
  TextEditingController kanji = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController chapter = TextEditingController();
  TextEditingController meaing = TextEditingController();

  TextEditingController example = TextEditingController();

  @override
  void onInit() {
    vocab.value = Get.arguments;

    chapter.text = vocab.value!.chapter.toString();
    kana.text = vocab.value!.kana;
    kanji.text = vocab.value!.kanji;
    note.text = vocab.value!.note;
    meaing.text = vocab.value!.meaning;

    type.text = vocab.value!.partOfSpeech;
    example.text = vocab.value!.example;

    super.onInit();
  }

  void printVocab() {
    Get.log(vocab.value!.id.toString());
  }
}
