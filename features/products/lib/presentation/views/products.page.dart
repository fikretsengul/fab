// ignore_for_file: max_lines_for_function
// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/cached_network_image_plus.dart';
import 'package:deps/packages/extended_tabs.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/models/product.model.dart';
import '../cubits/product_list.cubit.dart';
import 'widgets/product_listing_card.dart';

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
      text: 'all',
    ),
    const Tab(
      text: 'clothes',
    ),
    const Tab(
      text: 'furniture',
    ),
  ];
  final cubit = locator<ProductListCubit>();

  @override
  Widget build(BuildContext context) {
    return FabScaffold(
      appBar: FabAppBarSettings(
        title: const Text('products.'),
        actions: [
          CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Icon(
              UIcons.boldRounded.heart,
              size: 22,
              color: context.appTheme.primaryColor,
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
              color: context.appTheme.primaryColor,
            ),
          ),
          PaddingGap.xs(),
        ],
        largeTitle: FabAppBarLargeTitleSettings(
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
        searchBar: FabAppBarSearchBarSettings(
          enabled: true,
        ),
        bottom: FabAppBarBottomSettings(
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ExtendedTabBar(
              tabs: _tabs,
              controller: _tabController,
              labelStyle: context.appTheme.bodyStyle.bold,
              unselectedLabelStyle: context.appTheme.bodyStyle.bold,
              labelPadding: const EdgeInsets.only(right: 16),
              labelColor: context.appTheme.onBackgroundColor,
              isScrollable: _tabController.length > 5,
              indicatorSize: TabBarIndicatorSize.label,
              mainAxisAlignment: MainAxisAlignment.start,
              indicator: CircleTabIndicator(
                color: context.appTheme.onBackgroundColor,
                radius: 2.8,
              ),
            ),
          ),
        ),
      ),
      onRefresh: cubit.refresh,
      tabController: _tabController,
      children: [
        PaginatedList<ProductModel, ProductListCubit>(
          bloc: cubit,
          localFilter: (product) => product.images.isEmpty || product.images.first.startsWith('['),
          itemBuilder: (_, product, __) {
            return ProductListingCard(product: product);
          },
        ),
        CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final number = index + 1;

                  return Container(
                    height: 50,
                    color:
                        index.isEven ? CupertinoColors.lightBackgroundGray : CupertinoColors.extraLightBackgroundGray,
                    alignment: Alignment.center,
                    child: Text(
                      '$number',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),

        // Third tab
        Column(
          children: [
            Container(height: 200, color: Colors.red),
            Container(height: 200, color: Colors.green),
            Container(height: 200, color: Colors.yellow),
          ],
        ),
      ],
    );
  }
}
