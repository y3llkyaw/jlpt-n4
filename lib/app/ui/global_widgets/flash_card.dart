import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/routes/app_routes.dart';

Widget flashCard(
    bool isTest, Vocabulary vocab, int index, List<Vocabulary> vocabList) {
  return Container(
    width: Get.width * 0.7,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Get.theme.colorScheme.primaryContainer,
    ),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Chip(
              label: Text(vocab.partOfSpeech),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.EDITVOCAB,
                    arguments: [vocab, index, vocabList]);
              },
              child: Text("Edit Card"),
            )
          ],
        ),
        Expanded(
            child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedEmoji(AnimatedEmojis.collision,size: 100,),
            Text(
              vocab.kana,
              style: Get.textTheme.titleLarge!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              vocab.kanji,
              style: Get.textTheme.titleLarge!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
            ),
            // Divider(),
            Text(
              vocab.meaning,
              style: Get.textTheme.bodyLarge!
                  .copyWith(color: Get.theme.colorScheme.onPrimaryContainer),
            ),
            Text(
              vocab.note,
              style: Get.textTheme.bodyLarge!
                  .copyWith(color: Get.theme.colorScheme.onPrimaryContainer),
            ),
            Text(
              vocab.example,
              style: Get.textTheme.bodyLarge!
                  .copyWith(color: Get.theme.colorScheme.onPrimaryContainer),
            ),
          ],
        )),
        isTest
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                      icon: Icon(Icons.thumb_down),
                      onPressed: () {},
                      label: Text("Forgot")),
                  ElevatedButton.icon(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () {},
                    label: Text(
                      "Know",
                      style: TextStyle(color: Get.theme.colorScheme.onPrimary),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Get.theme.colorScheme.primary,
                      ),
                      iconColor: WidgetStateProperty.all(
                        Get.theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              )
            : Container()
      ],
    ),
  );
}
