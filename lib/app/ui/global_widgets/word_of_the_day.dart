import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/data/models/vocabulary.dart';

class WordOfTheDay extends StatefulWidget {
  const WordOfTheDay({Key? key, this.vocab}) : super(key: key);
  final Vocabulary? vocab;

  @override
  State<WordOfTheDay> createState() => _WordOfTheDayState();
}

class _WordOfTheDayState extends State<WordOfTheDay> {
  int indexSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            height: Get.width * 0.4,
            child: CarouselSlider(
              items: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${widget.vocab?.chapter ?? ""}",
                        style: Get.textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vocab?.kana ?? '',
                            style: Get.textTheme.titleMedium,
                          ),
                          Text(
                            widget.vocab?.partOfSpeech ?? '',
                            style: Get.textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vocab?.meaning ?? '',
                            style: Get.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: Get.width * 0.43,
                onPageChanged: ((index, reason) {
                  setState(() {
                    indexSlider = index;
                  });
                }),
                viewportFraction: 1,
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
          // Column(
          //   spacing: 10,
          //   children: [
          //     AnimatedContainer(
          //       width: 5,
          //       height: 5,
          //       duration: Duration(milliseconds: 500),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: indexSlider == 0
          //             ? Get.theme.colorScheme.primary
          //             : Get.theme.colorScheme.primaryContainer,
          //       ),
          //     ),
          //     AnimatedContainer(
          //       width: 5,
          //       height: 5,
          //       duration: Duration(milliseconds: 500),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: indexSlider != 0
          //             ? Get.theme.colorScheme.primary
          //             : Get.theme.colorScheme.primaryContainer,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
