import 'package:flutter_advanced_boilerplate/modules/graphql/blocs/query/query_bloc.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/models/graphql_api.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPostsGraphQLBloc extends QueryBloc<PostsPaginated$Query> {
  GetPostsGraphQLBloc()
      : super(
          options: WatchQueryOptions<Object?>(
            fetchPolicy: FetchPolicy.noCache,
            document: POSTS_PAGINATED_QUERY_DOCUMENT,
            variables: PostsPaginatedArguments(
              options: PageQueryOptions(
                paginate: PaginateOptions(
                  page: 1,
                  limit: $constants.api.maxItemToBeFetchedAtOneTime,
                ),
                sort: [],
                operators: [],
                search: SearchOptions(q: ''),
              ),
            ).toJson(),
          ),
        );

  @override
  PostsPaginated$Query parseData(Map<String, dynamic>? data) {
    return PostsPaginated$Query.fromJson(data ?? <String, dynamic>{});
  }

  @override
  bool shouldFetchMore(int i, int threshold) {
    return state.maybeWhen(
      loaded: (data, result) {
        final total = data?.posts?.meta?.totalCount ?? 0;
        final posts = data?.posts?.data ?? [];

        if (posts.isNotEmpty && posts.length < total) {
          return posts.length % $constants.api.maxItemToBeFetchedAtOneTime == 0 && i == posts.length - threshold;
        }

        return false;
      },
      orElse: () => false,
    );
  }

  void fetchMore({required int offset}) {
    add(
      QueryEvent.fetchMore(
        options: FetchMoreOptions(
          variables: PostsPaginatedArguments(
            options: PageQueryOptions(
              paginate: PaginateOptions(
                page: offset ~/ $constants.api.maxItemToBeFetchedAtOneTime + 1,
                limit: $constants.api.maxItemToBeFetchedAtOneTime,
              ),
              sort: [],
              operators: [],
              search: SearchOptions(q: ''),
            ),
          ).toJson(),
          updateQuery: (previousResultData, fetchMoreResultData) {
            final prevResultData = (previousResultData?['posts'] as Map<String, dynamic>)['data'] as List<dynamic>;
            final moreResultData = (fetchMoreResultData?['posts'] as Map<String, dynamic>)['data'] as List<dynamic>;

            final repos = <dynamic>[...prevResultData, ...moreResultData];

            (fetchMoreResultData?['posts'] as Map<String, dynamic>)['data'] = repos;

            return fetchMoreResultData;
          },
        ),
      ),
    );
  }
}
