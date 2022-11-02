import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_container_transform.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
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

    return CustomContainerTransform(
      openWidget: widget,
      closedBuilder: (context, _) {
        return Card(
          color: widget != null ? getCustomOnPrimaryColor(context) : getPrimaryColor(context),
          child: Padding(
            padding: const EdgeInsets.all(Constants.paddingM),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleLarge!.apply(fontWeightDelta: 2),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
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
