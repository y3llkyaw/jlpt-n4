
import 'package:get/get.dart';
import '../controllers/kanji_how_controller.dart';


class KanjiHowBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KanjiHowController>(() => KanjiHowController());
        // Get.put<KanjiHowController>(KanjiHowController());
  }
}