// ignore_for_file: max_lines_for_function, max_lines_for_file
// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubits/product_list.cubit.dart';
import 'widgets/product_appbar_actions.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);
  final List<Tab> _tabs = [
    const Tab(
      text: 'All',
    ),
    const Tab(
      text: 'Clothes',
    ),
/*     const Tab(
      text: 'furniture',
    ), */
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
      tabController: _tabController,
      appBarSettings: FabAppBarSettings(
        title: const Text('Kişiler'),
        actions: [const ProductAppBarActions()],
        searchBar: FabAppBarSearchBarSettings(
          enabled: true,
          searchResult: Container(
            color: Colors.yellow,
          ),
        ),
        largeTitle: FabAppBarLargeTitleSettings(
          enabled: true,
          text: 'Kişiler',
          actions: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 15,
            ),
/*             FabImage(
              width: 30,
              height: 30,
              uri: $.get<UserCubit>().state.avatar,
              onPressed: $.get<UserCubit>().logout,
            ), */
          ],
        ),
        toolbar: FabAppBarToolbarSettings(
          enabled: true,
          padding: EdgeInsets.zero,
          child: FabTabBar(
            tabs: _tabs,
            controller: _tabController,
          ),
        ),
      ),
      onRefreshes: [_cubit.refresh, null],
      children: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final number = index + 1;

              return Container(
                height: 50,
                color: index.isEven ? CupertinoColors.lightBackgroundGray : CupertinoColors.extraLightBackgroundGray,
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final number = index + 1;

              return Container(
                height: 50,
                color: index.isEven ? CupertinoColors.lightBackgroundGray : CupertinoColors.extraLightBackgroundGray,
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
    );
  }
}
