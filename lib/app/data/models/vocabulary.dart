import 'package:equatable/equatable.dart';

class Vocabulary extends Equatable {
  int? id;
  int chapter;
  String kana;
  String kanji;
  String meaning;
  String partOfSpeech;
  String? note;
  String? example;
  List<Vocabulary> sameMeaningVocabs; // Mutable list to hold relations

  Vocabulary({
    this.id,
    required this.chapter,
    required this.kana,
    required this.kanji,
    required this.meaning,
    required this.partOfSpeech,
    this.note,
    this.example,
    this.sameMeaningVocabs = const [],
  });

  factory Vocabulary.fromMap(Map<String, dynamic> map) {
    return Vocabulary(
      id: map['id'] as int,
      chapter: map['chapter'] as int,
      kana: map['kana'] as String,
      kanji: map['kanji'] as String? ?? '',
      meaning: map['meaning'] ?? '',
      partOfSpeech: map['part_of_speech'] as String,
      note: map['note'],
      example: map['example'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapter': chapter,
      'kana': kana,
      'kanji': kanji,
      'meaning': meaning,
      'part_of_speech': partOfSpeech.toLowerCase().toString(),
      'note': note,
      'example': example,
    };
  }

  @override
  List<Object?> get props => [
        id,
        chapter,
        kana,
        kanji,
        meaning,
        partOfSpeech,
        note,
        example,
        sameMeaningVocabs
      ];
}
