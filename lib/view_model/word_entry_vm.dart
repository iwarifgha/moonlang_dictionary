import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:moonlang_dictionary/model/base/base_response_model.dart';
import 'package:moonlang_dictionary/model/word_entry_model.dart';
import 'package:moonlang_dictionary/services/word_service.dart';
import 'package:moonlang_dictionary/view_model/base/base_view_model.dart';
import 'package:uuid/uuid.dart';

class WordEntryVm extends BaseViewModel {
  WordEntryVm() : super(BaseViewModelState()) {
    word = WordEntryModel.empty();
  }

  List<Meanings> get meanings => word.meanings ?? [];
  late WordEntryModel word;
  final _uuid = Uuid();
  bool isLoading = false;

  final WordEntryService _wordEntryService = WordEntryService();
  TextEditingController rootWordController = TextEditingController();

  void addBaseForm(String base) {
    final newWord = word.copyWith(baseForm: base);
    word = newWord;
    setState();
  }

  void addMeaning() {
    final meaning = Meanings.empty().copyWith(meaningId: _uuid.v4());
    meanings.add(meaning);
    setState();
  }

  void removeMeaning(Meanings val) {
    word.meanings?.removeWhere((meaning) => val.meaningId == meaning.meaningId);
    setState();
  }

  void updateMeaning(int index, Meanings newMeaning) {
    word.meanings?[index] = newMeaning;
    setState();
  }

  void resetData() {
    rootWordController.clear();
    word = WordEntryModel.empty();
  }

  addWord(BuildContext context) async {
    isLoading = true;
    setState();
    final newWord = word.copyWith(id: _uuid.v4());
    final result = await _wordEntryService.addWord(newWord);
    isLoading = false;
    if (result is Success<WordEntryModel>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message ?? 'Success'),
          backgroundColor: Colors.green,
        ),
      );
      resetData();
      setState();
    } else if (result is Failure<WordEntryModel>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.exception.toString()),
          backgroundColor: Colors.red,
        ),
      );
      setState();
    }
  }

  //-------
  void addVariant(int meaningIndex) {
    meanings[meaningIndex].variants?.add(Variants.empty());
    setState();
  }

  updateVariant(int senseIndex, int variantIndex, Variants newVariant) {
    word.meanings?[senseIndex].variants?[variantIndex] = newVariant;
    setState();
  }
}

final wordDraftProvider =
    StateNotifierProvider<WordEntryVm, BaseViewModelState>(
      (ref) => WordEntryVm(),
    );
