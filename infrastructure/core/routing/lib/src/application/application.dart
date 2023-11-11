import 'package:flutter/material.dart';

import 'application_scope.dart';

/// Depends on [ApplicationScope] to be built first.
class Application extends StatefulWidget {
  const Application({
    required this.title,
    required this.theme,
    super.key,
  });

  final ThemeData theme;
  final String title;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      title: widget.title,
      theme: widget.theme,
      routerConfig: context.app.router.config,
    );
  }
}
