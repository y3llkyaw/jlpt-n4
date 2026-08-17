import 'package:flutter/material.dart';
import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';

class KanjiCard extends StatefulWidget {
  const KanjiCard({Key? key, required this.source}) : super(key: key);

  final String source;

  @override
  State<KanjiCard> createState() => _KanjiCardState();
}

class _KanjiCardState extends State<KanjiCard> with TickerProviderStateMixin {
  late final KanjiController controller;

  @override
  void initState() {
    super.initState();

    const parser = KanjiParser();
    final data = parser.parse(widget.source);

    controller = KanjiController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..load(data)
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.43,
      width: Get.width * 0.43,
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.2,
              height: Get.width * 0.2,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  controller.reset();
                  controller.forward();
                },
                child: KanjiCanvas(
                  controller: controller,
                  thickness: 3,
                  color: Get.textTheme.titleLarge!.color!,
                  hintColor:
                      Get.textTheme.titleLarge!.color!.withValues(alpha: 0.3),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("えき"),
                Text("train station"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
