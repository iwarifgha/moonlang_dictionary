import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:moonlang_dictionary/model/base/base_response_model.dart';
import 'package:moonlang_dictionary/model/new_word_model.dart';
import 'package:moonlang_dictionary/services/word_service.dart';
import 'package:moonlang_dictionary/view_model/base/base_view_model.dart';
import 'package:uuid/uuid.dart';

class WordEntryVm extends BaseViewModel {
  WordEntryVm() : super(BaseViewModelState()) {
    word = NewWordModel.empty();
  }

  List<Meanings> get meanings => word.meanings ?? [];
  List<String> get variants => word.variants ?? [];

  late NewWordModel word;
  final _uuid = Uuid();
  bool isLoading = false;
  List<NewWordModel> listOfWords = [];

  final WordEntryService _wordEntryService = WordEntryService();
  TextEditingController rootWordController = TextEditingController();
  TextEditingController pronunciationController = TextEditingController();
  TextEditingController toneController = TextEditingController();

  void addBaseForm(String text) {
    final newWord = word.copyWith(baseForm: text);
    word = newWord;
    setState();
  }

  void addPronunciation(String text) {
    final newWord = word.copyWith(pronunciation: text);
    word = newWord;
    setState();
  }

  void addTone(String text) {
    final newWord = word.copyWith(tone: text);
    word = newWord;
    setState();
  }

  void updateVariant({required String text, required int index}) {
    word.variants?[index] = text;
    setState();
  }

  void addVariant() {
    variants.add('');
    setState();
  }

  void removeVariant(int index) {
    word.variants?.removeAt(index);
    // word.meanings?.removeWhere((meaning) => val.meaningId == meaning.meaningId);
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
    pronunciationController.clear();
    toneController.clear();
    word.meanings?.clear();
    word.variants?.clear();
  }

  saveWord(BuildContext context) async {
    isLoading = true;
    setState();
    final newWord = word.copyWith(id: _uuid.v4());
    final result = await _wordEntryService.addWord(newWord);
    isLoading = false;
    if (result is Success<NewWordModel>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message ?? 'Success'),
          backgroundColor: Colors.green,
        ),
      );
      resetData();
      setState();
    } else if (result is Failure<NewWordModel>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.exception.toString()),
          backgroundColor: Colors.red,
        ),
      );
      setState();
    }
  }

  getWords(BuildContext context) async {
    setState(viewState: ViewState.busy);
    final result = await _wordEntryService.getWords();
    if (result is Success<List<NewWordModel>>) {
      listOfWords = result.data ?? [];
      setState(viewState: ViewState.done);
    } else if (result is Failure<List<NewWordModel>>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.exception.toString()),
          backgroundColor: Colors.red,
        ),
      );
      setState(viewState: ViewState.done);
    }
  }

  // //-------
  // void addVariant(int meaningIndex) {
  //   meanings[meaningIndex].variants?.add(Variants.empty());
  //   setState();
  // }

  // updateVariant(int senseIndex, int variantIndex, Variants newVariant) {
  //   word.meanings?[senseIndex].variants?[variantIndex] = newVariant;
  //   setState();
  // }
}

final wordDraftProvider =
    StateNotifierProvider<WordEntryVm, BaseViewModelState>(
      (ref) => WordEntryVm(),
    );
