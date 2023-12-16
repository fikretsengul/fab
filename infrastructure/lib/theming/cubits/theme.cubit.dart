// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/locator/locator.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:flutter/material.dart';

import '../models/custom_theme.model.dart';

part 'states/theme.state.dart';
part 'theme.cubit.freezed.dart';

/// `ThemeCubit` is responsible for managing the theme state of the application.
/// It extends `HydratedCubit`, enabling automatic persistence of the theme state.
@lazySingleton
class ThemeCubit extends HydratedCubit<ThemeState> {
  /// Constructs `ThemeCubit` with an initial theme state.
  ThemeCubit() : super(ThemeState.initial());

  /// Converts JSON data into a `ThemeState` object.
  ///
  /// Tries to create a `ThemeState` from the given JSON. If it fails, it creates
  /// a default `ThemeState` using the `CustomTheme` instance provided by the dependency injector.
  ///
  /// [json]: The JSON map to convert.
  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    try {
      final theme = CustomTheme.fromJson(json['theme'] as Map<String, dynamic>);

      return ThemeState(theme: theme);
    } catch (e) {
      return ThemeState(theme: di<CustomTheme>());
    }
  }

  /// Converts a `ThemeState` object into a JSON map.
  ///
  /// [state]: The `ThemeState` instance to convert.
  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return <String, dynamic>{
      'theme': state.theme.toJson(),
    };
  }

  /// Sets the theme mode and optionally updates the theme colors.
  ///
  /// Emits a new theme state with the updated values. If a value is not provided,
  /// it defaults to the current state value.
  ///
  /// [mode]: Optional `ThemeMode` to set.
  /// [colors]: Optional `ThemeColors` to update.
  Future<void> setThemeMode({
    ThemeMode? mode,
    ThemeData? data,
  }) async {
    final themeMode = mode ?? state.theme.mode;
    final brightness = themeMode == ThemeMode.system
        ? WidgetsBinding.instance.platformDispatcher.platformBrightness
        : themeMode == ThemeMode.light
            ? Brightness.light
            : Brightness.dark;

    final theme = CustomTheme(
      mode: themeMode,
      brightness: brightness,
      data: data ?? state.theme.data,
    );

    emit(state.copyWith(theme: theme));
  }
}
