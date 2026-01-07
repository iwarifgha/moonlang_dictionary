import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';


final wordDraftProvider =
    StateNotifierProvider<WordDraftNotifier, WordDraft>(
  (ref) => WordDraftNotifier(),
);

class WordDraftNotifier extends StateNotifier<WordDraft> {
  WordDraftNotifier() : super(WordDraft.empty());

  void setLemma(String value) {
    state = state.copyWith(lemma: value);
  }

  void addSense() {
    state = state.copyWith(
      senses: [...state.senses, SenseDraft.empty()],
    );
  }

  void updateSense(int index, SenseDraft sense) {
    final senses = [...state.senses];
    senses[index] = sense;
    state = state.copyWith(senses: senses);
  }

  void removeSense(int index) {
    final senses = [...state.senses]..removeAt(index);
    state = state.copyWith(senses: senses);
  }
}


final _uuid = Uuid();

class WordDraft {
  final String id;
  final String lemma;
  final List<SenseDraft> senses;

  WordDraft({
    required this.id,
    required this.lemma,
    required this.senses,
  });

  factory WordDraft.empty() => WordDraft(
        id: _uuid.v4(),
        lemma: '',
        senses: [],
      );

  WordDraft copyWith({
    String? lemma,
    List<SenseDraft>? senses,
  }) {
    return WordDraft(
      id: id,
      lemma: lemma ?? this.lemma,
      senses: senses ?? this.senses,
    );
  }
}

class SenseDraft {
  final String pos;
  final String definition;
  final String tone;
  final String pronunciation;
  final List<VariantDraft> variants;

  SenseDraft({
    required this.pos,
    required this.definition,
    required this.tone,
    required this.pronunciation,
    required this.variants,
  });

  factory SenseDraft.empty() => SenseDraft(
        pos: '',
        definition: '',
        tone: '',
        pronunciation: '',
        variants: [],
      );

  SenseDraft copyWith({
    String? pos,
    String? definition,
    String? tone,
    String? pronunciation,
    List<VariantDraft>? variants,
  }) {
    return SenseDraft(
      pos: pos ?? this.pos,
      definition: definition ?? this.definition,
      tone: tone ?? this.tone,
      pronunciation: pronunciation ?? this.pronunciation,
      variants: variants ?? this.variants,
    );
  }
}

class VariantDraft {
  final String form;
  final String region;
  final String tribe;
  final String tone;
  final String pronunciation;

  VariantDraft({
    required this.form,
    required this.region,
    required this.tribe,
    required this.tone,
    required this.pronunciation,
  });

  factory VariantDraft.empty() => VariantDraft(
        form: '',
        region: '',
        tribe: '',
        tone: '',
        pronunciation: '',
      );

  VariantDraft copyWith({
    String? form,
    String? region,
    String? tribe,
    String? tone,
    String? pronunciation,
  }) {
    return VariantDraft(
      form: form ?? this.form,
      region: region ?? this.region,
      tribe: tribe ?? this.tribe,
      tone: tone ?? this.tone,
      pronunciation: pronunciation ?? this.pronunciation,
    );
  }
}


