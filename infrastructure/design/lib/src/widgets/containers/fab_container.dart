import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_settings.dart';

class FabContainer extends StatefulWidget {
  FabContainer({
    super.key,
    this.offset = ThemeSettings.offset,
    this.color,
    this.shadowColor,
    this.borderColor,
    this.height,
    this.width,
    this.borderWidth = ThemeSettings.borderWidth,
    this.shadowBlurRadius = ThemeSettings.shadowBlurRadius,
    this.shadowBlurStyle = ThemeSettings.shadowBlurStyle,
    this.padding,
    this.margin,
    this.child,
    this.borderRadius,
  });

  final Offset offset;
  final Color? color;
  final Color? shadowColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double borderWidth;
  final double shadowBlurRadius;
  final BlurStyle shadowBlurStyle;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<FabContainer> createState() => FabContainerState();
}

class FabContainerState extends State<FabContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height ?? 100,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: Border.fromBorderSide(
          BorderSide(
            color: widget.borderColor ?? context.theme.colorScheme.onBackground,
            width: widget.borderWidth,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? context.theme.colorScheme.shadow,
            blurRadius: widget.shadowBlurRadius,
            offset: widget.offset,
            blurStyle: widget.shadowBlurStyle,
          ),
        ],
        color: widget.color ?? context.theme.colorScheme.background,
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.child,
    );
  }
}
