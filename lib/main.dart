import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:n4/app/ui/utils/util.dart';
import 'app/data/services/dependency_injection.dart';
import 'app/data/services/theme_service.dart';
import 'app/data/services/translations_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/ui/layouts/main/main_layout.dart';
import 'app/ui/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  DependecyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "ABeeZee", "ADLaM Display");

    MaterialTheme theme = MaterialTheme(textTheme);
    return ScreenUtilInit(
      builder: (_, __) {
        return GetMaterialApp(
          title: 'N4',
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: ThemeService.instance.themeMode,
          translations: Translation(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          initialRoute: AppRoutes.HOME,
          unknownRoute: AppPages.unknownRoutePage,
          getPages: AppPages.pages,
          builder: (_, child) {
            return MainLayout(child: child!);
          },
        );
      },
      //! Must change it to true if you want to use the ScreenUtil
      designSize: const Size(411, 823),
    );
  }
}
