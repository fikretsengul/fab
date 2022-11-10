import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.destinations,
    required this.currentPageIndex,
  });

  final List<Widget> destinations;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular($constants.theme.defaultBorderRadius),
        topRight: Radius.circular($constants.theme.defaultBorderRadius),
      ),
      child: NavigationBar(
        height: 60,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) => getIt<AppCubit>().changePageIndex(index: index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: destinations,
      ),
    );
  }
}
