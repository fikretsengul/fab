import 'package:flutter/material.dart';
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

  void changePageIndex({required int index}) => emit(
        state.copyWith(
          pageIndex: index,
        ),
      );

  Future<void> setThemeMode({required ThemeMode mode}) async {
    if (mode == ThemeMode.system) {
      final theme = ThemeModel(
        mode: ThemeMode.system,
        light: await createTheme(brightness: Brightness.light),
        dark: await createTheme(brightness: Brightness.dark),
      );
      emit(state.copyWith(theme: theme));
    }

    emit(state.copyWith.theme(mode: mode));
  }

  Future<void> setThemeColor({required Color color}) async {
    final theme = ThemeModel(
      mode: state.theme.mode,
      light: await createTheme(color: color, brightness: Brightness.light),
      dark: await createTheme(color: color, brightness: Brightness.dark),
    );

    emit(state.copyWith(theme: theme));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    final theme = ThemeModel.fromJson(json['theme'] as Map<String, dynamic>);

    return AppState(pageIndex: 0, theme: theme);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      'theme': state.theme.toJson(),
    };
  }
}
