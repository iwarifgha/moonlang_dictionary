import 'dart:async';
import 'dart:io';
 

abstract class Failure {}

class NullFailure implements Failure {
  const NullFailure._();

  factory NullFailure() => instance;
  static const instance = NullFailure._();
}

class ServerFailure implements Failure {
  final String error;
  ServerFailure({required this.error});
  String toString() {
    return error;
  }
}

class UnauthorisedFailure implements Failure {
  final String error;
  UnauthorisedFailure({required this.error});
  String toString() {
    return error;
  }
}

class ResponseFormatError implements Failure {
  final String error;
  ResponseFormatError({required this.error});
  String toString() {
    return error;
  }
}

class InputFailure implements Failure {
  final String errorMessage;
  InputFailure({required this.errorMessage});
  @override
  String toString() {
    return errorMessage;
  }
}

class NotFoundFailure implements Failure {
  final String errorMessage;
  NotFoundFailure({required this.errorMessage});
  @override
  String toString() {
    return errorMessage;
  }
}

class BadAuthFailure implements Failure {
  final String errorMessage;
  BadAuthFailure({required this.errorMessage});
  @override
  String toString() {
    return errorMessage;
  }
}

class NetworkFailure implements Failure {
  final String? message;

  NetworkFailure({required this.message});
  @override
  String toString() {
    return message!;
  }
}

class TimeoutFailure implements Failure {
  final String? message;

  TimeoutFailure({required this.message});
  @override
  String toString() {
    return message!;
  }
}

class UnknownFailure implements Failure {
  final String message;
  UnknownFailure({required this.message});
  @override
  String toString() {
    return message;
  }
}

 