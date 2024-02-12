import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';

import '../../design.dart';

class FabButton extends StatelessWidget {
  const FabButton({
    required this.child,
    this.innerPadding = EdgeInsets.zero,
    this.outerPadding = EdgeInsets.zero,
    this.width,
    this.height,
    this.minSize = 0,
    this.disabledColor,
    this.onPressed,
    this.pressedOpacity = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.alignment = Alignment.center,
    this.color,
    super.key,
  });

  final EdgeInsetsGeometry outerPadding;
  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsetsGeometry innerPadding;
  final VoidCallback? onPressed;
  final double? minSize;
  final Color? color;
  final Color? disabledColor;
  final double? pressedOpacity;
  final BorderRadius? borderRadius;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: $.timings.mil200,
        child: CupertinoButton(
          padding: innerPadding,
          minSize: minSize,
          onPressed: onPressed,
          color: color,
          pressedOpacity: pressedOpacity,
          borderRadius: borderRadius,
          disabledColor: disabledColor ?? context.fabTheme.inactiveColor,
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
