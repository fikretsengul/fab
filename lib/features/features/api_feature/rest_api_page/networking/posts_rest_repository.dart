import 'package:data_channel/data_channel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/paginated_model.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/rest_api_page/models/post_rest_model.dart';
import 'package:flutter_advanced_boilerplate/modules/dio/dio_exception_handler.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostsRestRepository {
  PostsRestRepository(this._dioClient);

  final Dio _dioClient;

  Future<DC<AlertModel, PaginatedModel<PostRestModel>>> getPosts(
    int page,
    int size,
  ) async {
    return dioExceptionHandler<PaginatedModel<PostRestModel>>(() async {
      final response = await _dioClient.post<Map<String, dynamic>>(
        '',
        data: {
          'query':
              'query PostsPaginated(\n  \$options: PageQueryOptions\n) {\n  posts(options: \$options) {\n    data {\n      id\n      title\n    }\n    meta {\n      totalCount\n    }\n  }\n}',
          'variables': {
            'options': {
              'paginate': {'page': page, 'limit': size},
            },
          },
        },
      );

      final data = (response.data?['data'] as Map<String, dynamic>)['posts'] as Map<String, dynamic>;
      final posts = (data['data'] as List).map((p) => PostRestModel.fromJson(p as Map<String, dynamic>)).toList();
      final total = (data['meta'] as Map<String, dynamic>)['totalCount'] as int;

      final paginatedPosts = PaginatedModel(currentPage: page, size: size, total: total, items: posts);

      /* final paginatedPosts = PaginatedModel<PostRestModel>.fromJson(
        response.data ?? {},
        (json) => PostRestModel.fromJson((json ?? {}) as Map<String, dynamic>),
      ); */

      return DC.data(paginatedPosts);
    });
  }
}
