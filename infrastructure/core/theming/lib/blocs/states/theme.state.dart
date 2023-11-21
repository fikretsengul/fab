// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of '../theme.bloc.dart';

/// `ThemeState` is an immutable state class representing the theme state of the application.
/// It uses the `freezed` package to provide an immutable and copyable state model.
@freezed
class ThemeState with _$ThemeState {
  /// Constructs a `ThemeState` with a given `CustomTheme`.
  ///
  /// [theme]: The `CustomTheme` instance representing the current theme state.
  const factory ThemeState({
    required CustomTheme theme,
  }) = _ThemeState;

  /// Creates an initial `ThemeState` with default theme settings.
  ///
  /// Returns a `ThemeState` with an initial `CustomTheme`.
  factory ThemeState.initial() => _ThemeState(
        theme: CustomTheme.inital(),
      );
}
