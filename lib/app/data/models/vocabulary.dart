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

  Vocabulary(this.id, this.chapter, this.kana, this.kanji, this.meaning,
      this.partOfSpeech, this.note, this.example);

  factory Vocabulary.fromMap(Map<String, dynamic> map) {
    return Vocabulary(
        map['id'] as int,
        map['chapter'] as int,
        map['kana'] as String,
        map['kanji'] as String? ?? '',  
        map['meaning'] ?? '',
        map['part_of_speech'] as String,
        map['note'],
        map['example']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapter': chapter,
      'kana': kana,
      'kanji': kanji,
      'meaning': meaning,
      'part_of_speech': partOfSpeech,
      'note': note,
      'example': example,
    };
  }
  
  @override
  List<Object?> get props => [id,chapter,kana,kanji,meaning,partOfSpeech,note,example];
}
