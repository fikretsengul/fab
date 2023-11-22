import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Applies a BlendMode to its child.
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
      .._blendMode = _blendMode
      .._opacity = _opacity;
  }
}

class RenderBlendMask extends RenderProxyBox {
  RenderBlendMask(BlendMode blendMode, double opacity)
      : _blendMode = blendMode,
        _opacity = opacity;
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

    // Composite the layer back into the canvas using the blendmode:
    context.canvas.restore();
  }
}
