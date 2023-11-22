import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

import '../checkers_background.dart';

// ignore: avoid_returning_widgets
@UseCase(
  name: 'Checkers Background',
  type: CheckersBackground,
)
Widget checkersBackground(BuildContext context) {
  return CheckersBackground(
    featuresCount: context.knobs.int.input(
      label: 'Features Count',
      initialValue: 10,
    ),
    pattern: context.knobs.list(
      label: 'Pattern',
      options: CheckerPattern.values,
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
