import 'package:deps/packages/talker_flutter.dart';

class ExceptionLog extends TalkerLog {
  ExceptionLog(super.message);

  @override
  LogLevel? get logLevel => LogLevel.warning;

  @override
  String generateTextMessage() {
    return message;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(208);
}
