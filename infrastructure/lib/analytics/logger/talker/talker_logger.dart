// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_bloc_logger.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:deps/packages/talker_flutter.dart';

import '../../failure/i_failure.dart';
import '../i_logger.dart';
import 'logs/constructive_log.dart';
import 'logs/destructive_log.dart';
import 'logs/error_log.dart';
import 'logs/exception_log.dart';
import 'logs/log.dart';

/// Implementation of the [ILogger] interface using the Talker package.
///
/// This class provides mechanisms for logging different types of messages,
/// including general logs, constructive messages, destructive messages, and exceptions.
@LazySingleton(as: ILogger)
class TalkerLogger implements ILogger {
  /// Constructor for [Logger] that takes [Talker] as a dependency.
  TalkerLogger(this._talker);

  final Talker _talker;

  Talker get talker => _talker;
  TalkerBlocObserver get blocTalker => TalkerBlocObserver(talker: _talker);
  TalkerDioLogger get dioTalker => TalkerDioLogger(
        talker: _talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      );

  /// Logs a constructive message using the Talker package.
  @override
  void constructive(IFailure failure) {
    final log = [
      '\n',
      '« CONSTRUCTIVE ALERT on ${DateFormat('HH:mm:ss.SSS').format(DateTime.now())} »',
      '• TAG:\t\t  → ${failure.tag.name}',
      '• CODE:\t\t → ${failure.code}',
      '• MESSAGE:\t  → ${failure.message}',
    ].join('\n');

    _talker.logTyped(ConstructiveLog(log));
  }

  /// Logs a destructive message, typically used for warnings or errors.
  @override
  void destructive(IFailure failure) {
    final log = [
      '\n',
      '« DESTRUCTIVE ALERT on ${DateFormat('HH:mm:ss.SSS').format(DateTime.now())} »',
      '• TAG:\t\t  → ${failure.tag.name}',
      '• CODE:\t\t → ${failure.code}',
      '• MESSAGE:\t  → ${failure.message}',
    ].join('\n');

    _talker.logTyped(DestructiveLog(log));
  }

  /// Logs an exception with an optional stack trace.
  @override
  void exception(IFailure failure) {
    final message = [
      '\n',
      '« EXCEPTION FAILURE on ${DateFormat('HH:mm:ss.SSS').format(DateTime.now())} »',
      '• TAG:\t\t  → ${failure.tag.name}',
      '• CODE:\t\t → ${failure.code}',
      '• MESSAGE:\t  → ${failure.message}',
      '• EXCEPTION:\t→ ${failure.exception}',
    ].join('\n');

    _talker.logTyped(ExceptionLog(message));
  }

  @override
  void error(IFailure failure) {
    final log = [
      '\n',
      '« ERROR FAILURE on ${DateTime.now()} »',
      '• TAG:\t\t  → ${failure.tag.name}',
      '• CODE:\t\t → ${failure.code}',
      '• MESSAGE:\t  → ${failure.message}',
      '• EXCEPTION:\t→ ${failure.exception}',
    ].join('\n');

    _talker.logTyped(ErrorLog(log));
  }

  /// Logs general data with an optional message.
  /// Formats the log output to include either the message or the data type and the data itself.
  @override
  void log(
    dynamic data, [
    String? message,
  ]) {
    final hasMessage = message != null;
    final text = hasMessage ? 'MESSAGE:\t ' : 'TYPE:\t\t';
    final value = hasMessage ? message : data.runtimeType;

    final log = [
      '\n',
      '« LOGGING on ${DateFormat('HH:mm:ss.SSS').format(DateTime.now())} »',
      '• $text → $value',
      if (data != null) '• DATA:\t\t → $data' else '',
    ].join('\n');

    _talker.logTyped(Log(log));
  }
}
