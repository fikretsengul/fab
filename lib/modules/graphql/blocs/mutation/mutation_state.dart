part of 'mutation_bloc.dart';

@freezed
class MutationState<T> with _$MutationState<T> {
  const factory MutationState.initial() = _MutationInitial;

  const factory MutationState.loading() = _MutationLoading;

  const factory MutationState.succeeded({
    required T data,
    required QueryResult result,
  }) = _MutationSucceeded<T>;

  const factory MutationState.failed({
    required OperationException error,
    required QueryResult result,
  }) = _MutationFailed;
}
