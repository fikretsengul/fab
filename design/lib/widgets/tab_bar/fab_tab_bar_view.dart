import 'package:deps/packages/extended_tabs.dart';
import 'package:deps/packages/nested_scroll_view_plus/others/custom_scroll_provider.dart';
import 'package:flutter/material.dart';

class FabTabBarView extends StatelessWidget {
  const FabTabBarView({
    required this.tabController,
    required this.children,
    super.key,
  });

  final TabController tabController;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return CustomScrollProvider(
          tabController: tabController,
          parent: PrimaryScrollController.of(context),
          child: ExtendedTabBarView(
            controller: tabController,
            children: children,
          ),
        );
      },
    );
  }
}
