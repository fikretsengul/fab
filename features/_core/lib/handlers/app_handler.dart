// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_function, max_lines_for_file

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/cupertino.dart';
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
    super.key,
  });

  final AppSettings appSettings;
  final bool routerObserverEnabled;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => $.get<NetworkCubit>()),
        BlocProvider(create: (_) => $.get<TranslationCubit>()),
        BlocProvider(create: (_) => $.get<ThemeCubit>()),
      ],
      child: BlocListener<NetworkCubit, NetworkState>(
        listener: (_, state) {
          if (state == NetworkState.connected) {
            $.dialog.popDialog();
          } else if (state == NetworkState.disconnected) {
            $.dialog.showSheet(
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
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (_, __) {
/*                 if ($.platform.isIOS) {
                  return CupertinoApp.router(
                    title: appSettings.title,
                    showPerformanceOverlay: appSettings.showPerformanceOverlay,
                    checkerboardRasterCacheImages: appSettings.checkerboardRasterCacheImages,
                    checkerboardOffscreenLayers: appSettings.checkerboardOffscreenLayers,
                    showSemanticsDebugger: appSettings.showSemanticsDebugger,
                    debugShowCheckedModeBanner: appSettings.debugShowCheckedModeBanner,
                    //theme: state.theme.data,
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
                } */
                return MaterialApp.router(
                  title: appSettings.title,
                  debugShowMaterialGrid: appSettings.debugShowMaterialGrid,
                  showPerformanceOverlay: appSettings.showPerformanceOverlay,
                  checkerboardRasterCacheImages: appSettings.checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers: appSettings.checkerboardOffscreenLayers,
                  showSemanticsDebugger: appSettings.showSemanticsDebugger,
                  debugShowCheckedModeBanner: appSettings.debugShowCheckedModeBanner,
                  //themeMode: state.theme.mode,
                  themeMode: ThemeMode.dark,
                  theme: ThemeData(
                    useMaterial3: false,
                    scaffoldBackgroundColor: Colors.black,
                    cupertinoOverrideTheme: CupertinoThemeData(
                      brightness: Brightness.dark,
                      barBackgroundColor: Colors.black,
                      textTheme: CupertinoTextThemeData(
                        textStyle: const CupertinoTextThemeData().textStyle.copyWith(
                              color: CupertinoColors.white,
                              inherit: false,
                            ),
                      ),
                    ),
                  ),

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
