import 'package:deps/design/design.dart';
import 'package:flutter/material.dart';

class FontsPage extends StatelessWidget {
  const FontsPage({
    this.title = '',
    super.key,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FabAppBar(title: 'Fonts'),
      body: DottedBackground(
        shape: DotsShape.texture,
        child: RandomSvgBackground(
          count: 5,
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
