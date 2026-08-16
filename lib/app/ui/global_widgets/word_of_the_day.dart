import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';

class WordOfTheDay extends StatelessWidget {
  WordOfTheDay({Key? key, this.vocab}) : super(key: key);
  Vocabulary? vocab;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        width: Get.width * 0.4,
        height: Get.width * 0.4,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vocab?.kanji ?? '',
                  style: Get.textTheme.titleLarge,
                ),
                Text(
                  vocab?.partOfSpeech ?? '',
                  style: Get.textTheme.titleSmall,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vocab?.kana ?? '',
                  style: Get.textTheme.titleMedium,
                ),
                Text(
                  vocab?.meaning ?? '',
                  style: Get.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
