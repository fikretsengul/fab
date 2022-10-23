import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/theme_model.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/aliases.dart';
import 'package:flutter_advanced_boilerplate/utils/router.gr.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:statsfl/statsfl.dart';

class App extends StatelessWidget {
  App({
    super.key,
    required this.savedThemeMode,
    required this.lightTheme,
    required this.darkTheme,
  });

  final AdaptiveThemeMode savedThemeMode;
  final ThemeModel lightTheme;
  final ThemeModel darkTheme;

  // Intializes router instance.
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return StatsFl(
      maxFps: 120,
      align: Alignment.bottomRight,
      child: AdaptiveTheme(
        light: lightTheme.materialThemeData,
        dark: darkTheme.materialThemeData,
        initial: savedThemeMode,
        builder: (theme, darkTheme) {
          return MaterialApp.router(
            /// Theme configuration.
            theme: theme,
            darkTheme: darkTheme,

            /// Environment configuration.
            title: Constants.appTitle,
            debugShowCheckedModeBanner: env.debugShowCheckedModeBanner,
            debugShowMaterialGrid: env.debugShowMaterialGrid,

            /// AutoRouter configuration.
            routerDelegate: AutoRouterDelegate(
              _appRouter,
              // Sentrie's tracking navigation events with the usage of autorouter.
              navigatorObservers: () => [
                SentryNavigatorObserver(),
              ],
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),

            /// EasyLocalization configuration.
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
