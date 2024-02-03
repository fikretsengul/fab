import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';

import '../../_core/constants/fab_theme.dart';
import '../card/fab_card.dart';

class FabAlert extends StatelessWidget {
  const FabAlert({
    required this.color,
    required this.icon,
    required this.message,
    super.key,
  });

  final Color color;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return FabCard(
      color: color,
      padding: const EdgeInsets.all(20),
      radius: 36,
      child: Row(
        children: [
          Icon(
            icon,
            size: 36,
            color: context.fabTheme.onBackgroundColor,
          ),
          PaddingGap.md(),
          Expanded(
            child: Text(
              message,
              style: context.fabTheme.bodyStyle,
            ),
          ),
        ],
      ),
    );
  }
}
