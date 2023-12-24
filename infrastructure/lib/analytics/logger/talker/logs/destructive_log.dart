import 'package:deps/packages/talker_flutter.dart';

class DestructiveLog extends TalkerLog {
  DestructiveLog(super.message);

  @override
  LogLevel? get logLevel => LogLevel.warning;

  @override
  String generateTextMessage() {
    return message;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(228);
}
