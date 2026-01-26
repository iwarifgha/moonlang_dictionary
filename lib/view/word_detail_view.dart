import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/widgets/meaning_detail_card.dart';

class WordDetailScreen extends StatelessWidget {
  static final routeName = '/word_detail_view';
  const WordDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _WordHeader(),
          SizedBox(height: 16),
          MeaningCard(),
          MeaningCard(),
        ],
      ),
    );
  }
}

class _WordHeader extends StatelessWidget {
  const _WordHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ba',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '/báà/',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 6),
        Chip(
          label: const Text('High–Low Tone'),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        ),
      ],
    );
  }
}
