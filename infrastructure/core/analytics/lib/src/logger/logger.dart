import 'package:deps/packages/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'i_logger.dart';

@lazySingleton
class Logger implements ILogger {
  Logger(this._talker);

  final Talker _talker;

  @override
  void constructive(String message) {
    _talker.good(message);
  }

  @override
  void destructive(String message) {
    _talker.warning(message);
  }

  @override
  void exception(
    String message, {
    Exception? exception,
    StackTrace? stackTrace,
  }) {
    _talker.critical(
      message,
      exception,
      stackTrace,
    );
  }

  @override
  void log(
    String message, {
    dynamic data,
  }) {
    _talker.debug(
      "\n• MESSAGE\t› $message${data != null ? '\n• DATA\t› $data' : ''}",
    );
  }
}
