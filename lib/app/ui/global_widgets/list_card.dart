import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';
import 'package:n4/app/routes/app_routes.dart';

Widget listCard(Vocabulary vocab, int index) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Get.theme.colorScheme.primaryContainer,
    ),
    child: Column(
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
            Chip(
              label: Text(
                vocab.partOfSpeech,
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
              color: WidgetStatePropertyAll(Get.theme.colorScheme.primary),
            )
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.EDITVOCAB, arguments: vocab);
              },
              label: Text("Edit"),
              icon: Icon(Icons.edit),
            ),
          ],
        )
      ],
    ),
  );
}
