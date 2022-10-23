import 'package:flutter_advanced_boilerplate/features/app/models/env_model.dart';
import 'package:flutter_advanced_boilerplate/modules/graphql/graphql_client.dart';
import 'package:flutter_advanced_boilerplate/modules/token_refresh/graphql_token_refresh.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class GraphQLInjection {
  GraphQLClient graphql(EnvModel env, GraphQLTokenRefresh tokenRefresh) => initGraphQLClient(env, tokenRefresh);
}
