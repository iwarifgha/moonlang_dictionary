import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view_model/word_entry_vm.dart';
import 'package:moonlang_dictionary/widgets/meaning_editor.dart';

class NewAddWordScreen extends StatelessWidget {
  static final routeName = '/new_add_word_screen';

  const NewAddWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, vm) {
        return Scaffold(
          appBar: AppBar(title: const Text('Add New Word')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Word Details'),

                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Base Form',
                    hintText: 'Enter the main form of the word',
                    border: OutlineInputBorder(),
                  ),
                  controller: vm.rootWordController,
                  onChanged: (val) {
                    vm.addBaseForm(val);
                  },
                ),

                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pronunciation',
                    hintText: 'e.g. /báà/',
                    border: OutlineInputBorder(),
                  ),
                  controller: vm.pronunciationController,
                  onChanged: (val) {
                    vm.addPronunciation(val);
                  },
                ),

                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tone',
                    hintText: 'e.g. high-low',
                    border: OutlineInputBorder(),
                  ),
                  controller: vm.toneController,
                  onChanged: (val) {
                    vm.addTone(val);
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SectionTitle('Variants'),
                    TextButton.icon(
                      onPressed: () {
                        vm.addVariant();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add Variant"),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vm.variants.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Variant ${index + 1}',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              vm.removeVariant(index);
                            },
                          ),
                        ),
                        onChanged: (val) {
                          vm.updateVariant(text: val, index: index);
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SectionTitle('Meanings'),
                    TextButton.icon(
                      onPressed: () {
                        vm.addMeaning();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add Meaning"),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vm.meanings.length,
                  itemBuilder: (context, index) {
                    return MeaningEditor(() {}, index: index);
                  },
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      vm.saveWord(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Save Word'),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
