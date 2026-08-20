
import 'package:get/get.dart';
import '../controllers/kanji_browse_controller.dart';


class KanjiBrowseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KanjiBrowseController>(() => KanjiBrowseController());
        // Get.put<KanjiBrowseController>(KanjiBrowseController());
  }
}