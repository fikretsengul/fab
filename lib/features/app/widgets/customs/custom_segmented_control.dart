import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

class CustomSegmentedControl<T> extends StatelessWidget {
  const CustomSegmentedControl({
    super.key,
    this.currentIndex,
    this.fixedWidth,
    required this.children,
    required this.onValueChanged,
  });

  final T? currentIndex;
  final double? fixedWidth;
  final Map<T, Widget> children;
  final void Function(T) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<T>(
      fixedWidth: fixedWidth,
      initialValue: currentIndex,
      children: children,
      decoration: BoxDecoration(
        color: getPrimaryColor(context),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      thumbDecoration: BoxDecoration(
        color: getCustomOnPrimaryColor(context),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: onValueChanged,
    );
  }
}
