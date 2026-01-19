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
                icon: wordVm.isLoading
                    ? CircularProgressIndicator()
                    : Icon(Icons.check),
                onPressed: () {
                  wordVm.addWord();
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
                (i) => MeaningEditor(index: i, () {}),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Meaning'),
                onPressed: () {
                  wordVm.addMeaning();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MeaningEditor extends ConsumerWidget {
  final int index;
  final VoidCallback onTap;
  const MeaningEditor(this.onTap, {required this.index, super.key});

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
          child: GestureDetector(
            onTap: onTap,
            child: ExpansionTile(
              title: Text(
                (meaning.definition ?? '').isEmpty
                    ? 'Meaning ${index + 1}'
                    : '${meaning.partOfSpeech} — ${meaning.definition}',
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: (meaning.partOfSpeech ?? '').isEmpty
                            ? null
                            : meaning.partOfSpeech,
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
                        onChanged: (v) => wVm.updateMeaning(
                          index,
                          meaning.copyWith(partOfSpeech: v),
                        ),
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
                        initialValue: meaning.tone,
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
                        (i) =>
                            VariantEditor(meaningIndex: index, variantIndex: i),
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
                        label: const Text('Remove Meaning'),
                        onPressed: () => wVm.removeMeaning(wVm.meanings[index]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VariantEditor extends ConsumerWidget {
  final int meaningIndex;
  final int variantIndex;

  const VariantEditor({
    required this.meaningIndex,
    required this.variantIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, wVm) {
        final variant = wVm.meanings[meaningIndex].variants?[variantIndex];
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
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.region,
                  decoration: const InputDecoration(labelText: 'Region'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.region,
                  decoration: const InputDecoration(labelText: 'Tribe'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.tone,
                  decoration: const InputDecoration(labelText: 'Tone'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.pronunciation,
                  decoration: const InputDecoration(labelText: 'Pronunciation'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
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
