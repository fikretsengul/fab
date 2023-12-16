// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of '../auth.cubit.dart';

/// `AuthState` is an immutable class representing the different states of authentication.
/// It uses the `freezed` package to provide copyable, equatable, and immutable state objects.
@freezed
class AuthState with _$AuthState {
  /// Represents the authenticated state.
  /// This state indicates that the user is successfully authenticated.
  const factory AuthState.authenticated() = AuthAuthenticated;

  /// Represents the loading state.
  /// This state indicates that the authentication process is ongoing.
  const factory AuthState.loading() = AuthLoading;

  /// Represents the unauthenticated state.
  /// This state indicates that the user is not authenticated.
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
}
