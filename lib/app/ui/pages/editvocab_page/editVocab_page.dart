import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/editvocab_controller.dart';
import 'package:n4/app/routes/app_routes.dart';

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
                  controller: controller.meaning,
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
                          selected: controller.type.value == "noun",
                          label: Text("noun"),
                          onSelected: (value) {
                            controller.type.value = "noun";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "verb1",
                          label: Text("verb-1"),
                          onSelected: (value) {
                            controller.type.value = "verb1";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "verb2",
                          label: Text("verb-2"),
                          onSelected: (value) {
                            controller.type.value = "verb2";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "verb3",
                          label: Text("verb-3"),
                          onSelected: (value) {
                            controller.type.value = "verb3";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "iAdj",
                          label: Text("i-adj"),
                          onSelected: (value) {
                            // iAdj', 'naAdji', 'speaking', 'suffix'
                            controller.type.value = "iAdj";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "naAdji",
                          label: Text("na-adji"),
                          onSelected: (value) {
                            controller.type.value = "naAdji";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "speaking",
                          label: Text("speaking"),
                          onSelected: (value) {
                            controller.type.value = "speaking";
                            controller.onChange();
                          },
                        ),
                        ChoiceChip(
                          selectedColor: Get.theme.colorScheme.primaryContainer,
                          selected: controller.type.value == "suffix",
                          label: Text("suffix"),
                          onSelected: (value) {
                            controller.type.value = "suffix";
                            controller.onChange();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Same Meaning
                Obx(
                  () => controller.isNew
                      ? SizedBox.shrink()
                      : Card(
                          child: Column(children: <Widget>[
                            ListTile(
                              onTap: () {
                                showSearch(
                                  context: context,
                                  delegate: CustomSearchDeletgate(),
                                  query: "",
                                );
                              },
                              title: Text("List of Same Meaning"),
                              subtitle: Text("add same meaning vocabulary"),
                              trailing: Icon(Icons.add_circle_outline),
                            ),
                            Column(
                                children: controller.sameMeaningList
                                        .map((vocab) => ListTile(
                                              leading: Text(
                                                  "id #${vocab.id}\nchapter #${vocab.chapter}"),
                                              title: Text(vocab.kana),
                                              subtitle: Text(vocab.meaning),
                                              trailing: IconButton(
                                                icon: Icon(Icons.remove_circle),
                                                onPressed: () {
                                                  controller.sameMeaningList
                                                      .remove(vocab);
                                                  controller
                                                      .checkSameMeaningEdited();
                                                },
                                              ),
                                            ))
                                        .toList() ??
                                    []),
                          ]),
                        ),
                )
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

class CustomSearchDeletgate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.search))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Get.find<EditvocabController>().searchVocab(query);
    return Obx(
      () {
        if (Get.find<EditvocabController>().searchedVocab.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No result found"),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.EDITVOCAB);
                    },
                    child: Text("Add New Vocab ?")),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: Get.find<EditvocabController>().searchedVocab.length,
          itemBuilder: (context, index) {
            final result = Get.find<EditvocabController>().searchedVocab[index];
            return InkWell(
              onTap: () {},
              child: Obx(
                () => ListTile(
                  leading: Text("#${result.id}"),
                  title: Text(result.kana),
                  subtitle: Text(result.meaning ?? ""),
                  trailing: IconButton(
                    icon: Icon(
                        Get.find<EditvocabController>().isSelected(result)
                            ? Icons.check_circle
                            : Icons.add_circle_outline),
                    onPressed: () {
                      Get.find<EditvocabController>()
                          .toggleAddSameMeaning(result);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
