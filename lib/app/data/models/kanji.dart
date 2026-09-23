import 'package:equatable/equatable.dart';
import 'package:n4/app/data/models/vocabulary.dart';

class Kanji extends Equatable {
  int? id;
  int kanjiNumber;
  String kanji;
  String? level;
  String? kunyomi;
  String? onyomi;
  String? meaning;
  String? examples;
  List<Vocabulary> vocabularies;

  Kanji({
    this.id,
    required this.kanjiNumber,
    required this.kanji,
    this.level,
    this.kunyomi,
    this.onyomi,
    this.meaning,
    this.examples,
    this.vocabularies = const <Vocabulary>[],
  });

  factory Kanji.fromMap(Map<String, dynamic> map) {
    return Kanji(
      id: map['id'] as int?,
      kanjiNumber: map['kanji_number'] as int,
      kanji: map['kanji'] as String,
      level: map['level'] as String?,
      kunyomi: map['kunyomi'] as String?,
      onyomi: map['onyomi'] as String?,
      meaning: map['meaning'] as String?,
      examples: map['examples'] as String?,
      vocabularies: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kanji_number': kanjiNumber,
      'kanji': kanji,
      'level': level,
      'kunyomi': kunyomi,
      'onyomi': onyomi,
      'meaning': meaning,
      'examples': examples,
    };
  }

  @override
  List<Object?> get props => [
        id,
        kanjiNumber,
        kanji,
        level,
        kunyomi,
        onyomi,
        meaning,
        examples,
        vocabularies
      ];
}
