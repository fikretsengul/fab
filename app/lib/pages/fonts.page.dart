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
    return const Scaffold(
      body: Placeholder(),
    );
  }
}
