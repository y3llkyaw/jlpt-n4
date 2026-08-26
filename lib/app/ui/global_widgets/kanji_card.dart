import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/kanji.dart';

class KanjiCard extends StatefulWidget {
  const KanjiCard({Key? key, required this.kvg, required this.kanji})
      : super(key: key);

  final KvgData kvg;
  final Kanji kanji;

  @override
  State<KanjiCard> createState() => _KanjiCardState();
}

class _KanjiCardState extends State<KanjiCard> with TickerProviderStateMixin {
  late final KanjiController controller;
  int indexSlider = 0;

  @override
  void initState() {
    super.initState();

    controller = KanjiController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..load(widget.kvg)
      ..forward();
  }

  @override
  void didUpdateWidget(KanjiCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.kvg != widget.kvg) {
      // Reload controller with new KvgData
      controller
        ..reset()
        ..load(widget.kvg)
        ..forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            height: Get.width * 0.4,
            child: CarouselSlider(
              items: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.reset();
                          controller.forward();
                        },
                        child: SizedBox(
                          width: Get.width * 0.2,
                          height: Get.width * 0.2,
                          child: KanjiCanvas(
                            controller: controller,
                            color: Get.theme.textTheme.titleLarge!.color!,
                            hintColor: Get.theme.textTheme.titleLarge!.color!
                                .withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      Text(
                        widget.kanji.meaning ?? "",
                      )
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.43,
                  height: Get.width * 0.43,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("訓読み"),
                          Text(
                            widget.kanji.kunyomi
                                    ?.replaceAll(", ", "\n")
                                    .replaceAll("、", "\n")
                                    .replaceAll("）", ')')
                                    .replaceAll("（", "(") ??
                                "~",
                            style: Get.textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("音読み"),
                          Text(
                            widget.kanji.onyomi ?? "~",
                            style: Get.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       "${widget.kanji.examples?.split(" ")[0]} ${widget.kanji.examples?.split(" ")[1]}" ??
                //           "",
                //       style: Get.textTheme.titleSmall,
                //     ),
                //     Text(widget.kanji.meaning ?? ""),
                //     Text(widget.kanji.examples?.split("|")[0] ?? ""),
                //   ],
                // ),
              ],
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: Get.width * 0.43,
                onPageChanged: ((index, reason) {
                  setState(() {
                    indexSlider = index;
                  });
                }),
                viewportFraction: 1,
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
          Column(
            spacing: 10,
            children: [
              AnimatedContainer(
                width: 5,
                height: 5,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: indexSlider == 0
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              AnimatedContainer(
                width: 5,
                height: 5,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: indexSlider == 1
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              // AnimatedContainer(
              //   width: 5,
              //   height: 5,
              //   duration: Duration(milliseconds: 500),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: indexSlider == 2
              //         ? Get.theme.colorScheme.primary
              //         : Get.theme.colorScheme.primaryContainer,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
