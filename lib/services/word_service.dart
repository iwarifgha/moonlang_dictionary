import 'package:moonlang_dictionary/model/base/base_response_model.dart';
import 'package:moonlang_dictionary/model/new_word_model.dart';
import 'package:moonlang_dictionary/services/base/base_firebase_service.dart';

class WordEntryService extends BaseFirestoreService {
  Future<ApiResponse<NewWordModel>> addWord(NewWordModel word) async {
    final response = await addDocument(
      collection: 'words',
      data: word.toJson(),
    );
    return response.transform((json) => NewWordModel.fromJson(json));
  }

  Future<ApiResponse<List<NewWordModel>>> getWords() async {
    final response = await getDocuments(collection: 'words');
    return response.transform(
      (list) => list.map((e) => NewWordModel.fromJson(e)).toList(),
    );
  }
}
