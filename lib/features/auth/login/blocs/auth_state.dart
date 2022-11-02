part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _AuthLoadingState;

  const factory AuthState.failed({required AlertModel alert}) = _AuthFailedState;

  const factory AuthState.authenticated({required UserModel user}) = _AuthAuthenticatedState;

  const factory AuthState.unauthenticated() = _AuthUnauthenticatedState;
}
