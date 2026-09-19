import 'package:flutter/material.dart';
import 'package:n4/app/data/models/kanji.dart';

class EditKanjiPage extends StatelessWidget {
  final Kanji? kanji;

  const EditKanjiPage({Key? key, this.kanji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = kanji != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Kanji' : 'Add Kanji'),
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
                  initialValue: kanji?.kanji ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Kanji Number', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: kanji?.kanjiNumber.toString() ?? '',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Level (optional)', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: kanji?.level ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Kunyomi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: kanji?.kunyomi ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Onyomi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: kanji?.onyomi ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Meaning', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: kanji?.meaning ?? '',
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
                  initialValue: kanji?.examples ?? '',
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
                      if ((kanji?.vocabularies ?? []).isEmpty)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                          child: Text('No related vocabulary yet'),
                        )
                      else
                        ...List.generate(
                          kanji?.vocabularies.length ?? 0,
                          (index) {
                            final vocab = kanji!.vocabularies[index];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
    );
  }
}
