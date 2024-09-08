// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/infinite_scroll_pagination.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

class PaginatedGridList<T, C extends PaginatedListCubit<T>> extends StatefulWidget {
  const PaginatedGridList({
    required this.itemHeight,
    required this.itemBuilder,
    required this.skeletonBuilder,
    required this.index,
    this.onNextPage,
    this.bloc,
    super.key,
    this.offset = 0,
    this.limit = 20,
    this.localFilter,
  });

  final int index;
  final double itemHeight;
  final bool Function(T)? localFilter;
  final void Function(C bloc, int offset)? onNextPage;
  final C? bloc;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final int limit;
  final int offset;
  final Widget Function(BuildContext context) skeletonBuilder;

  @override
  State<PaginatedGridList<T, C>> createState() => _PaginatedGridListState<T, C>();
}

class _PaginatedGridListState<T, C extends PaginatedListCubit<T>> extends State<PaginatedGridList<T, C>> {
  late final C _bloc = widget.bloc ?? $.get<C>();
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

    _pagingController.addPageRequestListener((offset) {
      if (widget.onNextPage != null) {
        widget.onNextPage!.call(_bloc, offset);
      }

      _bloc.fetch(offset: offset, limit: widget.limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, PaginatedListState<T>>(
      bloc: _bloc,
      listener: (_, state) {
        $.debug(state);
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
      child: SliverPadding(
        padding: $.paddings.sm.horizontal,
        sliver: PagedSliverGrid<int, T>(
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: ((context.width - ($.paddings.sm * 3)) / 2) / widget.itemHeight,
            crossAxisSpacing: $.paddings.sm,
            mainAxisSpacing: $.paddings.sm,
            crossAxisCount: 2,
          ),
          builderDelegate: PagedChildBuilderDelegate<T>(
            animateTransitions: true,
            itemBuilder: (context, item, index) {
              return widget.itemBuilder(context, item, index);
            },
            noItemsFoundIndicatorBuilder: (_) {
              return FabEmptyList(
                icon: UIcons.solidRounded.bags_shopping,
                title: 'no product found.',
                subtitle: 'the product list is currently empty.',
              );
            },
            firstPageProgressIndicatorBuilder: (_) {
              return SizedBox(
                height: context.height,
                child: GridView.builder(
                  itemCount: 8,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: $.paddings.sm,
                    crossAxisSpacing: $.paddings.sm,
                    childAspectRatio: ((context.width - ($.paddings.sm * 3)) / 2) / widget.itemHeight,
                  ),
                  itemBuilder: (context, index) {
                    return widget.skeletonBuilder(context);
                  },
                ),
              );
            },
            newPageProgressIndicatorBuilder: (_) {
              return widget.skeletonBuilder(context);
            },
          ),
        ),
      ),
    );
  }
}
