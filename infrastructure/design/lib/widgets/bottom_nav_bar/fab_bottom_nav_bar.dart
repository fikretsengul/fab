import 'package:deps/core/commons/extensions.dart';
import 'package:deps/core/commons/helpers.dart';
import 'package:flutter/material.dart';

import '../../design.dart';
import 'others/custom_indicator_shape.dart';

class FabBottomNavBar extends StatelessWidget {
  const FabBottomNavBar({
    required this.destinations,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.labelBehavior,
    super.key,
  });

  final int selectedIndex;
  final void Function(int)? onDestinationSelected;
  final List<Widget> destinations;
  final NavigationDestinationLabelBehavior? labelBehavior;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColoredBox(
          color: context.background,
          child: Container(
            margin: Paddings.md.horizontal,
            height: ThemeSettings.borderWidth,
            decoration: BoxDecoration(
              color: context.onBackground,
              borderRadius: Radiuses.md.circularBorder,
            ),
          ),
        ),
        NavigationBar(
          height: labelBehavior == NavigationDestinationLabelBehavior.alwaysHide ? 52 : null,
          indicatorColor: Colors.transparent,
          indicatorShape: CustomIndicatorShape(),
          labelBehavior: labelBehavior,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: destinations,
        ),
      ],
    );
  }
}
