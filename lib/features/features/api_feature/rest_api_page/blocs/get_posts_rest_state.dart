part of 'get_posts_rest_cubit.dart';

@freezed
class GetPostsRestState with _$GetPostsRestState {
  const factory GetPostsRestState.failed({required AlertModel alert}) = _GetPostsRestStateFailed;

  const factory GetPostsRestState.initial() = _GetPostsRestStateInitial;

  const factory GetPostsRestState.loading() = _GetPostsRestStateLoading;

  const factory GetPostsRestState.refresh() = _GetPostsRestStateRefresh;

  const factory GetPostsRestState.success({
    required PaginatedModel<PostRestModel> posts,
  }) = _GetPostsRestStateSuccess;
}
