import 'dart:math';

import 'package:flutter/material.dart';

import 'others/random_svg_background/svg_item_manager.dart';
import 'others/random_svg_background/svg_widget.dart';

enum SvgVariants { simple, mixed, threed }

/// `RandomSvgBackground` is a widget that generates a dynamic background composed of randomly
/// placed SVG images. It overlays a provided child widget on top of this SVG background.
/// The number and size of the SVGs are configurable.
class RandomSvgBackground extends StatefulWidget {
  /// Creates a `RandomSvgBackground` widget.
  ///
  /// [child]: The child widget to be displayed on top of the SVG background.
  /// [desiredCount]: The desired number of SVG images to be placed in the background.
  /// [minSize]: The minimum size of the SVG images.
  /// [maxSize]: The maximum size of the SVG images.
  RandomSvgBackground({
    required this.child,
    required this.count,
    this.variant = SvgVariants.mixed,
    this.color,
    super.key,
    this.minSize = 100.0,
    this.maxSize = 200.0,
  })  : assert(count > 0, 'Count must be at least 1'),
        assert(
          variant == SvgVariants.simple && variant == SvgVariants.threed || color == null,
          'Color can only be set when variant is SvgVariants.simple and SvgVariants.threed',
        );

  final Widget child;
  final int count;
  final SvgVariants variant;
  final Color? color;
  final double maxSize;
  final double minSize;

  @override
  State<RandomSvgBackground> createState() => _RandomSvgBackgroundState();
}

class _RandomSvgBackgroundState extends State<RandomSvgBackground> {
  final List<SVGItem> svgItemList = [];
  late SvgItemManager svgItemManager;

  @override
  void initState() {
    super.initState();
    svgItemManager = SvgItemManager(
      maxSize: widget.maxSize,
      minSize: widget.minSize,
      variant: widget.variant,
      color: widget.color,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _placeSvgs());
  }

  /// Places SVGs randomly within the context bounds while ensuring they don't overlap.
  void _placeSvgs() {
    final contextSize = (context.findRenderObject()! as RenderBox).size;
    final maxSvgs = svgItemManager.calculateMaxSvgs(contextSize);
    final actualCount = min(widget.count, maxSvgs);
    var attempts = 0;
    const maxAttempts = 100;

    while (svgItemList.length < actualCount && attempts < maxAttempts) {
      final svgItem = svgItemManager.generateRandomSvgItem(contextSize);
      if (svgItemManager.isUniquePosition(svgItemList, svgItem)) {
        svgItemList.add(svgItem);
        attempts = 0;
      } else {
        attempts++;
      }
    }

    // ignore: avoid_empty_blocks
    setState(() {}); // Trigger a rebuild with the placed SVGs
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...svgItemList.map(
          (svgItem) => SVGWidget(
            svgItem: svgItem,
            variant: widget.variant,
            color: widget.color,
          ),
        ),
        widget.child,
      ],
    );
  }
}
