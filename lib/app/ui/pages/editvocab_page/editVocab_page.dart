import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/editvocab_controller.dart';

class EditVocabPage extends GetView<EditvocabController> {
  const EditVocabPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.printVocab();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text(
              "Edit Vocabulary",
              style: Get.textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.kana,
              decoration: InputDecoration(
                icon: Icon(Icons.help_outline),
                label: Text("Kana"),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controller.kanji,
              decoration: InputDecoration(
                icon: Icon(Icons.help_outline),
                label: Text("Kanji"),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controller.meaing,
              decoration: InputDecoration(
                icon: Icon(Icons.help_outline),
                label: Text("Meaning"),
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: controller.chapter,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.help_outline),
                      label: Text("Chapter"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                DropdownMenu(
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "noun", label: "noun"),
                    DropdownMenuEntry(value: "verb1", label: "verb1"),
                    DropdownMenuEntry(value: "verb2", label: "verb2"),
                    DropdownMenuEntry(value: "verb3", label: "verb3"),
                    DropdownMenuEntry(value: "na-adji", label: "na-adji"),
                    DropdownMenuEntry(value: "i-adji", label: "i-adji"),
                    DropdownMenuEntry(value: "speaking", label: "speaking"),
                  ],
                ),
              ],
            ),
            TextField(
              controller: controller.note,
              decoration: InputDecoration(
                hintMaxLines: 30,
                icon: Icon(Icons.help_outline),
                label: Text("Note"),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: controller.note,
              decoration: InputDecoration(
                hintMaxLines: 30,
                icon: Icon(Icons.help_outline),
                label: Text("Example"),
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Get.theme.colorScheme.primaryContainer),
                    textStyle: WidgetStatePropertyAll(
                      Get.textTheme.bodyMedium!.copyWith(
                          color: Get.theme.colorScheme.onPrimaryContainer),
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Save Changes"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
