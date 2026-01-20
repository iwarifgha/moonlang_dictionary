import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view_model/word_entry_vm.dart';
import 'package:moonlang_dictionary/widgets/meaning_editor.dart';

class AddWordScreen extends ConsumerWidget {
  static final routeName = '/add_word_screen';
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
                  wordVm.addWord(context);
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: wordVm.rootWordController,
                decoration: const InputDecoration(
                  labelText: 'Root word',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  wordVm.addBaseForm(val);
                },
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
