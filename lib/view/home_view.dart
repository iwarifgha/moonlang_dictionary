import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view_model/word_entry_vm.dart';
import 'package:uuid/uuid.dart';

class AddWordScreen extends ConsumerWidget {
  const AddWordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, wordVm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Word'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  // if (_isValid(word)) {
                  //   // debugPrint(wordToJson(word));
                  //   // Navigator.pop(context);
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Incomplete word entry')),
                  //   );
                  // }
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Root word',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {},
              ),
              const SizedBox(height: 24),
              ...List.generate(
                wordVm.meanings.length,
                (i) => SenseEditor(index: i),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Meaning'),
                onPressed: () {
                  //add meaning
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class SenseEditor extends ConsumerWidget {
  final int index;
  const SenseEditor({required this.index, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final notifier = ref.read(wordDraftProvider.notifier);
    // final sense = ref.watch(wordDraftProvider).[index];

    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, wVm) {
        final meaning = wVm.meanings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              (meaning.definition ?? '').isEmpty
                  ? 'Meaning ${index + 1}'
                  : '${meaning.pos} — ${meaning.definition}',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: (meaning.pos ?? '').isEmpty ? null : meaning.pos,
                      decoration: const InputDecoration(
                        labelText: 'Part of Speech',
                      ),
                      items: const [
                        DropdownMenuItem(value: 'noun', child: Text('Noun')),
                        DropdownMenuItem(value: 'verb', child: Text('Verb')),
                        DropdownMenuItem(
                          value: 'adj',
                          child: Text('Adjective'),
                        ),
                      ],
                      onChanged: (v) =>
                          wVm.updateMeaning(index, meaning.copyWith(pos: v)),
                    ),
                    TextFormField(
                      initialValue: meaning.definition,
                      decoration: const InputDecoration(
                        labelText: 'Definition',
                      ),
                      onChanged: (v) => wVm.updateMeaning(
                        index,
                        meaning.copyWith(definition: v),
                      ),
                    ),
                    TextFormField(
                      initialValue: meaning.example,
                      decoration: const InputDecoration(labelText: 'Example'),
                      onChanged: (v) =>
                          wVm.updateMeaning(index, meaning.copyWith(tone: v)),
                    ),
                    TextFormField(
                      initialValue: meaning.pronunciation,
                      decoration: const InputDecoration(
                        labelText: 'Pronunciation',
                      ),
                      onChanged: (v) => wVm.updateMeaning(
                        index,
                        meaning.copyWith(pronunciation: v),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(
                      (meaning.variants ?? []).length,
                      (i) => VariantEditor(senseIndex: index, variantIndex: i),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Variant'),
                      onPressed: () {
                        wVm.addVariant(index);
                      },
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: const Text('Remove Sense'),
                      onPressed: () => wVm.removeMeaning(index),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VariantEditor extends ConsumerWidget {
  final int senseIndex;
  final int variantIndex;

  const VariantEditor({
    required this.senseIndex,
    required this.variantIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, wVm) {
        final variant = wVm.meanings[senseIndex].variants?[variantIndex];
        return Card(
          color: Colors.grey.shade100,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextFormField(
                  initialValue: variant?.form,
                  decoration: const InputDecoration(labelText: 'Form'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(senseIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.region,
                  decoration: const InputDecoration(labelText: 'Region'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(senseIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.tribe,
                  decoration: const InputDecoration(labelText: 'Tribe'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(senseIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.tone,
                  decoration: const InputDecoration(labelText: 'Tone'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(senseIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.pronunciation,
                  decoration: const InputDecoration(labelText: 'Pronunciation'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(senseIndex, variantIndex, newVariant);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
