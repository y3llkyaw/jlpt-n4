import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/data/services/database_services.dart';

class LessondetailController extends GetxController {
  var vocabs = <Vocabulary>[].obs;

  @override
  void onInit() async {
    super.onInit();

    final data =await DatabaseServices.instance.getVocabularyByChapter(Get.arguments);
    vocabs.value = data.map((e) => Vocabulary.fromMap(e)).toList();
  }
}
