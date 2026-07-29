import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget flashCard() {
  return Container(
    width: Get.width * 0.7,
    decoration: BoxDecoration(
        color: Get.theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Chip(
              label: Text("Verb"),
            ),
            Spacer(),
            TextButton(onPressed: () {}, child: Text("Edit Card"))
          ],
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "hello",
              style: Get.textTheme.displaySmall!
                  .copyWith(color: Get.theme.colorScheme.primary),
            ),
            Text(
              "hello",
              style: Get.textTheme.bodyLarge,
            ),
          ],
        )),
        Row(
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
      ],
    ),
  );
}
