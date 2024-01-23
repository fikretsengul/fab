import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';

import '../card/cupertino_card.dart';

class CupertinoAlert extends StatelessWidget {
  const CupertinoAlert({
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
    final theme = CupertinoTheme.of(context);

    return CupertinoCard(
      color: color,
      padding: const EdgeInsets.all(20),
      radius: 36,
      child: Row(
        children: [
          Icon(
            icon,
            size: 36,
            color: theme.primaryContrastingColor,
          ),
          PaddingGap.md(),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.navTitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
