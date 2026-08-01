import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/routes/app_routes.dart';

Widget listCard(Vocabulary vocab, int index, List<Vocabulary> vocabList,
    {bool isReview = false}) {
  final cardKey = ValueKey(
      'vocab-card-${vocab.id ?? index}-${vocab.kana}-${vocab.meaning}');

  return Container(
    key: cardKey,
    padding: EdgeInsets.all(10),
    child: FlipCard(
      key: ValueKey('flip-card-${vocab.id ?? index}-${vocab.kana}'),
      direction: FlipDirection.VERTICAL,
      front: Container(
        height: 250,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          color: Get.theme.colorScheme.primaryContainer,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "#${index + 1}",
                  style: Get.textTheme.titleMedium!.copyWith(
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
                // Chip(label: Text(vocab.partOfSpeech))
              ],
            ),
            Center(
              child: Text(
                vocab.kana,
                style: Get.textTheme.titleLarge!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Center(child: Text(vocab.meaning)),
            // Row(
            //   spacing: 5,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         Get.toNamed(AppRoutes.EDITVOCAB,
            //             arguments: [vocab, vocabList, index]);
            //       },
            //       icon: Icon(Icons.edit_note),
            //     ),
            //     ElevatedButton.icon(
            //       onPressed: () {},
            //       label: Text("Speak"),
            //       icon: Icon(Icons.speaker),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
      back: Container(
        height: 250,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          color: Get.theme.colorScheme.primaryContainer,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#${index + 1}",
                  style: Get.textTheme.titleMedium!.copyWith(
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
                // Chip(label: Text(vocab.partOfSpeech))
                Row(
                  children: [
                    Chip(
                      label: Text(
                        vocab.partOfSpeech,
                        style: Get.textTheme.bodyMedium!.copyWith(
                            color: Get.theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      color:
                          WidgetStatePropertyAll(Get.theme.colorScheme.primary),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: Text(
                vocab.kana,
                style: Get.textTheme.titleLarge!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(child: Text(vocab.meaning)),
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.EDITVOCAB,
                        arguments: [vocab, vocabList, index]);
                  },
                  icon: Icon(Icons.edit_note),
                ),
                // ElevatedButton.icon(
                //   onPressed: () {

                //   },
                //   label: Text("Delete"),
                //   icon: Icon(Icons.delete_forever),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     Get.toNamed(AppRoutes.EDITVOCAB,
                //         arguments: [vocab, vocabList, index]);
                //   },
                //   label: Text("Edit"),
                //   icon: Icon(Icons.edit),
                // ),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text("Speak"),
                  icon: Icon(Icons.speaker),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
