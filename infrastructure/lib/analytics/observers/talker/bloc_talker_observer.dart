import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/talker_bloc_logger.dart'
    hide BlocChangeLog, BlocCloseLog, BlocCreateLog, BlocEventLog, BlocStateLog;
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/foundation.dart';

import '../../logger/talker/logs/bloc_logs.dart';

/// [BLoC] logger on [Talker] base
///
/// [talker] filed is current [Talker] instance.
/// Provide your instance if your application used [Talker] as default logger
/// Common Talker instance will be used by default
@immutable
final class BlocTalkerObserver extends BlocObserver {
  BlocTalkerObserver({required this.talker, required this.settings});

  final Talker talker;
  final TalkerBlocLoggerSettings settings;

  @override
  @mustCallSuper
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!settings.enabled || !settings.printEvents) {
      return;
    }
    final accepted = settings.eventFilter?.call(bloc, event) ?? true;
    if (!accepted) {
      return;
    }
    talker.logTyped(
      BlocEventLog(
        bloc: bloc,
        event: event,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (!settings.enabled || !settings.printTransitions) {
      return;
    }
    final accepted = settings.transitionFilter?.call(bloc, transition) ?? true;
    if (!accepted) {
      return;
    }
    talker.logTyped(
      BlocStateLog(
        bloc: bloc,
        transition: transition,
        settings: settings,
      ),
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!settings.enabled || !settings.printChanges) {
      return;
    }
    talker.logTyped(
      BlocChangeLog(
        bloc: bloc,
        change: change,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    talker.error('${bloc.runtimeType}', error, stackTrace);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (!settings.enabled || !settings.printCreations) {
      return;
    }
    talker.logTyped(BlocCreateLog(bloc: bloc));
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (!settings.enabled || !settings.printClosings) {
      return;
    }
    talker.logTyped(BlocCloseLog(bloc: bloc));
  }
}
