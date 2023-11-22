import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../random_svg_background.dart';
import 'svg_item_manager.dart';

class SVGWidget extends StatelessWidget {
  const SVGWidget({
    required this.svgItem,
    required this.variant,
    super.key,
    this.color,
  });

  final SVGItem svgItem;
  final SvgVariants variant;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: svgItem.position.dx,
      top: svgItem.position.dy,
      child: SvgPicture.asset(
        '../infrastructure/design/${svgItem.path}',
        colorFilter: variant == SvgVariants.simple || variant == SvgVariants.threed
            ? ColorFilter.mode(color ?? context.onBackground, BlendMode.srcIn)
            : null,
        width: svgItem.size,
        height: svgItem.size,
      ),
    );
  }
}
