
import 'package:get/get.dart';
import '../controllers/editvocab_controller.dart';


class EditvocabBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditvocabController>(() => EditvocabController());
        // Get.put<EditvocabController>(EditvocabController());
  }
}