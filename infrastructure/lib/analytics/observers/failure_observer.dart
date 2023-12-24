// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/injectable.dart';

import '../../flavors/i_env.dart';
import '../analytics/i_analytics.dart';
import '../failure/failure.dart';
import '../logger/i_logger.dart';
import '../others/enums.dart';
import 'i_failure_observer.dart';

/// `FailureObserver` class implementing `IFailureObserver`.
/// Observes and handles failures, logging them and optionally
/// sending analytics data based on the environment and failure type.
@LazySingleton(as: IFailureObserver)
class FailureObserver implements IFailureObserver {
  /// Constructs `FailureObserver` with environment, logger, and analytics dependencies.
  FailureObserver(this._env, this._logger, this._analytics);

  final IAnalytics _analytics;
  final IEnv _env;
  final ILogger _logger;

  /// Handles a [Failure] by logging and sending analytics data if in debug mode.
  ///
  /// Logs different types of failures (constructive, destructive, exception) using
  /// the appropriate logging method. Sends analytics data if the environment is set
  /// to debug mode.
  ///
  /// [failure]: The [Failure] instance to handle.
  @override
  void onFailure(Failure failure) {
    if (_env.isDebug) {
      _analytics.send(failure.message);
    }

    switch (failure.type) {
      case FailureType.constructive:
        _logger.constructive(failure);
      case FailureType.destructive:
        _logger.destructive(failure);
      case FailureType.exception:
        _logger.exception(failure);
      case FailureType.error:
        _logger.error(failure);
      default:
        return;
    }
  }
}
