// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_function, max_lines_for_file

import 'package:deps/design/design.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/adaptive_theme.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../_core/_i18n/translations.g.dart';
import '../_core/super/super.dart';
import '../cubits/translation/translation_cubit.dart';
import '../router/router.dart';

final class AppSettings {
  AppSettings({
    this.title = '',
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  });

  final String title;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
}

class AppHandler extends StatelessWidget {
  const AppHandler({
    required this.appSettings,
    required this.routerObserverEnabled,
    this.savedThemeMode,
    super.key,
  });

  final AppSettings appSettings;
  final AdaptiveThemeMode? savedThemeMode;
  final bool routerObserverEnabled;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => $.get<NetworkCubit>()),
        BlocProvider(create: (_) => $.get<TranslationCubit>()),
      ],
      child: BlocListener<NetworkCubit, NetworkState>(
        listener: (_, state) {
          if (state == NetworkState.connected) {
            $.dialog.popDialog();
          } else if (state == NetworkState.disconnected) {
            $.dialog.showMaterialSheet(
              builder: (_) => const SizedBox(
                height: 50,
                child: Center(
                  child: Text('Connected'),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<TranslationCubit, Locale>(
          builder: (_, locale) {
            return AdaptiveTheme(
              light: ThemeData(extensions: [AppTheme.light]).copyWith(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS: PopScopeAwareCupertinoPageTransitionBuilder(),
                  },
                ),
              ),
              dark: ThemeData(extensions: [AppTheme.dark]).copyWith(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS: PopScopeAwareCupertinoPageTransitionBuilder(),
                  },
                ),
              ),
              initial: savedThemeMode ?? AdaptiveThemeMode.light,
              builder: (light, dark) {
                return MaterialApp.router(
                  title: appSettings.title,
                  debugShowMaterialGrid: appSettings.debugShowMaterialGrid,
                  showPerformanceOverlay: appSettings.showPerformanceOverlay,
                  checkerboardRasterCacheImages: appSettings.checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers: appSettings.checkerboardOffscreenLayers,
                  showSemanticsDebugger: appSettings.showSemanticsDebugger,
                  debugShowCheckedModeBanner: appSettings.debugShowCheckedModeBanner,
                  builder: (_, child) {
                    return MediaQuery.withNoTextScaling(
                      child: child!,
                    );
                  },
                  theme: light,
                  darkTheme: dark,
                  locale: locale,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                  routerConfig: $.get<FeaturesRouter>().config(
                        navigatorObservers: () => routerObserverEnabled
                            ? [
                                RouterTalkerObserver(talker: $.get<Talker>()),
                                HeroController(),
                              ]
                            : [],
                      ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
