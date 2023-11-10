import 'package:commons/enums.dart';
import 'package:commons/envs.dart';
import 'package:commons/errors.dart';
import 'package:deps/injectable.dart';

import '../../analytics.dart';
import '../../logger.dart';
import 'i_failure_observer.dart';

@lazySingleton
class FailureObserver implements IFailureObserver {
  FailureObserver(this._env, this._logger, this._analytics);

  final Analytics _analytics;
  final IEnv _env;
  final Logger _logger;

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
