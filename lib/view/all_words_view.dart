import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlang_dictionary/view/add_word_view.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view/word_detail_view.dart';
import 'package:moonlang_dictionary/view_model/word_entry_vm.dart';
import 'package:moonlang_dictionary/widgets/no_words_displayer.dart';
import 'package:moonlang_dictionary/widgets/loading_words_skeleton.dart';
import 'package:moonlang_dictionary/widgets/search_bar_widget.dart';
import 'package:moonlang_dictionary/widgets/word_list_tile.dart';

class AllWordsScreen extends ConsumerStatefulWidget {
  static final routeName = '/word_list_screen';

  const AllWordsScreen({super.key});

  @override
  ConsumerState<AllWordsScreen> createState() => _AllWordsScreenState();
}

class _AllWordsScreenState extends ConsumerState<AllWordsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wordDraftProvider.notifier).getWords(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, wVm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dictionary'),
            actions: [
              IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
            ],
          ),
          body: Column(
            children: [
              SearchBarWidget(),
              if (state.isBusy)
                Expanded(child: const LoadingWordsSkeleton())
              else
                wVm.listOfWords.isEmpty
                    ? const NoWordsDisplayer()
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: wVm.listOfWords.length, // placeholder
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return WordListTile(
                              word: wVm.listOfWords[index],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  WordDetailScreen.routeName,
                                );
                              },
                            );
                          },
                        ),
                      ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddWordScreen.routeName);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
