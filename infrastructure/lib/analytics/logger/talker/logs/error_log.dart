import 'package:deps/packages/talker_flutter.dart';

class ErrorLog extends TalkerLog {
  ErrorLog(super.message);

  @override
  LogLevel? get logLevel => LogLevel.critical;

  @override
  String generateTextMessage() {
    return message;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(196);
}
