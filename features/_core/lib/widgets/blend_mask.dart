// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A widget that applies a blend mode to its child.
///
/// This widget creates an effect by blending its child with the widget behind it
/// according to the specified [BlendMode].
class BlendMask extends SingleChildRenderObjectWidget {
  const BlendMask({
    required BlendMode blendMode,
    required Widget super.child,
    double opacity = 1.0,
    super.key,
  })  : _blendMode = blendMode,
        _opacity = opacity;

  final BlendMode _blendMode;
  final double _opacity;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBlendMask(_blendMode, _opacity);
  }

  @override
  void updateRenderObject(BuildContext context, RenderBlendMask renderObject) {
    renderObject
      ..blendMode = _blendMode
      ..opacity = _opacity;
  }
}

class RenderBlendMask extends RenderProxyBox {
  RenderBlendMask(BlendMode blendMode, double opacity)
      : _blendMode = blendMode,
        _opacity = opacity;

  BlendMode get blendMode => _blendMode;
  double get opacity => _opacity;

  set blendMode(BlendMode value) {
    if (_blendMode != value) {
      _blendMode = value;
      markNeedsPaint();
    }
  }

  set opacity(double value) {
    if (_opacity != value) {
      _opacity = value;
      markNeedsPaint();
    }
  }

  BlendMode _blendMode;
  double _opacity;

  @override
  void paint(PaintingContext context, Offset offset) {
    // Create a new layer and specify the blend mode and opacity to composite it with:
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = _blendMode
        ..color = Color.fromARGB((_opacity * 255).round(), 255, 255, 255),
    );

    super.paint(context, offset);

    // Composite the layer back into the canvas using the blend mode:
    context.canvas.restore();
  }
}
