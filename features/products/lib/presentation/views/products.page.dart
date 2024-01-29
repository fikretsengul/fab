// ignore_for_file: max_lines_for_function
// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/cached_network_image_plus.dart';
import 'package:deps/packages/nested_scroll_view_plus.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/models/product.model.dart';
import '../cubits/product_list.cubit.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);
  final List<Tab> _tabs = [
    const Tab(
      text: 'All',
    ),
    const Tab(
      text: 'Clothes',
    ),
    const Tab(
      text: 'Furniture',
    ),
  ];
  final cubit = locator<ProductListCubit>();

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      appBar: AppBarSettings(
        title: const Text('products.'),
        actions: [
          CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Icon(
              UIcons.boldRounded.heart,
              size: 22,
              color: context.appTheme.primary,
            ),
          ),
          PaddingGap.md(),
          CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Icon(
              UIcons.boldRounded.shopping_bag,
              size: 20,
              color: context.appTheme.primary,
            ),
          ),
          PaddingGap.xs(),
        ],
        largeTitle: AppBarLargeTitleSettings(
          largeTitle: 'products.',
          actions: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () => $.get<UserCubit>().logout(),
              child: CacheNetworkImagePlus(
                borderRadius: 16,
                imageUrl: $.get<UserCubit>().state.avatar,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
        searchBar: AppBarSearchBarSettings(
          enabled: true,
        ),
        bottom: AppBarBottomSettings(
          enabled: true,
          child: PaddingSymmetric.sm(
            horizontal: true,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.zero,
              tabs: _tabs,
            ),
          ),
        ),
      ),
      onRefresh: cubit.refresh,
      forceScroll: true,
      isCustomScrollView: true,
      body: TabBarView(
        controller: _tabController,
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              const OverlapInjectorPlus(),
              PaginatedList<ProductModel, ProductListCubit>(
                bloc: cubit,
                onNextPage: (bloc, offset) => bloc.getProducts(offset: offset),
                localFilter: (product) => product.images.isEmpty || product.images.first.startsWith('['),
                itemBuilder: (_, product, __) {
                  return CupertinoCard(
                    onPressed: () => $.navigator.push(
                      ProductDetailsRoute(product: product),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Hero(
                            tag: '${product.id}',
                            child: CupertinoImage(
                              uri: product.images.first,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          // Second tab
          const Center(
            child: Text('Tab 2'),
          ),

          // Third tab
          const Center(
            child: Text('Tab 3'),
          ),
        ],
      ),
    );
  }
}
