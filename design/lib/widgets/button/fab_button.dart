import 'package:flutter/cupertino.dart';

import '../../design.dart';

class FabButton extends StatelessWidget {
  const FabButton({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.minSize = 0,
    this.disabledColor,
    this.onPressed,
    this.pressedOpacity = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.alignment = Alignment.center,
    this.color,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final double? minSize;
  final Color? color;
  final Color? disabledColor;
  final double? pressedOpacity;
  final BorderRadius? borderRadius;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding,
      minSize: minSize,
      onPressed: onPressed,
      color: color,
      pressedOpacity: pressedOpacity,
      borderRadius: borderRadius,
      disabledColor: disabledColor ?? context.appTheme.placeholderColor,
      alignment: alignment,
      child: child,
    );
  }
}
