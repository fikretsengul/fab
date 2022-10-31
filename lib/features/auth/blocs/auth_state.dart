part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _AuthInitialState;

  const factory AuthState.loading() = _AuthLoadingState;

  const factory AuthState.success() = _AuthSuccessState;

  const factory AuthState.fail() = _AuthFailState;
}
