// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of '../logout.cubit.dart';

/// `LogoutState` is an immutable class representing the different states of the logout process.
/// It uses the `freezed` package to provide copyable, equatable, and immutable state objects.
@freezed
class LogoutState with _$LogoutState {
  const factory LogoutState.failed(Failure failure) = LogoutStateFailed;

  const factory LogoutState.initial() = LogoutStateInitial;

  const factory LogoutState.loading() = LogoutStateLoading;

  const factory LogoutState.succeeded(User user) = LogoutStateSucceeded;
}
