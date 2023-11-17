// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/core/theming/theming.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart' hide Router;

import '../../routing.dart';

/// `Application` is a StatefulWidget that sets up the main application structure.
/// It integrates theming and routing functionalities and serves as the root widget.
class Application extends StatefulWidget {
  /// Constructs the `Application` widget.
  ///
  /// [theme]: The ThemeData to apply to the application.
  /// [title]: The title of the application, used in the app bar and task manager.
  /// [router]: The Router instance for managing app navigation.
  const Application({
    required this.title,
    required this.theme,
    required this.router,
    super.key,
  });

  final ThemeData theme;
  final String title;
  final Router router;

  @override
  State<StatefulWidget> createState() => _AppState();
}

/// The state class for `Application`.
/// Manages the building of the app with theming and routing capabilities.
class _AppState extends State<Application> {
  /// Builds the application widget.
  /// Integrates `BlocProvider` for theme management using `ThemeCubit`.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Creates a ThemeCubit instance for managing app theme.
      create: (_) => di<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          // MaterialApp with router and theme configurations based on Bloc state.
          return MaterialApp.router(
            themeMode: state.theme.mode,
            theme: createTheme(state.theme),
            title: widget.title,
            routerConfig: widget.router.config,
          );
        },
      ),
    );
  }
}
