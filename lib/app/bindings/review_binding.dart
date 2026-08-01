
import 'package:get/get.dart';
import '../controllers/review_controller.dart';


class ReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController());
        // Get.put<ReviewController>(ReviewController());
  }
}