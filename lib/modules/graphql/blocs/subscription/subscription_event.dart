part of 'subscription_bloc.dart';

@freezed
class SubscriptionEvent<T> with _$SubscriptionEvent<T> {
  const factory SubscriptionEvent.error({
    required OperationException error,
    required QueryResult result,
    T? data,
  }) = _SubscriptionEventError<T>;

  const factory SubscriptionEvent.run({
    required SubscriptionOptions options,
  }) = _SubscriptionEventRun<T>;

  const factory SubscriptionEvent.loading({
    required QueryResult result,
  }) = _SubscriptionEventLoading<T>;

  const factory SubscriptionEvent.loaded({
    required T? data,
    required QueryResult result,
  }) = _SubscriptionEventLoaded<T>;
}
