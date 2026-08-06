
import 'package:get/get.dart';
import '../controllers/vocab_training_controller.dart';


class VocabTrainingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VocabTrainingController>(() => VocabTrainingController());
        // Get.put<VocabTrainingController>(VocabTrainingController());
  }
}