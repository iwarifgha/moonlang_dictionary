import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/view/add_word_view.dart';
import 'package:moonlang_dictionary/view/all_words_view.dart';
import 'package:moonlang_dictionary/view/new_add_word_view.dart';
import 'package:moonlang_dictionary/view/word_detail_view.dart';

Map<String, WidgetBuilder> routes = {
  AddWordScreen.routeName: (_) {
    return AddWordScreen();
  },
  AllWordsScreen.routeName: (_) {
    return AllWordsScreen();
  },
  WordDetailScreen.routeName: (_) {
    return WordDetailScreen();
  },
  NewAddWordScreen.routeName: (_) {
    return NewAddWordScreen();
  },
};
