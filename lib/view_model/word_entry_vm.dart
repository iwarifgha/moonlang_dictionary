import 'package:flutter_riverpod/legacy.dart';
import 'package:moonlang_dictionary/model/word_entry_model.dart';
import 'package:moonlang_dictionary/view_model/base/base_view_model.dart';

class WordEntryVm extends BaseViewModel {
  WordEntryVm() : super(BaseViewModelState());
  List<MeaningModel> meanings = [];

  addMeaning() {
    meanings.add(MeaningModel());
    setState();
  }

  addVariant(int index) {
    final meaning = meanings[index];
    meaning.variants?.add(Variants());
    setState();
  }

  updateMeaning(int index, MeaningModel newMeaning) {
    // final meaning = [...state.senses];
    meanings[index] = newMeaning;
    setState();
  }

updateVariant(int senseIndex,int variantIndex, Variants newVariant) {
    // final meaning = [...state.senses];
    meanings[senseIndex].variants?[variantIndex] = newVariant;
    setState();
  }
  void removeMeaning(int index) {
    meanings.removeAt(index);
    setState();
  }
}

final wordDraftProvider =
    StateNotifierProvider<WordEntryVm, BaseViewModelState>(
      (ref) => WordEntryVm(),
    );
