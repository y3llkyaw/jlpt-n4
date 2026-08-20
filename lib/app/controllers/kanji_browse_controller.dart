import 'package:get/get.dart';
import 'package:n4/app/data/models/kanji.dart';
import 'package:n4/app/data/services/database_services.dart';

class KanjiBrowseController extends GetxController {
  final kanjis = <Kanji>[].obs;

  @override
  void onInit() async {
    kanjis.value = await DatabaseServices.instance.getKanjis();
    super.onInit();
  }

  void loadKanji() async {
    // String kanji = randomKanji.value?.kanji ?? "駅";
    // final kanjiSVG = await loadKanjiSVG(kanji);

    // const parser = KanjiParser();
    // kvg.value = parser.parse(kanjiSVG);
  }
}
