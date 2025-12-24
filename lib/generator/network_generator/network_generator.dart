import 'dart:io';

/// A generator class to create network-related exception handling classes.
class NetworkGenerator {
  /// The main directory path where the generated files will be saved.
  final String mainPath;

  /// Constructor for [NetworkGenerator].
  ///
  /// Requires [mainPath] to determine where to generate the files.
  NetworkGenerator({required this.mainPath});

  /// Generates all network-related files.
  ///
  /// Currently generates:
  /// - `error_handler.dart` for exception handling.
  /// - `app_exception.dart` for custom exception definitions.
  void generateNetwork() {
    _generateErrorHandler();
    _generateAppException();
    _generateFailure();
  }

  /// Generates `error_handler.dart`.
  ///
  /// This file contains functions to handle Dio exceptions and
  /// wrap any exceptions in [AppException].
  void _generateErrorHandler() {
    String filePath =
        "${mainPath.contains("example") ? "example/" : ""}lib/common/network/exception/error_handler.dart";
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("""
import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../common/network/failure.dart';
import 'package:dio/dio.dart';
import 'app_exception.dart';

/// Wraps a call and converts [AppException] into a [Left] value
/// while returning successful results as [Right].
Future<Either<Failure, U>> throwAppException<U>(FutureOr Function() call) async {
  try {
    return Right(await call());
  } on AppException catch (e) {
    return Left(e.failure);
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    throw AppException.unknown();
  }
}

/// Wraps a call and converts [DioException] into [AppException].
Future<T> throwDioException<T>(FutureOr<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    throw e.error ?? AppException.unknown();
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    throw AppException.unknown();
  }
}""");

    file.writeAsStringSync(buffer.toString());
  }

  /// Generates `app_exception.dart`.
  ///
  /// This file defines the [AppException] class used for
  /// network and general error handling.
  void _generateAppException() {
    String filePath =
        "${mainPath.contains("example") ? "example/" : ""}lib/common/network/exception/app_exception.dart";
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("""
import '../failure.dart';

/// Custom exception class used throughout the network layer.
class AppException implements Exception {
  /// Error message describing the exception.
  final Failure failure;

  /// The inner exception causing this [AppException].
  final Exception innerException;

  /// Creates an [AppException] with a message and inner exception.
  AppException(this.failure, this.innerException);

  /// Factory for an unknown exception with a default message.
  factory AppException.unknown() => AppException(
      Failure(message: 'try again', statusCode: '500'), Exception());

  /// Factory for a known exception with a custom message.
  factory AppException.known(message, statusCode) => AppException(
      Failure(message: message, statusCode: statusCode), Exception());

  @override
  String toString() => "failure : \$failure, innerException: \$innerException";
}
""");

    file.writeAsStringSync(buffer.toString());
  }

  void _generateFailure() {
    String filePath =
        "${mainPath.contains("example") ? "example/" : ""}lib/common/network/failure.dart";
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("""
class Failure {
  final String message;
  final String statusCode;

  Failure({required this.message, required this.statusCode});
}
""");

    file.writeAsStringSync(buffer.toString());
  }
}
