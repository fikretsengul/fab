// ignore_for_file: max_lines_for_file
import 'dart:convert';

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:deps/packages/talker_flutter.dart';

const encoder = JsonEncoder.withIndent('  ');

class DioRequestLog extends TalkerLog {
  DioRequestLog(
    this.uri, {
    required this.requestOptions,
    required this.settings,
  }) : super('');

  final String uri;
  final RequestOptions requestOptions;
  final TalkerDioLoggerSettings settings;

  @override
  // ignore: avoid_unstable_final_fields
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final data = requestOptions.data;
    final headers = requestOptions.headers;

    final sb = StringBuffer()
      ..writeln('\n« DIO on ${_formatTime()} »')
      ..writeln('• TYPE\t  ─►  ${requestOptions.method} Request')
      ..writeln('• URL\t   ─►  $uri');

    if (settings.printRequestHeaders && headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyHeaders);
      final formattedEntries = parsedJson.entries.map((entry) => '"${entry.key}": "${entry.value}"').join(',\n');
      sb.writeln('• HEADERS   ─►  $formattedEntries');
    }

    if (settings.printRequestData && data != null) {
      final prettyData = encoder.convert(data);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyData);
      final formattedEntries = parsedJson.entries.map((entry) => '"${entry.key}": "${entry.value}"').join(',\n');
      sb.writeln('• DATA\t  ─►  $formattedEntries');
    }

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

class DioResponseLog extends TalkerLog {
  DioResponseLog(
    this.uri, {
    required this.response,
    required this.settings,
  }) : super('');

  final String uri;
  final Response<dynamic> response;
  final TalkerDioLoggerSettings settings;

  @override
  // ignore: avoid_unstable_final_fields
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final responseMessage = response.statusMessage;
    final data = response.data;
    final headers = response.headers.map;

    final sb = StringBuffer()
      ..writeln('\n« DIO on ${_formatTime()} »')
      ..writeln('• TYPE\t  ─►  ${response.requestOptions.method} Response')
      ..writeln('• URL\t   ─►  $uri')
      ..writeln('• STATUS\t─►  ${response.statusCode}');

    if (settings.printResponseMessage && responseMessage != null) {
      sb.writeln('• MESSAGE   ─►  $responseMessage');
    }

    if (settings.printResponseHeaders && headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyHeaders);
      final formattedEntries = parsedJson.entries.map((entry) => '"${entry.key}": "${entry.value}"').join(',\n');
      sb.writeln('• HEADERS   ─►  $formattedEntries');
    }

    if (settings.printResponseData && data != null) {
      final prettyData = encoder.convert(data);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyData);
      final formattedEntries = parsedJson.entries.map((entry) => '"${entry.key}": "${entry.value}"').join(',\n');
      sb.writeln('• DATA\t  ─►  $formattedEntries');
    }

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

class DioErrorLog extends TalkerLog {
  DioErrorLog(
    this.uri, {
    required this.dioException,
    required this.settings,
  }) : super('');

  final String uri;
  final DioException dioException;
  final TalkerDioLoggerSettings settings;

  @override
  // ignore: avoid_unstable_final_fields
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final responseMessage = dioException.message;
    final statusCode = dioException.response?.statusCode;
    final data = dioException.response?.data;
    final headers = dioException.requestOptions.headers;

    final sb = StringBuffer()
      ..writeln('\n« DIO on ${_formatTime()} »')
      ..writeln('• TYPE\t  ─►  ${dioException.requestOptions.method} Error')
      ..writeln('• URL\t   ─►  $uri');

    if (statusCode != null) {
      sb.writeln('• STATUS\t─►  ${dioException.response?.statusCode}');
    }

    sb.writeln('• MESSAGE   ─►  $responseMessage');

    if (headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyHeaders);
      final formattedEntries = parsedJson.entries.map((entry) => '"${entry.key}": "${entry.value}"').join(',\n');
      sb.writeln('• HEADERS   ─►  $formattedEntries');
    }

    if (data != null) {
      final prettyData = encoder.convert(data);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyData);
      final formattedEntries = parsedJson.entries.map((entry) => '"${entry.key}": "${entry.value}"').join(',\n');
      sb.writeln('• DATA\t  ─►  $formattedEntries');
    }

    return sb.toString();
  }

  String _formatTime() => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}
