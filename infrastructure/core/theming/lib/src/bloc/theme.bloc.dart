import 'package:deps/locator/locator.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:flutter/material.dart';

import '../model/custom_theme.dart';
import '../model/theme_colors.dart';

part 'state/theme.state.dart';
part 'theme.bloc.freezed.dart';

@lazySingleton
class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    try {
/*       final theme = CustomTheme.fromJson(json['theme'] as Map<String, dynamic>);

      return ThemeState(theme: theme); */
      return ThemeState(theme: di<CustomTheme>());
    } catch (e) {
      return ThemeState(theme: di<CustomTheme>());
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return <String, dynamic>{
      'theme': state.theme.toJson(),
    };
  }

  Future<void> setThemeMode({
    ThemeMode? mode,
    ThemeColors? colors,
  }) async {
    final themeMode = mode ?? state.theme.mode;
    final brightness = themeMode == ThemeMode.system
        ? WidgetsBinding.instance.platformDispatcher.platformBrightness
        : themeMode == ThemeMode.light
            ? Brightness.light
            : Brightness.dark;

    final theme = CustomTheme.custom(
      mode: themeMode,
      brightness: brightness,
      colors: colors ?? state.theme.colors,
    );

    emit(state.copyWith(theme: theme));
  }
}
