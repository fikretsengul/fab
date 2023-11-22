import 'package:deps/core/commons/extensions.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

import '../dotted_background.dart';

// ignore: avoid_returning_widgets
@UseCase(
  name: 'Dotted Background',
  type: DottedBackground,
)
Widget dottedBackground(BuildContext context) {
  return DottedBackground(
    rowCount: context.knobs.int.slider(
      label: 'Row Count',
      initialValue: 20,
      min: 1,
      max: 50,
    ),
    columnCount: context.knobs.int.slider(
      label: 'Column Count',
      initialValue: 15,
      min: 1,
      max: 50,
    ),
    shapeSize: context.knobs.double.slider(
      label: 'Shape Size',
      initialValue: 1,
    ),
    shape: context.knobs.list(
      label: 'Shape',
      options: DotsShape.values,
      labelBuilder: (o) => o.name.capitalizeFirst(),
    ),
    bgColor: context.knobs.color(
      label: 'Background Color',
      initialValue: context.background,
    ),
    evenColor: context.knobs.color(
      label: 'Even Shape Color',
      initialValue: context.onBackground,
    ),
    oddColor: context.knobs.color(
      label: 'Odd Shape Color',
      initialValue: Colors.grey,
    ),
    padding: context.knobs.double.input(
      label: 'Padding',
      initialValue: 10,
    ),
  );
}
