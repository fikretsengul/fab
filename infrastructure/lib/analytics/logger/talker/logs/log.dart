import 'package:deps/packages/talker_flutter.dart';

class Log extends TalkerLog {
  Log(super.message);

  @override
  LogLevel? get logLevel => LogLevel.debug;

  @override
  String generateTextMessage() {
    return message;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(15);
}
