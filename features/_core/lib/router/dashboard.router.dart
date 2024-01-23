// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/cupertino.dart' hide CupertinoNavigationBar;

import '../cubits/translation/translation_cubit.dart';

@RoutePage()
class DashboardRouter extends StatelessWidget {
  const DashboardRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => $.get<UserCubit>(),
      child: AutoTabsScaffold(
        routes: [
          const ProductsRouter(),
          SettingsRoute(),
        ],
        navigatorObservers: () => [HeroController()],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BlocBuilder<TranslationCubit, Locale>(
            builder: (_, __) {
              return CupertinoNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  CupertinoNavigationBarItem(
                    label: $.tr.products.title,
                    icon: const Icon(CupertinoIcons.house),
                    selectedIcon: const Icon(CupertinoIcons.house_fill),
                  ),
                  CupertinoNavigationBarItem(
                    label: $.tr.settings.title,
                    icon: const Icon(CupertinoIcons.settings),
                    selectedIcon: const Icon(CupertinoIcons.settings_solid),
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
