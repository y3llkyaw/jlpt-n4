import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:n4/app/data/models/vocabulary.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

Future<void> speak(Vocabulary vocab) async {
  final flutterTts = FlutterTts();
  await flutterTts.setLanguage('ja-JP');
  await flutterTts.setSpeechRate(0.4);
  await flutterTts.setPitch(1.2);
  await flutterTts.awaitSpeakCompletion(true);
  await flutterTts.speak(vocab.kana);
  if (vocab.sameMeaningVocabs.isNotEmpty) {
    for (final sameMeaningVocab in vocab.sameMeaningVocabs) {
      await flutterTts.speak(sameMeaningVocab.kana);
    }
  }
}

Future<void> speakString(String text) async {
  final flutterTts = FlutterTts();
  await flutterTts.setLanguage('ja-JP');
  await flutterTts.setSpeechRate(0.4);
  await flutterTts.setPitch(1.2);
  await flutterTts.awaitSpeakCompletion(true);
  await flutterTts.speak(text);
}

Future<String> loadKanjiSVG(String kanji) async {
  int codePoint = kanji.runes.first;
  return await rootBundle
      .loadString('assets/kanji/0${codePoint.toRadixString(16)}.svg');
}
