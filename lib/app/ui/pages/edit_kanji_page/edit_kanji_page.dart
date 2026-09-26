import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n4/app/controllers/edit_kanji_controller.dart';

class EditKanjiPage extends GetView<EditKanjiController> {
  const EditKanjiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.isEditing.value ? 'Edit Kanji' : 'Add Kanji'),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => controller.isEditing.value
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Delete Kanji',
                        middleText:
                            'Are you sure you want to delete this kanji?',
                        textCancel: 'Cancel',
                        textConfirm: 'Delete',
                        confirmTextColor: Get.theme.colorScheme.onPrimary,
                        onConfirm: () async {
                          await controller.deleteKanji();
                          Get.back();
                          Get.back();
                        },
                        buttonColor: Get.theme.colorScheme.error,
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kanji', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (_) => controller.onEdit(),
                  controller: controller.kanjiTEC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Kanji Number', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (_) => controller.onEdit(),
                  controller: controller.kanjiNumberTEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Level', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (_) => controller.onEdit(),
                  controller: controller.levelTEC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Kunyomi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (_) => controller.onEdit(),
                  controller: controller.kunyomiTEC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Onyomi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (_) => controller.onEdit(),
                  controller: controller.onyomiTEC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Meaning', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (_) => controller.onEdit(),
                  controller: controller.meaningTEC,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Examples', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (_) => controller.onEdit(),
                  controller: controller.examplesTEC,
                  minLines: 4,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Card(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: RelatedVocabSearchDelegate(),
                              query: '',
                            );
                          },
                          title: const Text('Related Vocabulary'),
                          subtitle: const Text('add related vocabularies'),
                          trailing: const Icon(Icons.add_circle_outline),
                        ),
                        if (controller.relatedVocabs.isEmpty)
                          const Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                            child: Text('No related vocabulary yet'),
                          )
                        else
                          ...controller.relatedVocabs.map(
                            (vocab) => ListTile(
                              leading: Text(
                                  '#${vocab.id ?? 0}\nchapter #${vocab.chapter}'),
                              title: Text(vocab.kana),
                              subtitle: Text(vocab.meaning),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () {
                                  controller.toggleRelatedVocab(vocab);
                                },
                              ),
                            ),
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
                onPressed: () async {
                  await controller.saveKanji();
                },
                child: const Icon(Icons.save),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class RelatedVocabSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.search))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Get.find<EditKanjiController>().searchVocab(query);

    return Obx(() {
      final controller = Get.find<EditKanjiController>();

      if (controller.searchedVocab.isEmpty) {
        return const Center(
          child: Text('No result found'),
        );
      }

      return ListView.builder(
        itemCount: controller.searchedVocab.length,
        itemBuilder: (context, index) {
          final result = controller.searchedVocab[index];
          return ListTile(
            leading: Text('#${result.id ?? 0}'),
            title: Text(result.kana),
            subtitle: Text(result.meaning),
            trailing: IconButton(
              icon: Icon(
                controller.isSelected(result)
                    ? Icons.check_circle
                    : Icons.add_circle_outline,
              ),
              onPressed: () {
                controller.toggleRelatedVocab(result);
              },
            ),
          );
        },
      );
    });
  }
}
