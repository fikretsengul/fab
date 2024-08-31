/* import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///@author Evan
///@since 2019-11-22
///@describe: 自定义物理滑动吸附功能
///
class SnapScrollPhysics extends ScrollPhysics {
  const SnapScrollPhysics({
    super.parent,
    this.snapHeight,
    this.friction = 0.015,
  });

  /// 吸附高度
  final double? snapHeight;

  /// 减速系数
  final double friction;

  @override
  SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnapScrollPhysics(
      parent: buildParent(ancestor),
      snapHeight: snapHeight,
      friction: friction,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    if (position is ScrollPosition) {
      final target = _getTargetPixels(position, velocity);
      if (target != position.pixels) {
        return ScrollSpringSimulation(
          spring,
          position.pixels,
          target,
          velocity,
          tolerance: tolerance,
        );
      }
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;

  double _getTargetPixels(ScrollPosition position, double velocity) {
    final snapHeight = this.snapHeight ?? position.viewportDimension;
    final scrollUp = position.userScrollDirection == ScrollDirection.reverse;

    var distance = .0;
    // 当移动到snapHeight开始考虑滑动惯性了
    if (position.pixels > snapHeight) {
      final duration = _flingDuration(velocity);
      distance = (velocity * duration / _initialVelocityPenetration).abs();
    }
    distance = position.pixels + (scrollUp ? distance : -distance);
    // 限制上滑超越snapHeight
    if (position.pixels > snapHeight && distance < snapHeight) {
      distance = snapHeight;
    }
    double targetPixel;
    final isFiling = velocity.abs() > minFlingVelocity.abs();
    if (distance > 0 && distance < snapHeight) {
      if (isFiling) {
        targetPixel = scrollUp ? snapHeight : 0;
      } else {
        targetPixel = distance > snapHeight / 2 ? snapHeight : 0;
      }
    } else {
      targetPixel = distance;
    }
    targetPixel = targetPixel.clamp(position.minScrollExtent, position.maxScrollExtent);
    return targetPixel;
  }

  static const double _initialVelocityPenetration = 3.065 + 3;

  /// 模拟计算减速时间
  double _flingDuration(double velocity) {
    final scaledFriction = friction * _decelerationForFriction(0.84);
    final deceleration = math.log(0.35 * velocity.abs() / scaledFriction);

    return math.exp(deceleration / (_kDecelerationRate - 1.0));
  }

  static final double _kDecelerationRate = math.log(0.78) / math.log(0.9);

  static double _decelerationForFriction(double friction) {
    return friction * 61774.04968;
  }
}
 */