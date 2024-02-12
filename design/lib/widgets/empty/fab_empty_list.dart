import 'package:deps/features/features.dart';
import 'package:flutter/material.dart';

import '../../design.dart';

class FabEmptyList extends StatelessWidget {
  const FabEmptyList({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: context.fabTheme.onBackgroundColor,
          ),
          PaddingGap.sm(),
          Text(
            title,
            style: context.fabTheme.headlineStyle,
          ),
          PaddingGap.xxs(),
          Text(
            subtitle,
            style: context.fabTheme.calloutStyle,
          ),
        ],
      ),
    );
  }
}
