import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/routes/app_routes.dart';
import 'package:n4/app/ui/utils/util.dart';

Widget listCard(Vocabulary vocab, int? index, List<Vocabulary>? vocabList,
    {bool isReview = false, bool isBack = false}) {
  return Container(
    height: 250,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(color: Get.theme.colorScheme.shadow, blurRadius: 0.5),
      ],
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
            index != null
                ? Text(
                    "#${index + 1}",
                    style: Get.textTheme.titleMedium!.copyWith(
                      color: Get.theme.colorScheme.primary,
                    ),
                  )
                : Text(
                    "#${1}",
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
                    style: Get.textTheme.bodySmall!.copyWith(
                        // color: Get.theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  // color: WidgetStatePropertyAll(Get.theme.colorScheme.primary),
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
        isBack ? Center(child: Text(vocab.meaning)) : SizedBox.shrink(),
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isBack
                ? IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.EDITVOCAB,
                          arguments: [vocab, vocabList, index]);
                    },
                    icon: Icon(Icons.edit_note),
                  )
                : SizedBox(),
            FilledButton.icon(
              onPressed: () async {
                speak(vocab);
              },
              label: Text("Speak"),
              icon: Icon(Icons.volume_up),
            ),
          ],
        ),
      ],
    ),
  );
}
