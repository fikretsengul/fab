part of 'mutation_bloc.dart';

@freezed
class MutationEvent<T> with _$MutationEvent<T> {
  const factory MutationEvent.run(
    Map<String, dynamic> variables, {
    Object? optimisticResult,
  }) = _MutationEventRun<T>;
}
