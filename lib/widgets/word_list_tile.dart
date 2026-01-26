import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/model/word_entry_model.dart';

class WordListTile extends StatelessWidget {
  final WordEntryModel word;
  final VoidCallback onTap;
  const WordListTile({super.key, required this.word, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WordAvatar(),
              const SizedBox(width: 16),
              Expanded(
                child: _WordContent(
                  wordRoot: word.baseForm ?? '',
                  meanings: word.meanings ?? [],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _WordAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: const Text('B', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class _WordContent extends StatelessWidget {
  final String wordRoot;
  // final List<String> partOfSpeech;
  final List<Meanings> meanings;

  const _WordContent({
    required this.wordRoot,
    // required this.partOfSpeech,
    required this.meanings,
  });
  @override
  Widget build(BuildContext context) {
    final String? firstMeaning;

    if (meanings.isEmpty) {
      firstMeaning = 'No meaning';
    } else {
      firstMeaning = meanings.first.definition ?? '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          wordRoot,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: meanings
              .map((val) => _PosChip(label: val.partOfSpeech ?? ''))
              .toList(),
          //  [
          //   _PosChip(label: 'noun'),
          //   _PosChip(label: 'verb'),
          // ],
        ),
        const SizedBox(height: 8),
        Text(
          firstMeaning,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class _PosChip extends StatelessWidget {
  final String label;
  const _PosChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label), visualDensity: VisualDensity.compact);
  }
}
