import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/theme_model.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/aliases.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:statsfl/statsfl.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.savedThemeMode,
    required this.lightTheme,
    required this.darkTheme,
  });

  final AdaptiveThemeMode savedThemeMode;
  final ThemeModel lightTheme;
  final ThemeModel darkTheme;

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
              appRouter,
              // Sentrie's tracking navigation events with the usage of autorouter.
              navigatorObservers: () => [
                SentryNavigatorObserver(),
              ],
            ),
            routeInformationParser: appRouter.defaultRouteParser(),

            /// EasyLocalization configuration.
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: LocaleSettings.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
