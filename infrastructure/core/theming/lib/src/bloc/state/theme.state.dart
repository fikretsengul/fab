part of '../theme.bloc.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required CustomTheme theme,
  }) = _ThemeState;

  factory ThemeState.initial() => _ThemeState(
        theme: CustomTheme.initial(),
      );
}
