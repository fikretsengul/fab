// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';

class PaginatedList<T, C extends Cubit<PaginatedListState<T>>> extends StatefulWidget {
  const PaginatedList({
    required this.onNextPage,
    required this.itemBuilder,
    this.bloc,
    super.key,
    this.offset = 0,
    this.limit = 20,
    this.localFilter,
  });

  final C Function(BuildContext context)? bloc;
  final bool Function(T)? localFilter;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final int limit;
  final int offset;
  final ValueChanged<int> onNextPage;

  @override
  State<PaginatedList<T, C>> createState() => _PaginatedListState<T, C>();
}

class _PaginatedListState<T, C extends Cubit<PaginatedListState<T>>> extends State<PaginatedList<T, C>> {
  late final PagingController<int, T> _pagingController = PagingController(
    firstPageKey: widget.offset,
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(widget.onNextPage);
  }

/*   padding: EdgeInsets.symmetric(
          horizontal: $.paddings.sm,
          vertical: $.paddings.xs,
        ), */

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: $.paddings.sm,
        vertical: $.paddings.xs,
      ),
      sliver: BlocProvider(
        create: widget.bloc ?? (_) => $.get<C>(),
        child: BlocListener<C, PaginatedListState<T>>(
          listener: (_, state) {
            state.whenOrNull(
              refresh: () => _pagingController.refresh(),
              loaded: (items) {
                final newItems =
                    widget.localFilter != null ? (items.toList()..removeWhere(widget.localFilter!)) : items;
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
          child: PagedSliverGrid<int, T>(
            pagingController: _pagingController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisSpacing: $.paddings.sm,
              mainAxisSpacing: $.paddings.sm,
              crossAxisCount: 2,
            ),
            builderDelegate: PagedChildBuilderDelegate<T>(
              animateTransitions: true,
              itemBuilder: (context, item, index) {
                return widget.itemBuilder(context, item, index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
