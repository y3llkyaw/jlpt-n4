import '../bindings/review_binding.dart';
import '../ui/pages/review_page/review_page.dart';
      import '../bindings/setting_binding.dart';
import '../ui/pages/setting_page/setting_page.dart';
      import '../bindings/vocab_page_binding.dart';
import '../ui/pages/vocab_page/vocab_page.dart';
      import '../bindings/editvocab_binding.dart';
import '../ui/pages/editvocab_page/editVocab_page.dart';
import '../bindings/lessondetail_binding.dart';
import '../ui/pages/lessondetail_page/lessondetail_page.dart';
import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/unknown_route_page/unknown_route_page.dart';
import 'app_routes.dart';

const _defaultTransition = Transition.native;

class AppPages {
  static final unknownRoutePage = GetPage(
    name: AppRoutes.UNKNOWN,
    page: () => const UnknownRoutePage(),
    transition: _defaultTransition,
  );

  static final List<GetPage> pages = [
    unknownRoutePage,
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.LESSONDETAIL,
      page: () => const LessondetailPage(),
      binding: LessondetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.EDITVOCAB,
      page: () => const EditVocabPage(),
      binding: EditvocabBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.VOCAB_PAGE,
      page: () => const VocabPage(),
      binding: VocabPageBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SETTING,
      page: () => const SettingPage(),
      binding: SettingBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.REVIEW,
      page: () => const ReviewPage(),
      binding: ReviewBinding(),
      transition: _defaultTransition,
    ), 
];
}