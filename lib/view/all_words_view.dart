import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/view/add_word_view.dart';
import 'package:moonlang_dictionary/widgets/search_bar_widget.dart';
import 'package:moonlang_dictionary/widgets/word_list_tile.dart';

class AllWordsScreen extends StatelessWidget {
  static final routeName = '/word_list_screen';

  const AllWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 10, // placeholder
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return const WordListTile();
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
  }
}
