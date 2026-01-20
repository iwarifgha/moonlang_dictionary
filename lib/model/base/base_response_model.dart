/// A generic class that holds a value with its loading status.
sealed class ApiResponse<T> {
  final T? data;
  const ApiResponse(this.data);
}

/// The state when the data is successfully fetched.
class Success<T> extends ApiResponse<T> {
  final String? message;

  const Success(super.data, {this.message});
}

/// The state when an error occurs (Network error, Firestore permission, etc.)
class Failure<T> extends ApiResponse<T> {
   
  final dynamic exception;

  const Failure( {this.exception}) : super(null);
}

// /// The state while waiting for the response.
// class Loading<T> extends ApiResponse<T> {
//   const Loading();
// }

// extension ApiResponseMapTransformer on ApiResponse {
//   ApiResponse<E> transform<E>(
//     E Function(Map<String, dynamic> data) transformer,
//   ) {
//     try {
//       final result = transformer(data);
//       return Success(result);
//     } catch (e) {
//       return Failure('Error converting type');
//     }
//   }
// }

extension ApiResponseTransformer<T> on ApiResponse<T> {
  ApiResponse<E> transform<E>(E Function(T data) mapper) {
    // 1️⃣ Preserve failure
    if (this is Failure<T>) {
      final failure = this as Failure<T>;
      return Failure<E>(
        // failure.errorMessage,
        exception: failure.exception,
      );
    }

    // 2️⃣ Guard against null data
    if (data == null) {
      return Failure<E>(exception: 'No data to transform');
    }

    // 3️⃣ Transform success
    try {
      return Success<E>(mapper(data as T));
    } catch (e) {
      return Failure<E>(  exception: e);
    }
  }
}
