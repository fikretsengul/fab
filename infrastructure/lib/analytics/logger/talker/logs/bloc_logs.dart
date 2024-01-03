// ignore_for_file: max_lines_for_file, avoid_dynamic_calls, require_trailing_commas

import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_bloc_logger.dart';
import 'package:deps/packages/talker_flutter.dart';

/// [Bloc] event log model
class BlocEventLog extends TalkerLog {
  BlocEventLog({
    required this.bloc,
    required this.event,
    required this.settings,
  }) : super('');

  final Bloc bloc;
  final Object? event;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer()
      ..writeln('\n« BLOC on ${_formatTime()} »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Received event: ${settings.printEventFullData ? event : event.runtimeType}');

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// [Bloc] state transition log model
class BlocStateLog extends TalkerLog {
  BlocStateLog({
    required this.bloc,
    required this.transition,
    required this.settings,
  }) : super('');

  final Bloc bloc;
  final Transition transition;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer()
      ..writeln('\n« BLOC on ${_formatTime()} »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Transiting with event ${transition.event.runtimeType}')
      ..writeln(
          '• FROM\t  ─►  ${settings.printStateFullData ? transition.currentState : transition.currentState.runtimeType}')
      ..writeln('• TO\t\t─►  ${settings.printStateFullData ? transition.nextState : transition.nextState.runtimeType}');

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// [Bloc] state changed log model
class BlocChangeLog extends TalkerLog {
  BlocChangeLog({
    required this.bloc,
    required this.change,
    required this.settings,
  }) : super('');

  final BlocBase bloc;
  final Change change;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer()
      ..writeln('\n« BLOC on ${_formatTime()} »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Changed')
      ..writeln('• FROM\t  ─►  ${settings.printStateFullData ? change.currentState : change.currentState.runtimeType}')
      ..writeln('• TO\t\t─►  ${settings.printStateFullData ? change.nextState : change.nextState.runtimeType}');

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// [Bloc] created log model
class BlocCreateLog extends TalkerLog {
  BlocCreateLog({required this.bloc}) : super('');

  final BlocBase bloc;

  @override
  AnsiPen get pen => AnsiPen()..xterm(8);

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer()
      ..writeln('\n« BLOC on ${_formatTime()} »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Created');

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// [Bloc] closed log model
class BlocCloseLog extends TalkerLog {
  BlocCloseLog({
    required this.bloc,
  }) : super('');

  final BlocBase bloc;

  @override
  AnsiPen get pen => AnsiPen()..xterm(13);

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer()
      ..writeln('\n« BLOC on ${_formatTime()} »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Closed');

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}
