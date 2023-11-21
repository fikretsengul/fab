import 'package:deps/design/design.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CrosshatchBackground(
      child: Center(
        child: FabContainer(
          padding: Paddings.md.all,
          child: FabHighlightedText(
            text: 'Fikret bir <a>coder</a>.',
            style: const TextStyle(
              fontFamily: FontFamily.tTRamillasTrial,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            tags: {
              'a': HighlightedTextStyle(
                style: const TextStyle(
                  fontFamily: FontFamily.tTRamillasTrial,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                highlightColor: Colors.yellow,
                offset: const Offset(12, 12),
              ),
            },
          ),
        ),
      ),
    );
  }
}
