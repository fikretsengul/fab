// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/infinite_scroll_pagination.dart';
import 'package:deps/packages/nested_scroll_view_plus.dart';
import 'package:flutter/cupertino.dart';

class PaginatedList<T, C extends Cubit<PaginatedListState<T>>> extends StatefulWidget {
  const PaginatedList({
    required this.onNextPage,
    required this.itemBuilder,
    super.key,
    this.offset = 0,
    this.limit = 20,
    this.localFilter,
  });

  final int offset;
  final int limit;
  final ValueChanged<int> onNextPage;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool Function(T)? localFilter;

  @override
  State<PaginatedList<T, C>> createState() => _PaginatedListState<T, C>();
}

class _PaginatedListState<T, C extends Cubit<PaginatedListState<T>>> extends State<PaginatedList<T, C>> {
  late final PagingController<int, T> _pagingController = PagingController(
    firstPageKey: widget.offset,
  );

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(widget.onNextPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, PaginatedListState<T>>(
      listener: (_, state) {
        state.whenOrNull(
          refresh: () => _pagingController.refresh(),
          loaded: (items) {
            final newItems = widget.localFilter != null ? (items.toList()..removeWhere(widget.localFilter!)) : items;
            final isLastPage = newItems.length < widget.limit;

            if (isLastPage) {
              _pagingController.appendLastPage(newItems);
            } else {
              final nextPageKey = (_pagingController.nextPageKey ?? 0) + newItems.length;
              _pagingController.appendPage(newItems, nextPageKey);
            }
          },
          failed: (failure) => _pagingController.error = failure.message,
        );
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const OverlapInjectorPlus(),
          SliverPadding(
            padding: $.paddings.md.all,
            sliver: PagedSliverGrid<int, T>(
              pagingController: _pagingController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
              ),
              builderDelegate: PagedChildBuilderDelegate<T>(
                animateTransitions: true,
                itemBuilder: (_, item, index) => widget.itemBuilder(context, item, index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
