// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of '../login.cubit.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.failed(IFailure failure) = LoginStateFailed;

  const factory LoginState.initial() = LoginStateInitial;

  const factory LoginState.loading() = LoginStateLoading;

  const factory LoginState.succeeded(UserModel user) = LoginStateSucceeded;
}
