import 'package:flutter_test/flutter_test.dart';
import 'package:n4/app/controllers/lessondetail_controller.dart';
import 'package:n4/app/data/models/enums.dart';
import 'package:n4/app/data/models/vocabulary.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LessondetailController round handling', () {
    test('finishes a round by returning forgot cards and clearing round lists', () {
      final controller = LessondetailController();
      final forgotCard = Vocabulary(1, 1, 'かな', '漢字', 'meaning', 'noun', '', '');
      final knownCard = Vocabulary(2, 1, 'かな2', '漢字2', 'meaning2', 'verb', '', '');

      controller.vocabs.value = [forgotCard, knownCard];
      controller.addForgotVocab(forgotCard);
      controller.addKnownVocab(knownCard);

      controller.finishedRound();

      expect(controller.vocabsCopy.toList(), [forgotCard, controller.congrat]);
      expect(controller.knownList, isEmpty);
      expect(controller.forgotList, isEmpty);
    });

    test('updates viewVocabs when a filter is selected', () {
      final controller = LessondetailController();
      final nounCard = Vocabulary(1, 1, 'かな', '漢字', 'meaning', 'noun', '', '');
      final verbCard = Vocabulary(2, 1, 'かな2', '漢字2', 'meaning2', 'verb', '', '');

      controller.vocabs.value = [nounCard, verbCard];
      controller.viewVocabs.value = controller.vocabs.toList();

      controller.changeFilter(VocabFilter.noun);

      expect(controller.vocabFilter.value, VocabFilter.noun);
      expect(controller.viewVocabs.map((vocab) => vocab.id).toList(), [1]);
    });
  });
}
