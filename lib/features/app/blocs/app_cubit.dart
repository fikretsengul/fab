import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_boilerplate/assets.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';

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
    final introViewed = json['introViewed'] as bool? ?? false;
    final themePath = json['themePath'] as String? ?? '';
    return AppState(
        pageIndex: 0, introViewed: introViewed, themePath: themePath);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return <String, dynamic>{
      'themePath': state.themePath,
      'introViewed': state.introViewed,
    };
  }

  void setIntroViewed({required bool introViewed}) => emit(
        state.copyWith(
          introViewed: introViewed,
        ),
      );
  void changePageIndex({required int index}) => emit(
        state.copyWith(
          pageIndex: index,
        ),
      );

  Future<void> setThemePath(
    BuildContext context, {
    required String themePath,
  }) async {
    emit(state.copyWith(themePath: themePath));
  }
}
