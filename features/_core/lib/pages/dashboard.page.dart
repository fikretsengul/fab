// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:feature_user/presentation/cubits/user.cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../_core/super/super.dart';
import '../cubits/translation/translation_cubit.dart';
import '../router/router.gr.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => $.get<UserCubit>(),
      child: AutoTabsScaffold(
        routes: const [
          HomeRouter(),
          SettingsRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BlocBuilder<TranslationCubit, Locale>(
            builder: (_, __) {
              return AdaptiveNavigationBar.cupertino(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  AdaptiveNavItem(
                    icon: Icon(
                      $.platform.isAndroid ? Icons.home : CupertinoIcons.home,
                    ),
                    label: 'Home',
                  ),
                  AdaptiveNavItem(
                    icon: Icon(
                      $.platform.isAndroid ? Icons.settings : CupertinoIcons.settings,
                    ),
                    label: 'Settings',
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
