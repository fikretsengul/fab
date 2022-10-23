part of 'subscription_bloc.dart';

@freezed
class SubscriptionState<T> with _$SubscriptionState<T> {
  const factory SubscriptionState.initial() = _SubscriptionStateInitial;

  const factory SubscriptionState.loading({
    required QueryResult result,
  }) = _SubscriptionStateLoading<T>;

  const factory SubscriptionState.error({
    required OperationException error,
    required QueryResult result,
    T? data,
  }) = _SubscriptionStateError<T>;

  const factory SubscriptionState.loaded({
    T? data,
    required QueryResult result,
  }) = _SubscriptionStateLoaded<T>;
}
