import 'package:deps/features/features.dart';
import 'package:deps/packages/extended_tabs.dart';
import 'package:flutter/material.dart';

import '../../design.dart';
import 'widgets/test.dart';

class FabTabBar extends StatelessWidget {
  const FabTabBar({
    required this.tabs,
    required this.controller,
    super.key,
  });

  final List<Widget> tabs;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: $.paddings.md,
        right: $.paddings.md,
        bottom: 2,
      ),
      child: ExtendedTabBar(
        tabs: tabs,
        controller: controller,
        labelStyle: context.fabTheme.bodyStyle.bold,
        unselectedLabelStyle: context.fabTheme.bodyStyle.bold,
        labelPadding: $.paddings.md.right,
        labelColor: context.fabTheme.primaryColor,
        unselectedLabelColor: context.fabTheme.inactiveColor,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        mainAxisAlignment: MainAxisAlignment.start,
        indicator: TabIndicator(
          height: 5,
          width: 5,
          color: context.fabTheme.primaryColor,
          padding: const EdgeInsets.only(bottom: 4),
          radius: 2.5,
        ),
      ),
    );
  }
}
