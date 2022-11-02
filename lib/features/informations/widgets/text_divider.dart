import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: getTheme(context).onBackground.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: getTextTheme(context).bodyMedium,
            ),
          ),
          Expanded(
            child: Divider(
              color: getTheme(context).onBackground.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
