// ignore_for_file: avoid_unstable_final_fields

import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_flutter.dart';

class DebugLog extends TalkerLog {
  DebugLog(this.data, [this.msg]) : super('');
  final dynamic data;
  final String? msg;

  @override
  LogLevel? get logLevel => LogLevel.debug;

  @override
  String generateTextMessage() {
    return _createDebugLog();
  }

  String _createDebugLog() {
    final sb = StringBuffer();
    final formattedData = _formatData(data);

    sb.writeln('\n« DEBUG on ${_formatTime()} »');

    if (data != null) {
      sb.writeln('• TYPE\t  ─►  ${data.runtimeType}');
    }
    if (data != null) {
      sb.writeln('• DATA\t  ─►  $formattedData');
    }
    if (msg != null) {
      sb.writeln('• MESSAGE   ─►  $msg');
    }

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  String _formatData(dynamic data) {
    if (data is Iterable) {
      return data.join(', ');
    }

    return data.toString();
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(15);
}
