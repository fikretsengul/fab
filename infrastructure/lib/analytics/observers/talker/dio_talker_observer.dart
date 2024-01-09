import 'package:deps/packages/dio.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:deps/packages/talker_flutter.dart';

import '../../logger/talker/logs/dio_logs.dart';

/// [Dio] http client logger on [Talker] base
///
/// [talker] filed is current [Talker] instance.
/// Provide your instance if your application used [Talker] as default logger
/// Common Talker instance will be used by default
final class DioTalkerObserver extends Interceptor {
  DioTalkerObserver({required this.talker, required this.settings});

  final Talker talker;
  TalkerDioLoggerSettings settings;

  /// Method to update [settings] of [TalkerDioLogger]
  void configure({
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
  }) {
    settings = settings.copyWith(
      printRequestData: printRequestData,
      printRequestHeaders: printRequestHeaders,
      printResponseData: printResponseData,
      printResponseHeaders: printResponseHeaders,
      printResponseMessage: printResponseMessage,
      requestPen: requestPen,
      responsePen: responsePen,
      errorPen: errorPen,
    );
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    final accepted = settings.requestFilter?.call(options) ?? true;
    if (!accepted) {
      return;
    }

    final message = '${options.uri}';
    final httpLog = DioRequestLog(
      message,
      requestOptions: options,
      settings: settings,
    );
    talker.logTyped(httpLog);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    final accepted = settings.responseFilter?.call(response) ?? true;
    if (!accepted) {
      return;
    }

    final message = '${response.requestOptions.uri}';
    final httpLog = DioResponseLog(
      message,
      settings: settings,
      response: response,
    );
    talker.logTyped(httpLog);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final message = '${err.requestOptions.uri}';
    final httpErrorLog = DioErrorLog(
      message,
      dioException: err,
      settings: settings,
    );
    talker.logTyped(httpErrorLog);
  }
}
