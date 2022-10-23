import 'dart:async';

import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/graphql_exception_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'query_bloc.freezed.dart';
part 'query_event.dart';
part 'query_state.dart';

abstract class QueryBloc<T> extends Bloc<QueryEvent<T>, QueryState<T>> {
  QueryBloc({required this.options}) : super(QueryState<T>.initial()) {
    on<QueryEvent<T>>(_onEvent);

    result = getIt<GraphQLClient>().watchQuery(options);

    result.stream.listen((QueryResult result) {
      if (state is _QueryStateRefetch &&
          result.source == QueryResultSource.cache &&
          options.fetchPolicy == FetchPolicy.cacheAndNetwork) {
        return;
      }

      if (result.isLoading && result.data == null) {
        add(QueryEvent.loading(result: result));
      }

      if (!result.isLoading && result.data != null) {
        add(
          QueryEvent<T>.loaded(
            data: parseData(result.data),
            result: result,
          ),
        );
      }

      final exception = result.exception;
      if (exception != null) {
        add(QueryEvent<T>.error(error: exception, result: result));
      }
    });
  }

  final WatchQueryOptions<Object?> options;
  late ObservableQuery<dynamic> result;

  void run({Map<String, dynamic>? variables, Object? optimisticResult}) {
    add(QueryEvent<T>.run(variables: variables, optimisticResult: optimisticResult));
  }

  void refetch() {
    add(QueryEvent<T>.refetch());
  }

  T parseData(Map<String, dynamic>? data);

  bool shouldFetchMore(int i, int threshold) => false;

  bool get isFetchingMore => state is _QueryStateFetchMore<T>;

  bool get isLoading => state is _QueryStateLoading<T>;

  bool get isLoaded => state is _QueryStateLoaded<T>;

  bool get isRefetching => state is _QueryStateRefetch<T>;

  bool get hasData =>
      state is _QueryStateLoaded<T> || state is _QueryStateFetchMore<T> || state is _QueryStateRefetch<T>;

  bool get hasError => state is _QueryStateError<T>;

  AlertModel get getError => graphQLExceptionHandler((state as _QueryStateError<T>).error);

  Future<void> _onEvent(
    QueryEvent<T> event,
    Emitter<QueryState<T>> emit,
  ) async {
    await event.map(
      error: (e) async {
        emit(QueryState<T>.error(error: e.error, result: e.result));
      },
      run: (e) {
        result.options =
            result.options.copyWithVariables(e.variables != null ? e.variables! : result.options.variables);

        if (e.optimisticResult != null) {
          result.options = result.options.copyWithOptimisticResult(e.optimisticResult);
        }

        result.fetchResults();
      },
      loading: (e) async => emit(QueryState.loading(result: e.result)),
      loaded: (e) async => emit(QueryState<T>.loaded(data: e.data, result: e.result)),
      refetch: (e) async {
        emit(
          QueryState<T>.refetch(
            data: state.maybeWhen(loaded: (data, _) => data, orElse: () => null),
          ),
        );

        await result.refetch();
      },
      fetchMore: (e) async {
        QueryState<T>.fetchMore(
          data: state.maybeWhen(loaded: (data, _) => data!, orElse: () => null as T),
        );

        await result.fetchMore(e.options);
      },
    );
  }

  void dispose() {
    result.close();
  }
}
