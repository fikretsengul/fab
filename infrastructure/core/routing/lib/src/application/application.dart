import 'package:deps/core/theming/theming.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/flutter_bloc.dart';
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
    return BlocProvider(
      create: (_) => di<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            // Configures theme.
            themeMode: state.theme.mode,
            theme: createTheme(state.theme),
            title: widget.title,
            routerConfig: context.app.router.config,
          );
        },
      ),
    );
  }
}
