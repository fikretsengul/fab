import 'dart:convert';

import 'package:flutter_advanced_boilerplate/utils/methods/aliases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Observer extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    logIt.info('onCreate -- ${bloc.runtimeType}');
  }

  void stateToSentry(
    BlocBase<dynamic> bloc, {
    Change<dynamic>? change,
    Object? error,
  }) {
    if (change != null) {
      var currentState = Breadcrumb(
        category: 'bloc',
        message: "onChange | (${bloc.runtimeType}'s current state)",
      );
      var nextState = Breadcrumb(
        category: 'bloc',
        message: "onChange | (${bloc.runtimeType}'s next state)",
      );

      try {
        final currData = jsonDecode(change.currentState.toString()) as Map<String, dynamic>;
        final nextData = jsonDecode(change.nextState.toString()) as Map<String, dynamic>;

        currentState = currentState.copyWith(data: currData);
        nextState = nextState.copyWith(data: nextData);
      } catch (e) {
        currentState = currentState.copyWith(
          message: '${currentState.message} - ${change.currentState}',
        );
        nextState = nextState.copyWith(
          message: '${nextState.message} - ${change.nextState}',
        );
      }

      Sentry.addBreadcrumb(currentState);
      Sentry.addBreadcrumb(nextState);
    } else {
      final errorState = Breadcrumb(
        category: 'bloc',
        message: "onError | (${bloc.runtimeType}'s state) - ${error.toString()}",
      );

      Sentry.addBreadcrumb(errorState);
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logIt
      ..info('onChange-current -- ${bloc.runtimeType}, ${change.currentState}')
      ..info('onChange-next -- ${bloc.runtimeType}, ${change.nextState}');
    stateToSentry(
      bloc,
      change: change,
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logIt.error('onError -- ${bloc.runtimeType}, $error');
    stateToSentry(
      bloc,
      error: error,
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    logIt.info('onClose -- ${bloc.runtimeType}');
  }
}
