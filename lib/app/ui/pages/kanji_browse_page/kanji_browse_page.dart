import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';
import 'package:jp_transliterate/jp_transliterate.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/global_widgets/kanji_detail_card.dart';
import 'package:n4/app/ui/utils/util.dart';
import 'package:n4/app/controllers/kanji_browse_controller.dart';
import 'package:jp_transliterate/jp_transliterate.dart';

class KanjiBrowsePage extends GetView<KanjiBrowseController> {
  const KanjiBrowsePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        animationDuration: Duration(milliseconds: 300),
        length: controller.viewKanjis.length,
        child: Builder(
          builder: (BuildContext innerContext) => Scaffold(
            appBar: AppBar(
              title: Text("Kanji"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () async {
                      await showSearch(
                              context: context,
                              delegate: CustomSearchDeletgate(),
                              query: "")
                          .then((v) {
                        DefaultTabController.of(innerContext)
                            .animateTo(controller.index.value);
                      });
                    },
                    icon: Icon(Icons.search_rounded)),
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.KANJI_HOW);
                  },
                  icon: Icon(Icons.question_mark),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: TabBarView(
                    children: controller.viewKanjis
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FutureBuilder(
                                      future: loadKanjiSVG(e.kanji),
                                      builder: (context, asyncSnapshot) {
                                        if (asyncSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return SizedBox(
                                            height: 150,
                                            width: 150,
                                          );
                                        }

                                        const parser = KanjiParser();
                                        var kvg;
                                        try {
                                          kvg = parser.parse(
                                              asyncSnapshot.data.toString());
                                        } catch (e) {
                                          log(e.toString());
                                        }

                                        return SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: KanjiDetailCard(
                                            kvg: kvg,
                                          ),
                                        );
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("kunyomi"),
                                        Text(e.kunyomi != null
                                            ? e.kunyomi!
                                                .replaceAll('、', "\n")
                                                .replaceAll("（", "")
                                                .replaceAll("）", "")
                                                .toString()
                                            : ''),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("onYomi"),
                                        Text(e.onyomi != null
                                            ? e.onyomi!
                                                .replaceAll('、', "\n")
                                                .replaceAll("（", "")
                                                .replaceAll("）", "")
                                                .toString()
                                            : ''),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    AppRoutes.EDIT_KANJI,
                                                    arguments: [e]);
                                              },
                                              icon: Icon(Icons.edit),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                speakString(
                                                    "${e.kunyomi!},${e.onyomi ?? ''}");
                                              },
                                              icon: Icon(Icons.volume_up),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                TabBar(
                  onTap: (value) {
                    controller.index.value = value;
                  },
                  isScrollable: true,
                  tabs: controller.viewKanjis
                      .map((e) => Container(
                            margin: EdgeInsets.all(10),
                            child: Tab(
                              child: Text(e.kanji),
                            ),
                          ))
                      .toList(),
                ),
                Expanded(
                  flex: 3,
                  child: TabBarView(
                    children: controller.viewKanjis
                        .map(
                          (e) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: e.vocabularies
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ListTile(
                                      // leading: Text(
                                      //   e.kanji,
                                      // ),
                                      title: FutureBuilder<
                                          List<TransliterationData>>(
                                        future:
                                            JpTransliterate.transliterateWords(
                                                kanji: e.kanji),
                                        builder: (context, snapshot) {
                                          if (snapshot.data != null) {
                                            return FuriganaText(
                                              transliterations:
                                                  snapshot.data ?? [],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                              rubyStyle:
                                                  const TextStyle(fontSize: 8),
                                            );
                                          } else {
                                            return Text("");
                                          }
                                        },
                                      ),
                                      subtitle: Text(e.meaning),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          await speak(e);
                                        },
                                        icon: Icon(Icons.speaker),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDeletgate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.search))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    Get.find<KanjiBrowseController>().search(query);
    return Obx(
      () => ListView.builder(
        itemCount: Get.find<KanjiBrowseController>().searchedKanji.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
                Get.find<KanjiBrowseController>().searchedKanji[index].kanji),
            title: Text(
                Get.find<KanjiBrowseController>().searchedKanji[index].kanji),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Get.find<KanjiBrowseController>().search(query);
    return Obx(
      () => ListView.builder(
        itemCount: Get.find<KanjiBrowseController>().searchedKanji.length,
        itemBuilder: (context, index) {
          final result = Get.find<KanjiBrowseController>().searchedKanji[index];
          return InkWell(
            onTap: () {
              final controller = Get.find<KanjiBrowseController>();
              final targetIdx = controller.viewKanjis
                  .indexWhere((k) => k.kanji == result.kanji);
              controller.index.value = targetIdx;
              Get.back();
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                child: Center(
                  child: Text(result.kanji),
                ),
              ),
              title: Text(result.meaning ?? ""),
              subtitle: Text("${result.kunyomi}, ${result.onyomi}"),
            ),
          );
        },
      ),
    );
  }
}
