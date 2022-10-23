import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'mutation_bloc.freezed.dart';
part 'mutation_event.dart';
part 'mutation_state.dart';

abstract class MutationBloc<T> extends Bloc<MutationEvent<T>, MutationState<T>> {
  MutationBloc({required this.options}) : super(const MutationState.initial()) {
    on<MutationEvent<T>>(_onEvent);

    request = getIt<GraphQLClient>().watchQuery(options);
  }

  final WatchQueryOptions<Object?> options;
  late ObservableQuery<dynamic> request;

  Future<void> _onEvent(
    MutationEvent<T> event,
    Emitter<MutationState<T>> emit,
  ) async {
    emit(const MutationState.loading());

    await event.map(
      run: (e) async {
        (request
              ..variables = e.variables
              ..optimisticResult = e.optimisticResult)
            .fetchResults();

        await emit.forEach<QueryResult>(
          request.stream,
          onData: (result) {
            final exception = result.exception;

            if (exception != null) {
              emit(MutationState<T>.failed(error: exception, result: result));
            }

            if (!result.isLoading && !result.hasException) {
              emit(
                MutationState<T>.succeeded(
                  data: parseData(result.data),
                  result: result,
                ),
              );
            }

            return state;
          },
        );
      },
    );
  }

  void run(Map<String, dynamic> variables, {Object? optimisticResult}) {
    add(MutationEvent<T>.run(variables, optimisticResult: optimisticResult));
  }

  T parseData(Map<String, dynamic>? data);

  void dispose() {
    request.close();
  }
}
