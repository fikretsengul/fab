import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.widget,
  });

  final String title;
  final String content;
  final IconData icon;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final textTheme = widget != null ? Theme.of(context).primaryTextTheme : Theme.of(context).textTheme;

    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 0,
      openElevation: 0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      closedColor: Colors.transparent,
      openColor: getTheme(context).surface,
      middleColor: getTheme(context).surface,
      tappable: widget != null,
      openBuilder: (context, _) => widget ?? const SizedBox(),
      closedBuilder: (context, _) {
        return Card(
          elevation: 0,
          color: widget != null ? getCustomOnPrimaryColor(context) : getPrimaryColor(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr(title),
                  style: textTheme.titleLarge!.apply(fontWeightDelta: 2),
                ),
                const SizedBox(height: 8),
                Text(
                  tr(content),
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Icon(
                  icon,
                  size: 32,
                  color: textTheme.bodyMedium!.color,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
