import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonlang_dictionary/model/base/base_response_model.dart';

abstract class BaseFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // /// CRUD: CREATE / SET
  // Future<ApiResponse<bool>> setDocument({
  //   required String collection,
  //   required String docId,
  //   required Map<String, dynamic> data,
  // }) async {
  //   try {
  //     await _db
  //         .collection(collection)
  //         .doc(docId)
  //         .set(data, SetOptions(merge: true));
  //     return const Success(true);
  //   } catch (e) {
  //     return Failure("Firestore Write Error", exception: e);
  //   }
  // }

  Future<ApiResponse<Map<String, dynamic>>> addDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = await _db.collection(collection).add(data);
      final doc = await docRef.get();
      return Success(doc.data());
    } catch (e) {
      return Failure( exception: e);
    }
  }

  /// CRUD: READ (Single Document)
  Future<ApiResponse<Map<String, dynamic>>> getSingleDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      final doc = await _db.collection(collection).doc(docId).get();
      if (doc.exists && doc.data() != null) {
        return Success(doc.data()!);
      }
      return const Failure(exception: "Document not found");
    } catch (e) {
      return Failure( exception: e);
    }
  }

Future<ApiResponse<List<Map<String, dynamic>>>> getDocuments({
    required String collection,
    
  }) async {
    try {
      final snapshot = await _db.collection(collection).get();
      final allData = snapshot.docs.map((doc) => doc.data()).toList();
      return Success(allData);
      // return const Failure(exception: "Document not found");
    } catch (e) {
      return Failure(exception: e);
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
      return Failure( exception: e);
    }
  }
}
