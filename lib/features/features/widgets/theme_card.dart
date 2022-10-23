import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.mode,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final AdaptiveThemeMode mode;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AdaptiveTheme.of(context).mode == mode ? getCustomOnPrimaryColor(context) : getPrimaryColor(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Icon(
          icon,
          size: 28,
          color: AdaptiveTheme.of(context).mode != mode ? getTheme(context).primary : Colors.white,
        ),
      ),
    );
  }
}
