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
        title: Text(controller.isEditing.value ? 'Edit Kanji' : 'Add Kanji'),
        centerTitle: true,
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
                  onChanged: (value) {
                    controller.onEdit();
                  },
                  controller: controller.kanjiTEC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Kunyomi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) {
                    controller.onEdit();
                  },
                  controller: controller.kunyomiTEC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Onyomi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) {
                    controller.onEdit();
                  },
                  controller: controller.onyomiTEC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Meaning', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) {
                    controller.onEdit();
                  },
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
                  onChanged: (value) {
                    controller.onEdit();
                  },
                  controller: controller.examplesTEC,
                  minLines: 4,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Related Vocabulary'),
                        subtitle: const Text('linked vocabularies'),
                        trailing: const Icon(Icons.list_alt_outlined),
                      ),
                      if ((controller.kanji.value?.vocabularies ?? []).isEmpty)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                          child: Text('No related vocabulary yet'),
                        )
                      else
                        ...List.generate(
                          controller.kanji.value?.vocabularies.length ?? 0,
                          (index) {
                            final vocab =
                                controller.kanji.value!.vocabularies[index];
                            return ListTile(
                              leading: Text('#${vocab.id ?? index + 1}'),
                              title: Text(vocab.kana),
                              subtitle: Text(vocab.meaning),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        ()=> controller.isEdited.value
            ? FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.save),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
