import 'package:flutter/material.dart';

class MeaningCard extends StatelessWidget {
  const MeaningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _MeaningHeader(),
            SizedBox(height: 12),
            _DefinitionSection(),
            SizedBox(height: 12),
            _ExampleSection(),
          ],
        ),
      ),
    );
  }
}

class _MeaningHeader extends StatelessWidget {
  const _MeaningHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          label: const Text('Noun'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        const Spacer(),
        Text(
          'Meaning 1',
          style: TextStyle(color: Colors.grey.shade600),
        )
      ],
    );
  }
}

class _DefinitionSection extends StatelessWidget {
  const _DefinitionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Definition',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        const Text(
          'River; a natural flowing watercourse.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class _ExampleSection extends StatelessWidget {
  const _ExampleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Example',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 6),

        // Native sentence
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Mo ba le kɛ́.',
            style: TextStyle(fontSize: 16),
          ),
        ),

        const SizedBox(height: 6),

        // English translation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'I crossed the river.',
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
