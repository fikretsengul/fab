import 'package:flutter/widgets.dart';

abstract class Snap {
  factory Snap(
    double extent, {
    double? distance = 10,
    double? trailingDistance,
    double? leadingDistance,
  }) =>
      _SnapPoint(
        extent,
        toleranceDistance: distance,
        trailingToleranceDistance: trailingDistance,
        leadingToleranceDistance: leadingDistance,
      );

  factory Snap.avoidZone(
    double minExtent,
    double maxExtent, {
    double? delimiter,
  }) = _PreventSnapArea;

  bool shouldApplyFor(ScrollMetrics position, double proposedEnd);

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  );
}

class _SnapPoint implements Snap {
  _SnapPoint(
    this.extent, {
    double? toleranceDistance,
    double? trailingToleranceDistance,
    double? leadingToleranceDistance,
  })  : leadingExtent = extent - (leadingToleranceDistance ?? toleranceDistance ?? 0),
        trailingExtent = extent + (trailingToleranceDistance ?? toleranceDistance ?? 0);
  final double extent;
  final double trailingExtent;
  final double leadingExtent;

  @override
  bool shouldApplyFor(ScrollMetrics position, double proposedEnd) {
    return proposedEnd > leadingExtent && proposedEnd < trailingExtent;
  }

  @override
  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  ) {
    return extent;
  }
}

class _PreventSnapArea implements Snap {
  _PreventSnapArea(this.minExtent, this.maxExtent, {double? delimiter})
      : assert(
          delimiter == null || (delimiter >= minExtent) && (delimiter <= maxExtent),
          'The delimiter value should be between the minExtent and maxExtent',
        ),
        delimiter = delimiter ?? (minExtent + (maxExtent - minExtent) / 2);
  final double minExtent;
  final double maxExtent;
  final double delimiter;

  @override
  bool shouldApplyFor(ScrollMetrics position, double proposedEnd) {
    return proposedEnd > minExtent && proposedEnd < maxExtent;
  }

  @override
  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  ) {
    if (delimiter < proposedEnd) {
      return maxExtent;
    } else {
      return minExtent;
    }
  }
}
