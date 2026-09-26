import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jp_transliterate/jp_transliterate.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/ui/utils/util.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard({
    Key? key,
    required this.vocab,
    required this.index,
    this.isReverse = false,
    this.isStudy = false,
  }) : super(key: key);

  final Vocabulary vocab;
  final int index;
  final bool isReverse;
  final bool isStudy;

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
        child: Card.filled(
          color: Get.theme.colorScheme.primaryContainer,
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
                    "#${widget.index + 1}",
                    style: Get.textTheme.bodyMedium,
                  ),
                  Chip(
                    label: Text(
                      widget.vocab.partOfSpeech,
                      style: Get.textTheme.bodyMedium,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: widget.isStudy
                        ? 1
                        : _showAnswer
                            ? 1
                            : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: FutureBuilder<List<TransliterationData>>(
                      future: JpTransliterate.transliterateWords(kanji: widget.vocab.kanji),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return FuriganaText(
                            transliterations: snapshot.data ?? [],
                            style: const TextStyle(fontSize: 20),
                            rubyStyle: const TextStyle(fontSize: 10),
                          );
                        } else {
                          return Text("");
                        }
                      },
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: widget.isStudy
                        ? 1
                        : _showAnswer || widget.isReverse == false
                            ? 1
                            : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.kana,
                      style: Get.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: widget.isStudy
                        ? 1
                        : _showAnswer || widget.isReverse
                            ? 1
                            : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.meaning,
                      style: Get.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: widget.isStudy
                        ? 1
                        : _showAnswer
                            ? 1
                            : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.note ?? "",
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: widget.isStudy
                        ? 1
                        : _showAnswer
                            ? 1
                            : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Text(
                      widget.vocab.example ?? "",
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: widget.isStudy
                        ? 1
                        : _showAnswer
                            ? 1
                            : 0,
                    duration: Durations.medium1,
                    curve: Curves.easeIn,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          widget.vocab.sameMeaningVocabs.isEmpty
                              ? SizedBox.shrink()
                              : Text(
                                  "Same Meaning Vocabularies",
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: widget.vocab.sameMeaningVocabs
                                .map((e) => Chip(
                                      label: Text(e.kana),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                  !widget.isStudy
                      ? Text(
                          "tap the card to show the answer",
                          style: Get.textTheme.bodyMedium!.copyWith(
                            color: Get.theme.colorScheme.secondary,
                          ),
                        )
                      : Container(),
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
