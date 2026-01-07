/// A generic class that holds a value with its loading status.
sealed class ApiResponse<T> {
  const ApiResponse();
}

/// The state when the data is successfully fetched.
class Success<T> extends ApiResponse<T> {
  final T data;
  final String? message;

  const Success(this.data, {this.message});
}

/// The state when an error occurs (Network error, Firestore permission, etc.)
class Failure<T> extends ApiResponse<T> {
  final String errorMessage;
  final dynamic exception;

  const Failure(this.errorMessage, {this.exception});
}

// /// The state while waiting for the response.
// class Loading<T> extends ApiResponse<T> {
//   const Loading();
// }

extension ApiResponseMapTransformer on Success<Map<String, dynamic>> {
  ApiResponse<E> transform<E>(
    E Function(Map<String, dynamic> data) transformer, {
    bool ignoreHasError = false,
  }) {
    try {
      final result = transformer(data);
      return  Success(result);
     } catch (e) {
      return  Failure('Error converting type');
    }
  }
}