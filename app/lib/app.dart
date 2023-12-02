import 'package:deps/core/theming/theming.dart';
import 'package:deps/features/auth.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di<AuthBloc>()),
        BlocProvider(create: (_) => di<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (_, state) {
          return MaterialApp.router(
            themeMode: state.theme.mode,
            theme: state.theme.data,
            title: 'Flutter Advanced Boilerplate',
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
