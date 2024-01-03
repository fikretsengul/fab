import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_flutter.dart';

import '../../../../_core/enums/failure_tag_enum.dart';
import '../../../failure/i_failure.dart';

class FailureLog extends TalkerLog {
  FailureLog(this.failure) : super('');

  final IFailure failure;

  @override
  LogLevel? get logLevel {
    if (failure.type == FailureType.exception) {
      return LogLevel.warning;
    } else {
      return LogLevel.critical;
    }
  }

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final type = failure.type == FailureType.exception ? 'EXCEPTION' : 'FAILURE';
    final sb = StringBuffer()
      ..writeln('\n« $type on ${_formatTime()} »')
      ..writeln('• TAG       ─►  ${failure.tag.name}')
      ..writeln('• CODE      ─►  ${failure.code}')
      ..writeln('• MESSAGE   ─►  ${failure.message}');

    if (failure.exception != null) {
      sb.writeln('• EXCEPTION ─►  ${failure.exception}');
    }

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  @override
  AnsiPen get pen => AnsiPen()..xterm(failure.type == FailureType.exception ? 208 : 196);
}
