import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:moonlang_dictionary/model/base/base_response_model.dart';

abstract class BaseHttpService {
  final String baseUrl;

  BaseHttpService(this.baseUrl);

  /// Generic helper to process all HTTP calls in our ApiResponse
  Future<ApiResponse<Map<String, dynamic>>> sendRequest<T>({
    required http.Response response,
  }) async {
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedData = jsonDecode(response.body);
        return Success(decodedData);
      } else {
        return Failure(
          "Server Error: ${response.statusCode}",
          exception: response.body,
        );
      }
    } catch (e) {
      return Failure("Network Connection Error", exception: e);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return sendRequest(response: response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // MULTIPART REQUEST
  Future<ApiResponse<Map<String, dynamic>>> postMultipart<T>({
    required String endpoint,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    required T Function(dynamic) mapper,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$endpoint'),
      );
      request.fields.addAll(fields);
      request.files.addAll(files);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return sendRequest(response: response);
    } catch (e) {
      return Failure("Multipart Upload Failed", exception: e);
    }
  }

  /// Common error wrapper
  ApiResponse<Map<String, dynamic>> _handleError(Object e) {
    if (e is SocketException) {
      return Failure('Error');
      // return ApiResponse.failure(NetworkFailure(message: 'No internet connection'));
    } else {
      return Failure('errorMessage');
      // return ApiResponse.failure(ResponseFormatError(error: e.toString()));
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _jsonHeaders(headers),
        body: jsonEncode(body),
      );
      return sendRequest(response: response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> patch(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: _jsonHeaders(headers),
        body: jsonEncode(body),
      );
      return sendRequest(response: response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> put(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _jsonHeaders(headers),
        body: jsonEncode(body),
      );
      return sendRequest(response: response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> multipart(
    String endpoint, {
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('POST', uri)
        ..fields.addAll(fields)
        ..files.addAll(files);

      if (headers != null) {
        request.headers.addAll(headers);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return sendRequest(response: response);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Helper to set Content-Type for JSON requests.
  Map<String, String> _jsonHeaders(Map<String, String>? headers) {
    return {'Content-Type': 'application/json', ...?headers};
  }
}
