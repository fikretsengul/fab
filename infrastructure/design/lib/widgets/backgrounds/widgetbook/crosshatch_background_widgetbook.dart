import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

import '../crosshatch_background.dart';

// ignore: avoid_returning_widgets
@UseCase(
  name: 'Crosshatch Background',
  type: CrosshatchBackground,
)
Widget crosshatchBackground(BuildContext context) {
  return CrosshatchBackground(
    featuresCount: context.knobs.int.input(
      label: 'Features Count',
      initialValue: 10,
    ),
    strokeWidth: context.knobs.double.slider(
      label: 'Stroke Width',
      initialValue: 1,
    ),
    shape: context.knobs.list(
      label: 'Shape',
      options: CrosshatchShape.values,
      labelBuilder: (o) => o.name.capitalizeFirst(),
    ),
    bgColor: context.knobs.color(
      label: 'Background Color',
      initialValue: context.background,
    ),
    fgColor: context.knobs.color(
      label: 'Foreground Color',
      initialValue: context.onBackground,
    ),
  );
}
