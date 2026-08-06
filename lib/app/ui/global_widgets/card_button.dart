import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cardButton(
    {double? width,
    double padding = 20,
    IconData? icon,
    String text = "Learn",
    void Function()? onPressed}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Get.theme.colorScheme.primary,
      ),
      width: width ?? Get.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              spacing: 10,
              children: [
                Icon(
                  icon ?? Icons.book,
                  color: Get.theme.colorScheme.onPrimary,
                  size: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: Get.textTheme.titleLarge!.copyWith(
                        color: Get.theme.colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      "learn $text",
                      style: TextStyle(
                        color: Get.theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: Get.theme.colorScheme.primaryContainer),
                child: Icon(
                  Icons.arrow_forward,
                  color: Get.theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget cardButton2(
    {double? width,
    double padding = 20,
    IconData? icon,
    String text = "Learn",
    void Function()? onPressed}) {
  return InkWell(
    borderRadius: BorderRadius.circular(5),
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Get.theme.colorScheme.primary,
      ),
      width: width ?? Get.width * 0.6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
     
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Get.textTheme.headlineSmall!.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
                Text(
                  "Learn $text",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: Get.width * 0.14,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(10),
                ),
                color: Get.theme.colorScheme.primaryContainer),
            child: Icon(
              Icons.arrow_forward,
              color: Get.theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    ),
  );
}
