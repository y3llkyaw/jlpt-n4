import 'dart:math';

import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class HomeController extends GetxController {
  final index = 0.obs;
  final vocabs = <Vocabulary>[].obs;
  final randomVocab = Rxn<Vocabulary>();

  @override
  void onInit() async {
    final data = await DatabaseServices.instance.getVocabulary();
    vocabs.value = data.map((e) => Vocabulary.fromMap(e)).toList();
    final random = Random();
    randomVocab.value = vocabs[random.nextInt(vocabs.length)];
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
