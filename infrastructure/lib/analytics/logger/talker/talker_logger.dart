// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/talker_bloc_logger.dart' hide TalkerBlocObserver;
import 'package:deps/packages/talker_dio_logger.dart' hide TalkerDioLogger;
import 'package:deps/packages/talker_flutter.dart';

import '../../failure/i_failure.dart';
import '../../observers/talker/talker_bloc_observer.dart';
import '../../observers/talker/talker_dio_observer.dart';
import '../../observers/talker/talker_route_observer.dart';
import '../i_logger.dart';
import 'logs/debug_log.dart';
import 'logs/failure_log.dart';

/// Implementation of the [ILogger] interface using the Talker package.
///
/// This class provides mechanisms for logging different types of messages,
/// including general logs, constructive messages, destructive messages, and exceptions.
@LazySingleton(as: ILogger)
class TalkerLogger implements ILogger {
  /// Constructor for [Logger] that takes [Talker] as a dependency.
  TalkerLogger(this._talker);

  final Talker _talker;

  @override
  TalkerBlocObserver get blocTalker => TalkerBlocObserver(
        talker: _talker,
        settings: const TalkerBlocLoggerSettings(
          printChanges: true,
          printCreations: true,
          printClosings: true,
        ),
      );

  @override
  TalkerRouteObserver get routerTalker => TalkerRouteObserver(talker: _talker);

  @override
  TalkerDioLogger get dioTalker => TalkerDioLogger(
        talker: _talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      );

  /// Logs an exception with an optional stack trace.
  @override
  void exception(IFailure failure) {
    _talker.logTyped(FailureLog(failure));
  }

  @override
  void error(IFailure failure) {
    _talker.logTyped(FailureLog(failure));
  }

  /// Logs general data with an optional message.
  /// Formats the log output to include either the message or the data type and the data itself.
  @override
  void debug(
    dynamic data, [
    String? message,
  ]) {
    _talker.logTyped(DebugLog(data, message));
  }
}
