
import 'package:get/get.dart';
import '../controllers/edit_kanji_controller.dart';


class EditKanjiBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditKanjiController>(() => EditKanjiController());
        // Get.put<EditKanjiController>(EditKanjiController());
  }
}