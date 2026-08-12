import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';

class WordOfTheDay extends StatelessWidget {
  WordOfTheDay({Key? key, required this.vocab}) : super(key: key);
  Vocabulary? vocab;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.theme.colorScheme.inversePrimary,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Word of the Day",
                      style: Get.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.onPrimaryContainer),
                    ),
                    Text("Aug 5, 2026"),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              vocab!.kana,
              style: Get.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.onPrimaryContainer),
            ),
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(vocab!.partOfSpeech.toLowerCase()),
                Text(vocab!.kanji,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.onPrimaryContainer)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(vocab!.meaning,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.theme.colorScheme.onPrimaryContainer)),
          ],
        ),
      ),
    );
  }
}
