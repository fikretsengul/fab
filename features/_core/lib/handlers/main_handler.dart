// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_returning_widgets

import 'dart:async';

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/path_provider.dart';
import 'package:deps/packages/talker_bloc_logger.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../_core/super/super.dart';
import '_core/error_page.dart';
import 'app_handler.dart';

typedef AppWrapper = Widget Function(Widget widget);

final class ObserverSettings {
  ObserverSettings({
    this.blocSettings = const TalkerBlocLoggerSettings(),
    this.dioSettings = const TalkerDioLoggerSettings(),
    this.blocObserverEnabled = true,
    this.dioObserverEnabled = true,
    this.routerObserverEnabled = true,
    // this.analytics = const AnalyticsSettings(),
    // this.failure = const FailureSettings(),
  });

  final TalkerBlocLoggerSettings blocSettings;
  final TalkerDioLoggerSettings dioSettings;
  final bool blocObserverEnabled;
  final bool dioObserverEnabled;
  final bool routerObserverEnabled;
}

final class MainHandler {
  MainHandler._();

  static String _env(Env? env) {
    // Determine the default value first
    final defaultValue = switch (env) {
      Env.dev => 'dev',
      Env.prod => 'prod',
      _ => 'dev',
    };

    // Use the determined default value in the fromEnvironment constructor
    return const bool.hasEnvironment('flavor') ? const String.fromEnvironment('flavor') : defaultValue;
  }

  static Future<void> init({
    Env? env,
    ObserverSettings? observerSettings,
    AppSettings? appSettings,
    Future<void> Function(WidgetsBinding binding)? mainCallback,
    AppWrapper? appWrapper,
  }) async {
    await runZonedGuarded(
      () async {
        // Init optionals
        appSettings ??= AppSettings();
        observerSettings ??= ObserverSettings();

        // Init widgets binding
        final binding = WidgetsFlutterBinding.ensureInitialized();

        // Init service locator
        initLocator(_env(env));

        // Configure observers
        if (observerSettings!.blocObserverEnabled) {
          Bloc.observer = BlocTalkerObserver(talker: $.get<Talker>(), settings: observerSettings!.blocSettings);
        }

        if (observerSettings!.dioObserverEnabled) {
          $.get<INetworkClient>().setObserver(
                DioTalkerObserver(talker: $.get<Talker>(), settings: observerSettings!.dioSettings),
              );
        }

        // Handle errors
        ErrorWidget.builder = (details) {
          return ErrorPage(details: details);
        };

        FlutterError.onError = (details) {
          FlutterError.presentError(details);
          UnexpectedFlutterError(
            exception: details.exception,
            stack: details.stack,
          );

          return;
        };

        PlatformDispatcher.instance.onError = (error, stack) {
          UnexpectedPlatformError(
            exception: error,
            stack: stack,
          );

          return true;
        };

        // Init hydrated bloc
        HydratedBloc.storage = await HydratedStorage.build(
          storageDirectory: await getApplicationDocumentsDirectory(),
        );

        // Call additional setup
        await mainCallback?.call(binding);

        // Run the app
        runApp(
          appWrapper != null
              ? appWrapper(
                  AppHandler(
                    appSettings: appSettings!,
                    routerObserverEnabled: observerSettings!.routerObserverEnabled,
                  ),
                )
              : AppHandler(
                  appSettings: appSettings!,
                  routerObserverEnabled: observerSettings!.routerObserverEnabled,
                ),
        );
      },
      (error, stackTrace) => UnexpectedError(
        exception: error,
        stack: stackTrace,
      ),
    );
  }
}
