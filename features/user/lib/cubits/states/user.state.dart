part of '../user.cubit.dart';

enum UserStateStatus { initial, loading, failed, succeeded }

@freezed
class UserState with _$UserState {
  const factory UserState({
    required UserStateStatus status,
    required UserModel user,
    required Failure failure,
  }) = _UserState;

  factory UserState.initial() => UserState(
        status: UserStateStatus.initial,
        user: UserModel.empty(),
        failure: Failure.empty(),
      );
}
