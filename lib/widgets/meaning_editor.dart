import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view_model/word_entry_vm.dart';

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
                        initialValue: meaning.exampleNative,
                        decoration: const InputDecoration(labelText: 'Example'),
                        onChanged: (v) => wVm.updateMeaning(
                          index,
                          meaning.copyWith(exampleNative: v),
                        ),
                      ),
                      TextFormField(
                        initialValue: meaning.exampleEnglish,
                        decoration: const InputDecoration(
                          labelText: 'English Translation',
                        ),
                        onChanged: (v) => wVm.updateMeaning(
                          index,
                          meaning.copyWith(exampleEnglish: v),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // ...List.generate(
                      //   (meaning.variants ?? []).length,
                      //   (i) =>
                      //       VariantEditor(meaningIndex: index, variantIndex: i),
                      // ),
                      // TextButton.icon(
                      //   icon: const Icon(Icons.add),
                      //   label: const Text('Add Variant'),
                      //   onPressed: () {
                      //     wVm.addVariant(index);
                      // },
                      // ),
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