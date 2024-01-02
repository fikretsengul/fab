import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import '../extensions/context_ext.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(
          context.router.topRoute.title(context),
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: const Placeholder(),
    );
  }
}
