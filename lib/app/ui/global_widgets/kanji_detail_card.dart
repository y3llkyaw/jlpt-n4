import 'package:flutter/material.dart';
import 'package:flutter_kanjivg/flutter_kanjivg.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/kanji.dart';

class KanjiDetailCard extends StatefulWidget {
  const KanjiDetailCard({Key? key, required this.kvg, required this.kanji})
      : super(key: key);

  final KvgData kvg;
  final Kanji kanji;

  @override
  State<KanjiDetailCard> createState() => _KanjiDetailCardState();
}

class _KanjiDetailCardState extends State<KanjiDetailCard>
    with TickerProviderStateMixin {
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
  void didUpdateWidget(KanjiDetailCard oldWidget) {
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
    return InkWell(
      onTap: () {
        controller.reset();
        controller.forward();
      },
      child: KanjiCanvas(
        controller: controller,
        color: Get.theme.textTheme.titleLarge!.color!,
        hintColor:
            Get.theme.textTheme.titleLarge!.color!.withValues(alpha: 0.3),
      ),
    );
  }
}
