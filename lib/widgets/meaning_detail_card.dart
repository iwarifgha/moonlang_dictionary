import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/model/new_word_model.dart';

class MeaningCard extends StatelessWidget {
  final Meanings meaning;
  const MeaningCard({super.key, required this.meaning});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text('${meaning.partOfSpeech}'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Definition',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(' ${meaning.definition}', style: TextStyle(fontSize: 16)),
              ],
            ),
            // _DefinitionSection(),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Example', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 6),
                // Native sentence
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${meaning.exampleNative}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 6),

                // English translation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '${meaning.exampleEnglish}',
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            // _ExampleSection(),
          ],
        ),
      ),
    );
  }
}
