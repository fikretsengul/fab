// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/core/flavors/flavors.dart';
import 'package:deps/packages/injectable.dart';

import '../../analytics.dart';
import '../../logger.dart';
import '../enums.dart';
import '../failure/failure.dart';
import 'i_failure_observer.dart';

/// `FailureObserver` class implementing `IFailureObserver`.
/// Observes and handles failures, logging them and optionally
/// sending analytics data based on the environment and failure type.
@lazySingleton
class FailureObserver implements IFailureObserver {
  /// Constructs `FailureObserver` with environment, logger, and analytics dependencies.
  FailureObserver(this._env, this._logger, this._analytics);

  final Analytics _analytics;
  final IEnv _env;
  final Logger _logger;

  /// Handles a [Failure] by logging and sending analytics data if in debug mode.
  ///
  /// Logs different types of failures (constructive, destructive, exception) using
  /// the appropriate logging method. Sends analytics data if the environment is set
  /// to debug mode.
  ///
  /// [failure]: The [Failure] instance to handle.
  @override
  void onFailure(Failure failure) {
    final message = [
      '• TAG \t› ${failure.tag}',
      '• CODE\t› ${failure.code}',
      '• MESSAGE\t› ${failure.message}',
    ].join('\n');

    switch (failure.type) {
      case FailureType.constructive:
        _logger.constructive(message);
      case FailureType.destructive:
        _logger.destructive(message);
      case FailureType.exception:
        _logger.exception(
          message,
          exception: failure.exception,
          stackTrace: failure.stack,
        );
    }

    if (_env.isDebug) {
      _analytics.send(message);
    }
  }
}
