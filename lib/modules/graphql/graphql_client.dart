import 'package:flutter_advanced_boilerplate/features/app/models/env_model.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/graphql_link.dart';
import 'package:flutter_advanced_boilerplate/modules/token_refresh/graphql_token_refresh.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient initGraphQLClient(
  EnvModel env,
  GraphQLTokenRefresh tokenRefresh,
) {
  final httpClient = GraphQLLink(
    tokenRefresh: tokenRefresh,
  );

  final socketClient = GraphQLLink(
    isSubscription: true,
    url: env.graphQLApiUrl,
    tokenRefresh: tokenRefresh,
  );

  final link = Link.split(
    (request) => request.isSubscription,
    socketClient,
    Link.from([
      httpClient,
      HttpLink(env.graphQLApiUrl),
    ]),
  );

  return GraphQLClient(
    defaultPolicies: DefaultPolicies(subscribe: Policies(fetch: FetchPolicy.noCache)),
    link: link,
    cache: GraphQLCache(),
  );
}
