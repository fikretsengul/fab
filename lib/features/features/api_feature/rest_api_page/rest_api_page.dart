import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/utils/skeleton_loader.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/rest_api_page/blocs/get_posts_rest_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/features/api_feature/rest_api_page/models/post_rest_model.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:keframe/keframe.dart';

class RestApiPage extends StatefulWidget {
  const RestApiPage({super.key});

  @override
  State<RestApiPage> createState() => _RestApiPageState();
}

class _RestApiPageState extends State<RestApiPage> {
  final PagingController<int, PostRestModel> _pagingController = PagingController(firstPageKey: 1);
  final GetPoststRestCubit _cubit = getIt<GetPoststRestCubit>();

  @override
  void initState() {
    _pagingController.addPageRequestListener(_cubit.getPosts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetPoststRestCubit, GetPostsRestState>(
      bloc: _cubit,
      listener: (_, state) {
        state.mapOrNull(
          failed: (st) => _pagingController.error = st.alert,
          refresh: (_) => _pagingController.refresh(),
          success: (st) {
            if (st.posts.total > st.posts.size * st.posts.currentPage) {
              _pagingController.appendPage(
                st.posts.items,
                st.posts.currentPage + 1,
              );
            } else {
              _pagingController.appendLastPage(st.posts.items);
            }
          },
        );
      },
      child: PagedListView<int, PostRestModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<PostRestModel>(
          firstPageErrorIndicatorBuilder: (context) => Center(
            child: Text(
              context.t.core.errors.others.something_went_wrong,
            ),
          ),
          noItemsFoundIndicatorBuilder: (_) => Center(
            child: Text(
              context.t.core.errors.others.no_item_found,
            ),
          ),
          firstPageProgressIndicatorBuilder: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          itemBuilder: (_, post, index) => FrameSeparateWidget(
            index: index,
            placeHolder: _buildTileSkeleton(),
            child: ListTile(
              leading: Text(post.id),
              title: Text(post.title),
            ),
          ),
        ),
      ),
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