class AddWordScreen extends ConsumerWidget {
  const AddWordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordDraftProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Word'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_isValid(word)) {
                debugPrint(wordToJson(word));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Incomplete word entry')),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Lemma',
              border: OutlineInputBorder(),
            ),
            onChanged: ref.read(wordDraftProvider.notifier).setLemma,
          ),
          const SizedBox(height: 24),
          ...List.generate(
            word.senses.length,
            (i) => SenseEditor(index: i),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Sense'),
            onPressed: ref.read(wordDraftProvider.notifier).addSense,
          ),
        ],
      ),
    );
  }
}
class SenseEditor extends ConsumerWidget {
  final int index;
  const SenseEditor({required this.index, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(wordDraftProvider.notifier);
    final sense = ref.watch(wordDraftProvider).senses[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          sense.definition.isEmpty
              ? 'Sense ${index + 1}'
              : '${sense.pos} — ${sense.definition}',
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: sense.pos.isEmpty ? null : sense.pos,
                  decoration: const InputDecoration(labelText: 'Part of Speech'),
                  items: const [
                    DropdownMenuItem(value: 'noun', child: Text('Noun')),
                    DropdownMenuItem(value: 'verb', child: Text('Verb')),
                    DropdownMenuItem(value: 'adj', child: Text('Adjective')),
                  ],
                  onChanged: (v) =>
                      notifier.updateSense(index, sense.copyWith(pos: v)),
                ),
                TextFormField(
                  initialValue: sense.definition,
                  decoration:
                      const InputDecoration(labelText: 'Definition'),
                  onChanged: (v) => notifier.updateSense(
                    index,
                    sense.copyWith(definition: v),
                  ),
                ),
                TextFormField(
                  initialValue: sense.tone,
                  decoration: const InputDecoration(labelText: 'Tone'),
                  onChanged: (v) =>
                      notifier.updateSense(index, sense.copyWith(tone: v)),
                ),
                TextFormField(
                  initialValue: sense.pronunciation,
                  decoration:
                      const InputDecoration(labelText: 'Pronunciation'),
                  onChanged: (v) => notifier.updateSense(
                    index,
                    sense.copyWith(pronunciation: v),
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  sense.variants.length,
                  (i) => VariantEditor(
                    senseIndex: index,
                    variantIndex: i,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Variant'),
                  onPressed: () {
                    notifier.updateSense(
                      index,
                      sense.copyWith(
                        variants: [...sense.variants, VariantDraft.empty()],
                      ),
                    );
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Remove Sense'),
                  onPressed: () => notifier.removeSense(index),
                ),
              ],
            ),
          ),
        ],
      ),
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
    final notifier = ref.read(wordDraftProvider.notifier);
    final sense = ref.watch(wordDraftProvider).senses[senseIndex];
    final variant = sense.variants[variantIndex];

    return Card(
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              initialValue: variant.form,
              decoration: const InputDecoration(labelText: 'Form'),
              onChanged: (v) {
                _updateVariant(ref, sense, variant.copyWith(form: v));
              },
            ),
            TextFormField(
              initialValue: variant.region,
              decoration: const InputDecoration(labelText: 'Region'),
              onChanged: (v) =>
                  _updateVariant(ref, sense, variant.copyWith(region: v)),
            ),
            TextFormField(
              initialValue: variant.tribe,
              decoration: const InputDecoration(labelText: 'Tribe'),
              onChanged: (v) =>
                  _updateVariant(ref, sense, variant.copyWith(tribe: v)),
            ),
            TextFormField(
              initialValue: variant.tone,
              decoration: const InputDecoration(labelText: 'Tone'),
              onChanged: (v) =>
                  _updateVariant(ref, sense, variant.copyWith(tone: v)),
            ),
            TextFormField(
              initialValue: variant.pronunciation,
              decoration:
                  const InputDecoration(labelText: 'Pronunciation'),
              onChanged: (v) => _updateVariant(
                ref,
                sense,
                variant.copyWith(pronunciation: v),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateVariant(
    WidgetRef ref,
    SenseDraft sense,
    VariantDraft updated,
  ) {
    final notifier = ref.read(wordDraftProvider.notifier);
    final variants = [...sense.variants];
    variants[variantIndex] = updated;
    notifier.updateSense(
      senseIndex,
      sense.copyWith(variants: variants),
    );
  }
}
bool _isValid(WordDraft word) {
  if (word.lemma.isEmpty) return false;
  if (word.senses.isEmpty) return false;
  for (final s in word.senses) {
    if (s.pos.isEmpty || s.definition.isEmpty) return false;
  }
  return true;
}

String wordToJson(WordDraft word) {
  return {
    'id': word.id,
    'lemma': word.lemma,
    'senses': word.senses.map((s) {
      return {
        'pos': s.pos,
        'definition': s.definition,
        'tone': s.tone,
        'pronunciation': s.pronunciation,
        'variants': s.variants.map((v) {
          return {
            'form': v.form,
            'region': v.region,
            'tribe': v.tribe,
            'tone': v.tone,
            'pronunciation': v.pronunciation,
          };
        }).toList(),
      };
    }).toList(),
  }.toString();
}
