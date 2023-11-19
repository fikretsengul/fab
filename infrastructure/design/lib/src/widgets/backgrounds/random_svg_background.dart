// ignore_for_file: avoid_dynamic_calls

import 'dart:math';

import 'package:deps/packages/awesome_extensions.dart';
import 'package:deps/packages/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.gen.dart';

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
  final List<Map<String, dynamic>> svgDataList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _placeSvgs());
  }

  /// Places SVGs randomly within the context bounds while ensuring they don't overlap.
  void _placeSvgs() {
    final contextSize = (context.findRenderObject()! as RenderBox).size;
    final maxSvgs = _calculateMaxSvgs(contextSize);
    final actualCount = min(widget.count, maxSvgs);
    var attempts = 0;
    const maxAttempts = 100;

    while (svgDataList.length < actualCount && attempts < maxAttempts) {
      final svgData = _generateRandomSvgData(contextSize);
      if (_isUniquePosition(svgData)) {
        svgDataList.add(svgData);
        attempts = 0;
      } else {
        attempts++;
      }
    }

    setState(() {}); // Trigger a rebuild with the placed SVGs
  }

  /// Generates random SVG data including the path, size, and position.
  Map<String, dynamic> _generateRandomSvgData(Size size) {
    final random = Random();
    final svgs = switch (widget.variant) {
      SvgVariants.mixed => Assets.shapes.variantOneColored.values,
      SvgVariants.simple => Assets.shapes.variantTwoUncolored.values,
      SvgVariants.threed => Assets.shapes.variantThree3d.values,
    };
    final svgPath = svgs.elementAt(random.nextInt(svgs.length)).path;
    final svgSize = random.nextDouble() * (widget.maxSize - widget.minSize) + widget.minSize;

    final position = Offset(
      random.nextDouble() * (size.width - svgSize),
      random.nextDouble() * (size.height - svgSize),
    );

    return {'path': svgPath, 'size': svgSize, 'position': position};
  }

  /// Calculates the maximum number of SVGs that can fit in the given size.
  int _calculateMaxSvgs(Size size) {
    final averageSize = (widget.minSize + widget.maxSize) / 2;
    return (size.width * size.height / (averageSize * averageSize)).floor();
  }

  /// Builds a widget for an individual SVG based on its data.
  Widget _buildSvg(Map<String, dynamic> svgData) {
    return Positioned(
      left: svgData['position'].dx,
      top: svgData['position'].dy,
      child: SvgPicture.asset(
        '../infrastructure/design/${svgData['path']}',
        colorFilter: widget.variant == SvgVariants.simple || widget.variant == SvgVariants.threed
            ? ColorFilter.mode(widget.color ?? context.theme.colorScheme.onBackground, BlendMode.srcIn)
            : null,
        width: svgData['size'],
        height: svgData['size'],
      ),
    );
  }

  /// Checks if the new SVG's position is unique and doesn't overlap with existing ones.
  bool _isUniquePosition(Map<String, dynamic> newSvgData) {
    for (final svgData in svgDataList) {
      if (_checkCollision(svgData, newSvgData)) {
        return false;
      }
    }
    return true;
  }

  /// Checks if two SVGs overlap based on their positions and sizes.
  bool _checkCollision(Map<String, dynamic> svg1, Map<String, dynamic> svg2) {
    final x1 = svg1['position'].dx;
    final y1 = svg1['position'].dy;
    final size1 = svg1['size'];
    final x2 = svg2['position'].dx;
    final y2 = svg2['position'].dy;
    final size2 = svg2['size'];

    return (x1 < x2 + size2) && (x1 + size1 > x2) && (y1 < y2 + size2) && (y1 + size1 > y2);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...svgDataList.map(_buildSvg),
        widget.child,
      ],
    );
  }
}
