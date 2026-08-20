import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';
import 'package:n4/app/ui/global_widgets/kanji_card.dart';
import 'package:n4/app/ui/utils/util.dart';
import '../../../controllers/kanji_browse_controller.dart';

class KanjiBrowsePage extends GetView<KanjiBrowseController> {
  const KanjiBrowsePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
          itemCount: controller.kanjis.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => FutureBuilder(
              future: loadKanjiSVG(controller.kanjis[index].kanji),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Text("loading");
                }
                Get.log(controller.kanjis.length.toString());
                // return Text("data");
                const parser = KanjiParser();
                // // log(asyncSnapshot.);
                var kvg;
                try {
                  kvg = parser.parse(asyncSnapshot.data.toString());
                } catch (e) {
                  log(e.toString());
                }

                print(index);
                // asyncSnapshot.data;
                return KanjiCard(kvg: kvg, kanji: controller.kanjis[index]);
              })),
    );
  }
}
