// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/cupertino.dart' hide CupertinoNavigationBar;

import '../cubits/translation/translation_cubit.dart';

@RoutePage()
class DashboardRouter extends StatelessWidget {
  const DashboardRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => $.get<UserCubit>()),
        BlocProvider(create: (_) => $.get<CartCubit>()),
      ],
      child: AutoTabsScaffold(
        routes: const [
          ProductsRouter(),
          SettingsRoute(),
        ],
        navigatorObservers: () => [HeroController()],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BlocBuilder<TranslationCubit, Locale>(
            builder: (_, __) {
              return FabNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  CupertinoNavigationBarItem(
                    label: $.tr.products.title,
                    icon: Icon(UIcons.regularRounded.bags_shopping),
                    selectedIcon: Icon(UIcons.solidRounded.bags_shopping),
                  ),
                  CupertinoNavigationBarItem(
                    label: $.tr.settings.title,
                    icon: Icon(UIcons.regularRounded.settings),
                    selectedIcon: Icon(UIcons.solidRounded.settings),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
