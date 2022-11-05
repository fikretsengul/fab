part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required int pageIndex,
    required ThemeModel theme,
  }) = _AppState;

  factory AppState.initial() => _AppState(
        pageIndex: 0,
        theme: getIt<ThemeModel>(),
      );
}
