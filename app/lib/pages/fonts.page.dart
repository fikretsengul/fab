import 'package:deps/design/design.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FontsPage extends StatelessWidget {
  const FontsPage({
    this.title = '',
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DottedBackground(
        shape: DotsShape.texture,
        child: RandomSvgBackground(
          count: 3,
          child: Center(
            child: FabContainer(
              margin: Paddings.sm.all,
              padding: Paddings.sm.all,
              child: const Column(),
            ),
          ),
        ),
      ),
    );
  }
}
