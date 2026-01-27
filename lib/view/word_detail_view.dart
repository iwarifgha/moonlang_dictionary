import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/model/new_word_model.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view_model/word_entry_vm.dart';
import 'package:moonlang_dictionary/widgets/meaning_detail_card.dart';

class WordDetailScreen extends StatelessWidget {
  static final routeName = '/word_detail_view';
  const WordDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, vm) {
        final word = ModalRoute.settingsOf(context)?.arguments as NewWordModel;
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _WordHeader(word),
              SizedBox(height: 16),
              ...(word.meanings ?? []).map((meanVal) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MeaningCard(meaning: meanVal),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _WordHeader extends StatelessWidget {
  final NewWordModel word;
  const _WordHeader(this.word);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          word.baseForm ?? '',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          word.pronunciation ?? '//',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 6),
        Chip(
          label: Text('${word.tone ?? 'No'} Tone'),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        ),
      ],
    );
  }
}
