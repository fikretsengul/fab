part of '../auth.bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated() = AuthAuthenticated;

  const factory AuthState.loading() = AuthLoading;

  const factory AuthState.unauthenticated() = AuthUnauthenticated;
}
