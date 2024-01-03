import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/material.dart';

class RouteLog extends TalkerLog {
  RouteLog({
    required this.route,
    this.isPush = true,
  }) : super('');

  final Route route;
  final bool isPush;

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer()
      ..writeln('\n« ROUTER on ${_formatTime()} »')
      ..writeln('• NAME\t  ─►  ${route.settings.name ?? 'null'}')
      ..writeln('• STATUS\t─►  ${isPush ? 'Pushed' : 'Popped'}');

    final args = route.settings.arguments;
    if (args != null) {
      sb.write('• ARGS\t  ─►  $args');
    }

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  @override
  AnsiPen get pen => AnsiPen()..xterm(153);
}
