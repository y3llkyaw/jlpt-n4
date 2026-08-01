
import 'package:get/get.dart';
import '../controllers/vocab_page_controller.dart';


class VocabPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VocabPageController>(() => VocabPageController());
        // Get.put<VocabPageController>(VocabPageController());
  }
}