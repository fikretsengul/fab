// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of '../login.cubit.dart';

/// `LoginState` is an immutable class representing the different states of the login process.
/// It uses the `freezed` package to provide copyable, equatable, and immutable state objects.
@freezed
class LoginState with _$LoginState {
  /// Represents the failed state of the login process.
  /// This state is emitted when a login attempt fails, along with the failure reason.
  ///
  /// [failure]: The `Failure` object containing details about the login failure.
  const factory LoginState.failed(Failure failure) = LoginFailed;

  /// Represents the initial state of the login process.
  /// This is the default state before any login attempts are made.
  const factory LoginState.initial() = LoginInitial;

  /// Represents the loading state of the login process.
  /// This state is emitted during the ongoing login operation.
  const factory LoginState.loading() = LoginLoading;

  /// Represents the succeeded state of the login process.
  /// This state is emitted when a login attempt is successful, along with the user details.
  ///
  /// [user]: The `User` object containing details of the successfully logged-in user.
  const factory LoginState.succeeded(User user) = LoginSucceeded;
}
