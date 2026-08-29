import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/kanji_how_controller.dart';
import 'package:n4/app/ui/global_widgets/kanji_detail_card.dart';
import 'package:n4/app/ui/utils/util.dart';

class KanjiHowPage extends GetView<KanjiHowController> {
  const KanjiHowPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to Draw"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.fontSizeIncrease();
            },
            icon: Icon(Icons.format_size),
          ),
          IconButton(
            onPressed: () {
              controller.fontSizeDecrease();
            },
            icon: Icon(Icons.format_size),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height * 0.7,
                    child: Obx(
                      () => Wrap(
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.center,
                        children: controller.kanji.value
                            .split('')
                            .map(
                              (e) => FutureBuilder(
                                future: loadKanjiSVG(e),
                                builder: (context, asyncSnapshot) {
                                  if (asyncSnapshot.data == null) {
                                    return SizedBox.shrink();
                                  }
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
                                    kvg = parser
                                        .parse(asyncSnapshot.data.toString());
                                  } catch (e) {
                                    log(e.toString());
                                  }

                                  return Obx(
                                    () => AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                      height: controller.fontSize.value,
                                      width: controller.fontSize.value,
                                      child: KanjiDetailCard(kvg: kvg),
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (text) {
                  controller.kanji.value = text;
                },
                maxLines: 5,
                minLines: 1,
                style: const TextStyle(fontSize: 16.0),
                decoration: const InputDecoration(
                  hintText: 'Kanjis Text',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                speakString(controller.kanji.value);
              },
              icon: const Icon(Icons.volume_up),
            ),
          ],
        ),
      ),
    );
  }
}
