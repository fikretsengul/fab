import 'package:data_channel/data_channel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

typedef RepositoryFunction<T> = Future<DC<AlertModel, T>> Function();

Future<DC<AlertModel, T>> dioExceptionHandler<T>(
  RepositoryFunction<T> repositoryFunction,
) async {
  try {
    return await repositoryFunction();
  } catch (e) {
    AlertModel alert;

    alert = e is UnauthenticatedException || e is ApiException || e is Exception
        ? AlertModel.exception(exception: e)
        : AlertModel.alert(message: e.toString(), type: AlertType.error);

    reportException(e);

    return DC.error(alert);
  }
}

void reportException(Object e) {
  Sentry.captureException(
    e,
  );
}

class BadNetworkException extends DioError implements Exception {
  BadNetworkException({required super.requestOptions});
}

class InternalServerException extends DioError implements Exception {
  InternalServerException({required super.requestOptions});
}

class UnauthenticatedException extends DioError implements Exception {
  UnauthenticatedException({required super.requestOptions});
}

class ApiException extends DioError implements Exception {
  ApiException({
    required this.errorMessage,
    required super.requestOptions,
    super.response,
    super.error,
    super.type,
  });

  final String errorMessage;
}

class InvalidJsonFormatException extends DioError implements Exception {
  InvalidJsonFormatException({required super.requestOptions});
}
