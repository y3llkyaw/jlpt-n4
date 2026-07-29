import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cardButton({
  double? width,
  double padding = 20,
  IconData? icon,
  String text = "Learn",
}) {
  return InkWell(
    onTap: () {
      print("Hello");
    },
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Get.theme.colorScheme.primaryContainer,
      ),
      width: width ?? Get.width * 0.4,
      child: Row(
        spacing: 10,
        children: [
          Icon(
            icon ?? Icons.book,
            color: Get.theme.colorScheme.onPrimaryContainer,
            size: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: Get.textTheme.titleLarge!.copyWith(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                ),
              ),
              Text(
                "learn $text",
                style: TextStyle(
                  color: Get.theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
