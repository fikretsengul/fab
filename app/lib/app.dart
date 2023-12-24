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
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void showPersistentSnackBar(BuildContext context) {
    _scaffoldKey.currentState?.showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: Text('This is a persistent SnackBar!'),
        duration: Duration(days: 1),
      ),
    );
  }

  void dismissSnackBar(BuildContext context) {
    _scaffoldKey.currentState?.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      bloc: di<NetworkCubit>(),
      listener: (_, state) {
        if (state == NetworkState.connected) {
          dismissSnackBar(context);
        } else if (state == NetworkState.disconnected) {
          showPersistentSnackBar(context);
        }
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: di<ThemeCubit>(),
        builder: (context, state) {
          return MaterialApp.router(
            scaffoldMessengerKey: _scaffoldKey,
            themeMode: state.theme.mode,
            theme: state.theme.data,
            title: 'Flutter Advanced Boilerplate',
            routerConfig: _appRouter.config(
              reevaluateListenable: di<INetworkClient>().tokenStorage.getAuthStatusListenable(),
            ),
          );
        },
      ),
    );
  }
}
