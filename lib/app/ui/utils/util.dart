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

void speak(Vocabulary vocab) async {
  FlutterTts flutterTts = FlutterTts();
  await flutterTts.setLanguage("ja-JP"); // Japanese accent/voice
  await flutterTts.setSpeechRate(0.4); // Slower speed
  await flutterTts.setPitch(1.2); // Slightly higher pitch
  await flutterTts.speak(vocab.kana);
}

void speakString(String text) async {
  FlutterTts flutterTts = FlutterTts();
  await flutterTts.setLanguage("ja-JP"); // Japanese accent/voice
  await flutterTts.setSpeechRate(0.4); // Slower speed
  await flutterTts.setPitch(1.2); // Slightly higher pitch
  await flutterTts.speak(text);
}

Future<String> loadKanjiSVG(String kanji) async {
  int codePoint = kanji.runes.first;
  return await rootBundle
      .loadString('assets/kanji/0${codePoint.toRadixString(16)}.svg');
}
