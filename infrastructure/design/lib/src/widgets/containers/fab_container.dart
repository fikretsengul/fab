import 'package:deps/packages/awesome_extensions.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

import '../../constants/paddings.dart';
import '../../constants/settings.dart';

@UseCase(
  name: 'FAB Container',
  type: FabContainer,
)
Widget fabContainer(BuildContext context) {
  return FabContainer(
    margin: Paddings.md.horizontal,
  );
}

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
    this.padding,
    this.margin,
    this.child,
    this.borderRadius = ThemeSettings.borderRadius,
  });

  final Offset offset;
  final Color? color;
  final Color? shadowColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double borderWidth;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;

  @override
  State<FabContainer> createState() => FabContainerState();
}

class FabContainerState extends State<FabContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius != null ? BorderRadius.all(Radius.circular(widget.borderRadius!)) : null,
        border: Border.fromBorderSide(
          BorderSide(
            color: widget.borderColor ?? context.theme.colorScheme.onBackground,
            width: widget.borderWidth,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? context.theme.colorScheme.onBackground,
            offset: widget.offset,
          ),
        ],
        color: widget.color ?? context.theme.colorScheme.background,
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.child,
    );
  }
}
