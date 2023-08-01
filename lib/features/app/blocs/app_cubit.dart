import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/theme_model.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/theme/app_theme.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

@lazySingleton
class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(AppState.initial());

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    try {
      final theme = ThemeModel.fromJson(json['theme'] as Map<String, dynamic>);

      return AppState(pageIndex: 0, theme: theme);
    } catch (e) {
      return AppState(pageIndex: 0, theme: getIt<ThemeModel>());
    }
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return <String, dynamic>{
      'theme': state.theme.toJson(),
    };
  }

  void changePageIndex({required int index}) => emit(
        state.copyWith(
          pageIndex: index,
        ),
      );

  Future<void> setThemeMode(
    BuildContext context, {
    required ThemeMode mode,
  }) async {
    if (mode == ThemeMode.system) {
      final theme = ThemeModel(
        mode: ThemeMode.system,
        light: await createTheme(brightness: Brightness.light),
        dark: await createTheme(brightness: Brightness.dark),
      );
      emit(state.copyWith(theme: theme));

      if (context.mounted) {
        updateSystemOverlay(context);
      }
    }

    emit(state.copyWith.theme(mode: mode));

    if (context.mounted) {
      updateSystemOverlay(context);
    }
  }

  Future<void> setThemeColor(
    BuildContext context, {
    required Color color,
  }) async {
    final theme = ThemeModel(
      mode: state.theme.mode,
      light: await createTheme(color: color, brightness: Brightness.light),
      dark: await createTheme(color: color, brightness: Brightness.dark),
    );

    emit(state.copyWith(theme: theme));

    if (context.mounted) {
      updateSystemOverlay(context);
    }
  }

  void updateSystemOverlay(BuildContext context) {
    final systemModeIsDark = View.of(context).platformDispatcher.platformBrightness == Brightness.dark;

    final isDark = state.theme.mode == ThemeMode.system ? systemModeIsDark : state.theme.mode == ThemeMode.dark;
    final colorScheme = isDark ? state.theme.dark.colorScheme : state.theme.light.colorScheme;
    final primaryColor = ElevationOverlay.colorWithOverlay(
      colorScheme.surface,
      colorScheme.primary,
      3,
    );

    SystemChrome.setSystemUIOverlayStyle(
      createOverlayStyle(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
      ),
    );
  }
}
