import 'package:deps/core/commons/helpers.dart';
import 'package:deps/packages/widgetbook_annotation.dart';
import 'package:flutter/material.dart';

import '../fab_container.dart';

// ignore: avoid_returning_widgets
@UseCase(
  name: 'FAB Container',
  type: FabContainer,
)
Widget fabContainer() {
  return FabContainer(
    margin: Paddings.md.horizontal,
  );
}
