part of 'query_bloc.dart';

@freezed
class QueryEvent<T> with _$QueryEvent<T> {
  const factory QueryEvent.error({
    required OperationException error,
    required QueryResult result,
  }) = _QueryEventError<T>;

  const factory QueryEvent.run({
    Map<String, dynamic>? variables,
    Object? optimisticResult,
  }) = _QueryEventRun<T>;

  const factory QueryEvent.loading({
    required QueryResult result,
  }) = _QueryEventLoading<T>;

  const factory QueryEvent.loaded({
    required T data,
    required QueryResult result,
  }) = _QueryEventLoaded<T>;

  const factory QueryEvent.refetch() = _QueryEventRefetch<T>;

  const factory QueryEvent.fetchMore({
    required FetchMoreOptions options,
  }) = _QueryEventFetchMore<T>;
}
