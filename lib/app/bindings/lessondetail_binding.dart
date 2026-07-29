import 'package:get/get.dart';
import '../controllers/lessondetail_controller.dart';

class LessondetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LessondetailController>(() => LessondetailController());
    // Get.put<LessondetailController>(LessondetailController());
  }
}
