import 'package:deps/infrastructure/networking.dart';
import 'package:deps/infrastructure/theming.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'routes/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: di<ThemeCubit>(),
      builder: (context, state) {
        return MaterialApp.router(
          themeMode: state.theme.mode,
          theme: state.theme.data,
          title: 'Flutter Advanced Boilerplate',
          routerConfig: _appRouter.config(
            reevaluateListenable: di<DioTokenRefresh>().interceptor.getAuthStatusListenable(),
          ),
        );
      },
    );
  }
}
