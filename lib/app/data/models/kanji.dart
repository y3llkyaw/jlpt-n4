class Kanji {
  final int? id;
  final int kanjiNumber;
  final String kanji;
  final String? level;
  final String? kunyomi;
  final String? onyomi;
  final String? meaning;
  final String? examples;

  Kanji({
    this.id,
    required this.kanjiNumber,
    required this.kanji,
    this.level,
    this.kunyomi,
    this.onyomi,
    this.meaning,
    this.examples,
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
}
