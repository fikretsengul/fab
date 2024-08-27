part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required int pageIndex,
    required bool introViewed,
    required String themePath,
  }) = _AppState;

  factory AppState.initial() => const _AppState(
        pageIndex: 0,
        introViewed: false,
        themePath: Assets.defaultTheme,
      );
}
