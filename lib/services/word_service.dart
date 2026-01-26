import 'package:moonlang_dictionary/model/base/base_response_model.dart';
import 'package:moonlang_dictionary/model/word_entry_model.dart';
import 'package:moonlang_dictionary/services/base/base_firebase_service.dart';

class WordEntryService extends BaseFirestoreService {
  Future<ApiResponse<WordEntryModel>> addWord(WordEntryModel word) async {
    final response = await addDocument(
      collection: 'words',
      data: word.toJson(),
    );
    return response.transform((json) => WordEntryModel.fromJson(json));
  }

  Future<ApiResponse<List<WordEntryModel>>> getWords() async {
    final response = await getDocuments(collection: 'words');
    return response.transform(
      (list) => list.map((e) => WordEntryModel.fromJson(e)).toList(),
    );
  }
}
