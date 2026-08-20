import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/editvocab_controller.dart';

class EditVocabPage extends GetView<EditvocabController> {
  const EditVocabPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.isNew ? 'Add Vocabulary' : 'Edit Vocabulary'),
        ),
        actions: [
          Obx(
            () => controller.isNew
                ? SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Delete Vocabulary',
                        middleText:
                            'Are you sure you want to delete this vocabulary?',
                        textCancel: 'Cancel',
                        textConfirm: 'Delete',
                        confirmTextColor: Get.theme.colorScheme.onPrimary,
                        onConfirm: () async {
                          await controller.deleteVocab();
                          Get.back();
                          Get.back();
                        },
                        buttonColor: Get.theme.colorScheme.error,
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Kana",
                  style: Get.textTheme.titleMedium,
                ),
                TextField(
                  onChanged: (value) => controller.onChange(),
                  controller: controller.kana,
                  decoration: InputDecoration(
                    // icon: Icon(Icons.help_outline),
                    // label: Text("Kana"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Text(
                  "Kanji (optional)",
                  style: Get.textTheme.titleMedium,
                ),
                TextField(
                  onChanged: (value) => controller.onChange(),
                  controller: controller.kanji,
                  decoration: InputDecoration(
                    // icon: Icon(Icons.help_outline),
                    // label: Text("Kanji"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Text(
                  "Meaning",
                  style: Get.textTheme.titleMedium,
                ),
                TextField(
                  onChanged: (value) => controller.onChange(),
                  controller: controller.meaing,
                  decoration: InputDecoration(
                    // icon: Icon(Icons.help_outline),
                    // label: Text("Meaning"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Text(
                  "Note (optional)",
                  style: Get.textTheme.titleMedium,
                ),
                TextField(
                  onChanged: (value) => controller.onChange(),
                  controller: controller.note,
                  decoration: InputDecoration(
                    hintMaxLines: 30,
                    // icon: Icon(Icons.help_outline),
                    // label: Text("Note"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Text(
                  "Example (optional)",
                  style: Get.textTheme.titleMedium,
                ),
                TextField(
                  onChanged: (value) => controller.onChange(),
                  controller: controller.example,
                  decoration: InputDecoration(
                    hintMaxLines: 30,
                    // icon: Icon(Icons.help_outline),
                    // label: Text("Example"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) => controller.onChange(),
                  controller: controller.chapter,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    // icon: Icon(Icons.help_outline),
                    label: Text("Chapter"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Obx(
                  () => Center(
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        // SizedBox(
                        //   width: 100,
                        //   child: TextField(
                        //     controller: controller.chapter,
                        //     keyboardType: TextInputType.numberWithOptions(),
                        //     decoration: InputDecoration(
                        //       // icon: Icon(Icons.help_outline),
                        //       label: Text("Chapter"),
                        //       border: OutlineInputBorder(),
                        //     ),
                        //   ),
                        // ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "Noun",
                          label: Text("noun"),
                          onSelected: (value) {
                            controller.type.value = "Noun";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "Verb 1",
                          label: Text("verb-1"),
                          onSelected: (value) {
                            controller.type.value = "Verb 1";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "Verb 2",
                          label: Text("verb-2"),
                          onSelected: (value) {
                            controller.type.value = "Verb 2";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "Verb 3",
                          label: Text("verb-3"),
                          onSelected: (value) {
                            controller.type.value = "Verb 3";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "I-Adjective",
                          label: Text("i-adj"),
                          onSelected: (value) {
                            controller.type.value = "I-Adjective";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "Na-Adjective",
                          label: Text("na-adji"),
                          onSelected: (value) {
                            controller.type.value = "Na-Adjective";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "Speaking",
                          label: Text("speaking"),
                          onSelected: (value) {
                            controller.type.value = "Speaking";
                            controller.onChange();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => controller.isEdited.value
            ? FloatingActionButton(
                onPressed: () {
                  controller.saveVocab();
                },
                child: Icon(Icons.save))
            : Container(),
      ),
    );
  }
}
