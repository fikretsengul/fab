import 'dart:math';
import 'dart:ui';

import '../../../../constants/assets.gen.dart';
import '../../random_svg_background.dart';

class SVGItem {
  SVGItem({required this.path, required this.size, required this.position});

  final String path;
  final double size;
  final Offset position;
}

class SvgItemManager {
  SvgItemManager({
    required this.maxSize,
    required this.minSize,
    required this.variant,
    this.color,
  });

  final double maxSize;
  final double minSize;
  final SvgVariants variant;
  final Color? color;
  final Random random = Random();

  SVGItem generateRandomSvgItem(Size size) {
    final random = Random();
    final svgs = switch (variant) {
      SvgVariants.mixed => Assets.shapes.variantOneColored.values,
      SvgVariants.simple => Assets.shapes.variantTwoUncolored.values,
      SvgVariants.threed => Assets.shapes.variantThree3d.values,
    };
    final svgPath = svgs.elementAt(random.nextInt(svgs.length)).path;
    final svgSize = random.nextDouble() * (maxSize - minSize) + minSize;

    final position = Offset(
      random.nextDouble() * (size.width - svgSize),
      random.nextDouble() * (size.height - svgSize),
    );

    return SVGItem(
      path: svgPath,
      size: svgSize,
      position: position,
    );
  }

  bool isUniquePosition(List<SVGItem> svgItemList, SVGItem newSvgItem) {
    for (final svgItem in svgItemList) {
      if (doesOverlap(svgItem, newSvgItem)) {
        return false;
      }
    }

    return true;
  }

  int calculateMaxSvgs(Size size) {
    final averageSize = (minSize + maxSize) / 2;

    return (size.width * size.height / (averageSize * averageSize)).floor();
  }

  bool doesOverlap(SVGItem svg1, SVGItem svg2) {
    final x1 = svg1.position.dx;
    final y1 = svg1.position.dy;
    final size1 = svg1.size;
    final x2 = svg2.position.dx;
    final y2 = svg2.position.dy;
    final size2 = svg2.size;

    return (x1 < x2 + size2) && (x1 + size1 > x2) && (y1 < y2 + size2) && (y1 + size1 > y2);
  }
}
