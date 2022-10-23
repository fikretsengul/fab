part of 'query_bloc.dart';

@freezed
class QueryState<T> with _$QueryState<T?> {
  const factory QueryState.initial() = _QueryStateInitial;

  const factory QueryState.loading({
    required QueryResult result,
  }) = _QueryStateLoading<T>;

  const factory QueryState.error({
    required OperationException error,
    required QueryResult result,
  }) = _QueryStateError<T>;

  const factory QueryState.loaded({
    required T data,
    required QueryResult result,
  }) = _QueryStateLoaded<T>;

  const factory QueryState.refetch({
    T? data,
    QueryResult? result,
  }) = _QueryStateRefetch<T>;

  const factory QueryState.fetchMore({
    required T data,
    QueryResult? result,
  }) = _QueryStateFetchMore<T>;
}
