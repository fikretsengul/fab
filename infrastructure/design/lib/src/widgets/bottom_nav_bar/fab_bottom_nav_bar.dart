import 'package:deps/design/design.dart';
import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

import 'others/custom_indicator_shape.dart';

class FabBottomNavBar extends StatelessWidget {
  const FabBottomNavBar({
    required this.destinations,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final void Function(int)? onDestinationSelected;
  final List<Widget> destinations;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.theme.colorScheme.onBackground,
            width: ThemeSettings.borderWidth,
          ),
        ),
      ),
      child: NavigationBar(
        indicatorShape: CustomIndicatorShape(
          borderSide: const BorderSide(width: ThemeSettings.borderWidth),
          borderRadius: ThemeSettings.borderRadius,
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations,
      ),
    );
  }
}
