import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/ui/utils/util.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard({Key? key, required this.vocab, required this.index})
      : super(key: key);
  final Vocabulary vocab;
  final int index;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  bool _showAnswer = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          speak(widget.vocab);
          setState(() {
            _showAnswer = !_showAnswer;
          });
        },
        child: Card(
          elevation: 1,
          child: SizedBox(
            height: Get.height * 0.6,
            width: Get.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    "#${widget.index.toString()}",
                    style: Get.textTheme.bodyMedium,
                  ),
                  Chip(
                    label: Text(
                      widget.vocab.partOfSpeech,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _showAnswer ? 1 : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.kanji,
                      style: Get.textTheme.headlineSmall,
                    ),
                  ),
                  Text(
                    widget.vocab.kana,
                    style: Get.textTheme.displaySmall,
                  ),
                  AnimatedOpacity(
                    opacity: _showAnswer ? 1 : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.meaning,
                      style: Get.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _showAnswer ? 1 : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.note ?? "",
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _showAnswer ? 1 : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.example ?? "",
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "tap the card to show the answer",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
