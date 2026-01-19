import 'package:moonlang_dictionary/model/base/base_response_model.dart';
import 'package:moonlang_dictionary/model/word_entry_model.dart';
import 'package:moonlang_dictionary/services/base/base_firebase_service.dart';
import 'package:uuid/uuid.dart';

class WordEntryService extends BaseFirestoreService {
  
 
  Future<ApiResponse<WordEntryModel>> addWord(WordEntryModel word) async {
    final response = await setDocument(
      collection: 'words',
      docId: word.id!,
      data: word.toJson(),
    );
    return response.transform((json) => WordEntryModel.fromJson(json));
  }
}
