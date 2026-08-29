import 'dart:developer';

import 'package:get/get.dart';

class KanjiHowController extends GetxController {
  var kanji = "".obs;
  var fontSize = 50.0.obs;

  void fontSizeIncrease() {
    if (fontSize.value < 130) {
      fontSize.value += 10.0;
    }
    log(fontSize.string);
  }

  void fontSizeDecrease() {
    if (fontSize.value > 50) {
      fontSize.value -= 10.0;
    }
    log(fontSize.string);
  }
}
