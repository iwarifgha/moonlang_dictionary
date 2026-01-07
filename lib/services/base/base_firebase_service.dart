import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonlang_dictionary/model/base/base_response_model.dart';

abstract class BaseFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// CRUD: CREATE / SET
  Future<ApiResponse<bool>> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collection).doc(docId).set(data, SetOptions(merge: true));
      return const Success(true);
    } catch (e) {
      return Failure("Firestore Write Error", exception: e);
    }
  }

  /// CRUD: READ (Single Document)
  Future<ApiResponse<Map<String, dynamic>>> getDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      final doc = await _db.collection(collection).doc(docId).get();
      if (doc.exists && doc.data() != null) {
        return Success(doc.data()!);
      }
      return const Failure("Document not found");
    } catch (e) {
      return Failure("Firestore Read Error", exception: e);
    }
  }

  /// CRUD: DELETE
  Future<ApiResponse<bool>> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      await _db.collection(collection).doc(docId).delete();
      return const Success(true);
    } catch (e) {
      return Failure("Delete Failed", exception: e);
    }
  }
}