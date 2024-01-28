// ignore_for_file: max_lines_for_function
// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/cached_network_image_plus.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/product.model.dart';
import '../cubits/product_list.cubit.dart';

@RoutePage()
class ProductsPage extends StatelessWidget {
  ProductsPage({super.key});

  final productListCubit = $.get<ProductListCubit>();

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      forceScroll: true,
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
          child: PaddingSymmetric.md(
            horizontal: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: $.paddings.sm,
                children: ['asddsassks', 'Clothesss', 'Furniture', 'Shoes', 'Miscellaneous'].map((e) {
                  return CupertinoCard(
                    useCupertinoRounder: true,
                    height: 30,
                    padding: $.paddings.sm.horizontal,
                    color: e == 'All' ? context.colorScheme.primary : null,
                    child: Center(
                      child: Text(
                        e,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: e == 'All' ? CupertinoTheme.of(context).primaryContrastingColor : null,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
      hasScrollView: true,
      onRefresh: productListCubit.refresh,
      body: PaginatedList<ProductModel, ProductListCubit>(
        bloc: (_) => productListCubit,
        onNextPage: (offset) => productListCubit.getProducts(offset: offset),
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
    );
  }
}
