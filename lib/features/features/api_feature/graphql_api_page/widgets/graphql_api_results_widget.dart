import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/utils/skeleton_loader.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/graphql_api_page/blocs/get_posts_graphql_bloc.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/models/graphql_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:keframe/keframe.dart';

class GraphQLApiResultsWidget extends StatelessWidget {
  const GraphQLApiResultsWidget({super.key, this.data, this.result});

  final PostsPaginated$Query? data;
  final QueryResult? result;

  @override
  Widget build(BuildContext context) {
    final total = data?.posts?.meta?.totalCount ?? 0;
    final posts = data?.posts?.data ?? [];

    return posts.isEmpty
        ? Center(child: Text(context.t.core.errors.others.no_item_found))
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              if (BlocProvider.of<GetPostsGraphQLBloc>(context).shouldFetchMore(index, 5)) {
                BlocProvider.of<GetPostsGraphQLBloc>(context).fetchMore(offset: posts.length);
              }

              Widget tile = FrameSeparateWidget(
                index: index,
                placeHolder: _buildTileSkeleton(),
                child: ListTile(
                  leading: Text(posts[index]?.id ?? ''),
                  title: Text(posts[index]?.title ?? ''),
                ),
              );

              if (index == posts.length - 1 && posts.length < total) {
                tile = Column(
                  children: [tile, const Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())],
                );
              }

              return tile;
            },
          );
  }

  Widget _buildTileSkeleton() {
    return SkeletonLoader(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              constraints: const BoxConstraints(minHeight: 20, maxHeight: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ],
        ),
        title: Container(
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}
