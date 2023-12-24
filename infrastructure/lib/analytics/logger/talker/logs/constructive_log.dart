import 'package:deps/packages/talker_flutter.dart';

class ConstructiveLog extends TalkerLog {
  ConstructiveLog(super.message);

  @override
  LogLevel? get logLevel => LogLevel.good;

  @override
  String generateTextMessage() {
    return message;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(40);
}
