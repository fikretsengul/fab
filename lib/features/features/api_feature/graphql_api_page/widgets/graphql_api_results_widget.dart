import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/graphql_api_page/blocs/get_posts_graphql_bloc.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/models/graphql_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLApiResultsWidget extends StatelessWidget {
  const GraphQLApiResultsWidget({super.key, this.data, this.result});

  final PostsPaginated$Query? data;
  final QueryResult? result;

  @override
  Widget build(BuildContext context) {
    final total = data?.posts?.meta?.totalCount ?? 0;
    final posts = data?.posts?.data ?? [];

    return posts.isEmpty
        ? Center(child: Text(tr('core.errors.no_item_found')))
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              if (BlocProvider.of<GetPostsGraphQLBloc>(context).shouldFetchMore(index, 5)) {
                BlocProvider.of<GetPostsGraphQLBloc>(context).fetchMore(offset: posts.length);
              }

              Widget tile = ListTile(leading: Text(posts[index]?.id ?? ''), title: Text(posts[index]?.title ?? ''));

              if (index == posts.length - 1 && posts.length < total) {
                tile = Column(
                  children: [tile, const Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())],
                );
              }

              return tile;
            },
          );
  }
}
