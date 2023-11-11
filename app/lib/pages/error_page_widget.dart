import 'package:deps/core/routing/page.dart';
import 'package:flutter/material.dart';

class ErrorPageWidget extends StatelessWidget {
  const ErrorPageWidget({super.key, this.exception});

  static ErrorPage delegate = ErrorPage(
    name: ErrorPageWidget.name,
    path: ErrorPageWidget.path,
    builder: (_, exception) => ErrorPageWidget(exception: exception),
  );

  static const String name = 'Error';
  static const String path = '/error';

  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
      ),
      body: Center(
        child: Text('Error Message: $exception'),
      ),
    );
  }
}
