import 'dart:async';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_boilerplate/features/app/app.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/modules/bloc_observer/observer.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/modules/sentry/sentry_module.dart';
import 'package:flutter_advanced_boilerplate/theme/app_theme_creator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      // Preserve splash screen until initialization complete.
      WidgetsFlutterBinding.ensureInitialized();

      // Inits localization.
      await EasyLocalization.ensureInitialized();

      // Inits hive storage.
      await Hive.initFlutter();

      // Configures dependency injection to init modules and singletons.
      await configureDependencyInjection();

      // Increases android devices preferred refresh rate to its maximum.
      if (Platform.isAndroid) {
        await FlutterDisplayMode.setHighRefreshRate();
      }

      // Sets up allowed device orientations and other settings for the app.
      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );

      // Gets saved theme and creates dynamic themes for light and dark mode.
      final savedThemeMode = await AdaptiveTheme.getThemeMode() ?? AdaptiveThemeMode.light;
      final lightTheme = await createAppTheme();
      final darkTheme = await createAppTheme(isDark: true);

      // Sets system ui styles.
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        getAppOverlayStyle(
          isDark: savedThemeMode.isDark,
          colorScheme: savedThemeMode.isDark
              ? darkTheme.colorScheme.materialColorScheme
              : lightTheme.colorScheme.materialColorScheme,
        ),
      );

      // This setting smoothes transition color for LinearGradient.
      Paint.enableDithering = true;

      // Inits sentry for error tracking.
      await initializeSentry();

      // Initiates blocs' persistent storage.
      HydratedBlocOverrides.runZoned<void>(
        () {
          // Initiates service locator and app main.
          return runApp(
            // Sentrie's performance tracing for AssetBundles.
            DefaultAssetBundle(
              bundle: SentryAssetBundle(),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<AppCubit>()),
                ],
                child: EasyLocalization(
                  path: 'assets/translations',
                  supportedLocales: const [
                    Locale('en'),
                    Locale('tr'),
                  ],
                  startLocale: const Locale('en'),
                  fallbackLocale: const Locale('en'),
                  useFallbackTranslations: true,
                  child: App(
                    savedThemeMode: savedThemeMode,
                    lightTheme: lightTheme,
                    darkTheme: darkTheme,
                  ),
                ),
              ),
            ),
          );
        },
        blocObserver: Observer(),
        storage: await HydratedStorage.build(
          storageDirectory: await getApplicationDocumentsDirectory(),
        ),
      );
    },
    (exception, stackTrace) async {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    },
  );
}
