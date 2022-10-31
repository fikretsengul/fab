import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/graphql_api_page/blocs/get_posts_graphql_bloc.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/graphql_api_page/widgets/graphql_api_results_widget.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/blocs/query/query_bloc.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/models/graphql_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphQLApiPage extends StatefulWidget {
  const GraphQLApiPage({super.key});

  @override
  State<GraphQLApiPage> createState() => _GraphQLApiPageState();
}

class _GraphQLApiPageState extends State<GraphQLApiPage> {
  Completer<void> _refreshCompleter = Completer<void>();

  Future<void> _handleRefreshStart() {
    BlocProvider.of<GetPostsGraphQLBloc>(context).refetch();

    return _refreshCompleter.future;
  }

  void _handleRefreshEnd() {
    _refreshCompleter.complete();
    _refreshCompleter = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetPostsGraphQLBloc>()..run(),
      child: RefreshIndicator(
        onRefresh: () async => _handleRefreshStart(),
        child: BlocConsumer<GetPostsGraphQLBloc, QueryState<PostsPaginated$Query>>(
          listener: (_, state) {
            state.mapOrNull(
              refetch: (_) => _handleRefreshEnd(),
            );
          },
          builder: (_, state) {
            return state.when(
              initial: Container.new,
              error: (_, __) => Center(
                child: Text(
                  context.t.core.errors.others.something_went_wrong,
                ),
              ),
              loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (data, result) => GraphQLApiResultsWidget(data: data, result: result),
              refetch: (data, result) => GraphQLApiResultsWidget(data: data, result: result),
              fetchMore: (data, result) => GraphQLApiResultsWidget(data: data, result: result),
            );
          },
        ),
      ),
    );
  }
}
