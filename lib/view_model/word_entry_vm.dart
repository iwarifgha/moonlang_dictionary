import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:moonlang_dictionary/model/base/base_response_model.dart';
import 'package:moonlang_dictionary/model/word_entry_model.dart';
import 'package:moonlang_dictionary/services/word_service.dart';
import 'package:moonlang_dictionary/view_model/base/base_view_model.dart';

class WordEntryVm extends BaseViewModel {
  WordEntryVm() : super(BaseViewModelState()) {
    word = WordEntryModel.empty();
  }

  List<Meanings> get meanings => word.meanings ?? [];
  late WordEntryModel word;
  final WordEntryService _wordEntryService = WordEntryService();

  void addMeaning() {
    meanings.add(Meanings.empty());
    setState();
  }

  updateMeaning(int index, Meanings newMeaning) {
    word.meanings?[index] = newMeaning;
    setState();
  }

  void addVariant(int meaningIndex) {
    meanings[meaningIndex].variants?.add(Variants.empty());
    setState();
  }

  updateVariant(int senseIndex, int variantIndex, Variants newVariant) {
    word.meanings?[senseIndex].variants?[variantIndex] = newVariant;
    setState();
  }

  void removeMeaning(Meanings val) {
    word.meanings?.removeWhere((meaning) => val.id == meaning.id);
    // word.meanings?.removeAt(index);
    setState();
  }

  bool isLoading = false;
  addWord() {
    isLoading = true;
    setState(viewState: ViewState.busy);
    final result = _wordEntryService.addWord(word);

    if (result is Success) {
      ScaffoldMessenger(
        child: SnackBar(
          content: Text('Success'),
          backgroundColor: Colors.green,
        ),
      );
      isLoading = false;
      setState(viewState: ViewState.done);
    } else if (result is Failure) {
      //show error message
      ScaffoldMessenger(
        child: SnackBar(content: Text('Failure'), backgroundColor: Colors.red),
      );
      isLoading = false;
      setState(viewState: ViewState.error);
    } else {
      isLoading = false;
      setState();
      return;
    }
  }
}

final wordDraftProvider =
    StateNotifierProvider<WordEntryVm, BaseViewModelState>(
      (ref) => WordEntryVm(),
    );
