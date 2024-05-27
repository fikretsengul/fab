// ignore_for_file: max_lines_for_function
// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import '../cubits/product_list.cubit.dart';
import 'test.dart';
import 'widgets/product_appbar_actions.dart';
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
  final _cubit = locator<ProductListCubit>();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FabScaffold(
      appBar: FabAppBarSettings(
        title: const Text('products.'),
        actions: [const ProductAppBarActions()],
        searchBar: FabAppBarSearchBarSettings(
          enabled: true,
        ),
        largeTitle: FabAppBarLargeTitleSettings(
          enabled: true,
          largeTitle: 'products.',
          actions: [
            FabImage(
              width: 30,
              height: 30,
              uri: $.get<UserCubit>().state.avatar,
              onPressed: $.get<UserCubit>().logout,
            ),
          ],
        ),
        bottom: FabAppBarBottomSettings(
          enabled: true,
          height: 36,
          child: FabTabBar(
            tabs: _tabs,
            controller: _tabController,
          ),
        ),
      ),
      onRefresh: _cubit.refresh,
      isCustomScrollView: true,
      child: FabTabBarView(
        tabController: _tabController,
        children: [
          FabKeepChildAlive(
            child: PaginatedGridList<ProductModel, ProductListCubit>(
              index: 0,
              bloc: _cubit,
              localFilter: (product) => product.images.isEmpty || product.images.first.startsWith('['),
              itemHeight: 275,
              skeletonBuilder: (_) {
                return ProductListingCard(product: ProductModel.empty());
              },
              itemBuilder: (_, product, __) {
                return ProductListingCard(product: product);
              },
            ),
          ),
          const FabKeepChildAlive(
            child: Test(index: 1),
          ),
          Column(
            children: [
              Container(height: 200, color: Colors.red),
              Container(height: 200, color: Colors.green),
              Container(height: 200, color: Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }
}
