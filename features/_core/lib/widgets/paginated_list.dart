// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';

import '_core/cubits/paginated_list/paginated_list.state.dart';

class PaginatedList<T, C extends Cubit<PaginatedListState<T>>> extends StatefulWidget {
  const PaginatedList({
    required this.fetchPage,
    required this.itemBuilder,
    super.key,
    this.firstPageKey = 0,
    this.pageSize = 20,
  });

  final int firstPageKey;
  final int pageSize;
  final ValueChanged<int> fetchPage;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  @override
  State<PaginatedList<T, C>> createState() => _PaginatedListState<T, C>();
}

class _PaginatedListState<T, C extends Cubit<PaginatedListState<T>>> extends State<PaginatedList<T, C>> {
  late final PagingController<int, T> _pagingController = PagingController(
    firstPageKey: widget.firstPageKey,
  );

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(widget.fetchPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, PaginatedListState<T>>(
      listener: (_, state) {
        state.whenOrNull(
          refresh: () => _pagingController.refresh(),
          loaded: (items) {
            final isLastPage = items.length < widget.pageSize;

            if (isLastPage) {
              _pagingController.appendLastPage(items);
            } else {
              final nextPageKey = _pagingController.nextPageKey ?? 0 + items.length;
              _pagingController.appendPage(items, nextPageKey);
            }
          },
          failed: (failure) => _pagingController.error = failure.message,
        );
      },
      child: RefreshIndicator(
        onRefresh: () => Future.sync(_pagingController.refresh),
        child: PagedListView<int, T>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<T>(
            animateTransitions: true,
            itemBuilder: (_, item, index) => widget.itemBuilder(context, item, index),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
