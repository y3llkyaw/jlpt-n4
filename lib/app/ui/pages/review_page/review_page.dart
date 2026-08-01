
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../layouts/main/main_layout.dart';

import '../../../controllers/review_controller.dart';

class ReviewPage extends GetView<ReviewController> {
  const ReviewPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Text("hello")
    );
  }
}
