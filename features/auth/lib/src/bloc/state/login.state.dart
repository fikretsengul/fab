part of '../login.bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.failed(Failure failure) = LoginFailed;

  const factory LoginState.initial() = LoginInitial;

  const factory LoginState.loading() = LoginLoading;

  const factory LoginState.succeded(User user) = LoginSucceded;
}
