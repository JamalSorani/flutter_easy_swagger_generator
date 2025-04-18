import 'dart:io';

class NetworkGenerator {
  generateNetwork() {
    _generateErrorHandler();
    _generateAppException();
  }

  _generateErrorHandler() {
    String filePath = "lib/common/network/exception/error_handler.dart";
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();
    buffer.writeln("""
import 'dart:async';
import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:dio/dio.dart';
import 'app_exception.dart';

Future<Either<String, U>> throwAppException<U>(FutureOr Function() call) async {
  try {
    return Right(await call());
  } on AppException catch (e) {
    return Left(e.message);
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    throw AppException.unknown();
  }
}

Future<T> throwDioException<T>(FutureOr<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    throw e.error ?? AppException.unknown();
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    throw AppException.unknown();
  }
}

""");
    file.writeAsStringSync(buffer.toString());
  }

  _generateAppException() {
    String filePath = "lib/common/network/exception/app_exception.dart";
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();
    buffer.writeln("""
class AppException implements Exception {
  final String message;

  final Exception innerException;

  AppException(this.message, this.innerException);

  factory AppException.unknown() => AppException('try again', Exception());

  factory AppException.known(message) => AppException(message, Exception());

  @override
  String toString() => "message : \$message, innerException: \$innerException";
}

""");
    file.writeAsStringSync(buffer.toString());
  }
}
